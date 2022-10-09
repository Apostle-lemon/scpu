module Datapath(
    input clk,
    input rst,

    input [31:0] inst_in,
    input [31:0] data_in,            // data from data memory

    // output
    output [31:0] addr_out,          // data memory address    
    output [31:0] data_out,          // data to data memory
    output [31:0] pc_out,             // program counter
    output mem_write,


    input [4:0] debug_reg_addr,
    output [31:0] debug_reg_data
);

//
//
// IF stage
// 
//

wire [31:0] pc_addr0;
wire [31:0] pc_addr1;
wire [31:0] pc_new;
wire [31:0] pc_new2;

ADD pc_add(
    .in_data_1(pc_out),
    .in_data_2(4),
    .out_data(pc_addr0)
);


wire[1:0] pc_src;

MUX2T1_32 pc_mux(
    .in_data_1(pc_addr0),
    .in_data_2(pc_addr1),
    .sel(pc_src[1]),
    .out_data(pc_new)
);

MUX2T1_32 pc_mux2(
    .in_data_1(pc_new),
    .in_data_2(pc_addr1),
    .sel(pc_src[0]),
    .out_data(pc_new2)
);

// pc_src[1] : choose pc_addr0 (pc+4) or pc_addr1 (branch)
// pc_src[0] : choose pc_new or pc_addr1 (jump)

PC pc(
    .clk(clk),
    .rst(rst),
    .addr(pc_new2),
    .new_addr(pc_out)
);

wire[31:0] id_instruction;
wire[31:0] id_pc_out;
wire[31:0] id_pc_addr0;

IFIDREG ifidreg(
    .clk(clk),
    .rst(rst),
    .ifidin_pc_out(pc_out),
    .ifidin_inst(inst_in),
    .ifidin_pc_addr0(pc_addr0),

    .ifidout_inst(id_instruction),
    .ifidout_pc_out(id_pc_out),
    .ifidout_id_pc_addr0(id_pc_addr0)
);

// 
//
// ID stage
// 
// 

wire [31:0] id_rs1_data;
wire [31:0] id_rs2_data;

wire [4:0] id_rs1_addr;
wire [4:0] id_rs2_addr;
wire [4:0] id_rd_addr;

wire [4:0] wb_rd_addr;
wire [31:0] wb_rd_data;

assign id_rs1_addr = id_instruction[19:15];
assign id_rs2_addr = id_instruction[24:20];
assign id_rd_addr = id_instruction[11:7];


wire [4:0] id_EX;          // id_EX = { alu_src[4], alu_op[3:0] }
wire [2:0] id_M;           // id_M = { branch[2], b_type[1], mem_write[0] }
wire [2:0] id_WB;          // id_WB = { reg_write[2], mem_to_reg[1:0] }

// branch : 1'b1 is branch, 1'b0 not branch
// b_type : 1'b1 beq, 1'b0 bnq
// mem_write : 1'b1 mem_write_enable
// alu_src : 1'b1 alu_b<----imm, 1'b0 alu_b<----Reg[rs2]
// alu_op : see the file
// reg_write : 1'b1 reg_write_enable
// mem_to_reg : 2'b00 reg[dr]<---ALU_result, 2'b01 reg[dr]<---imm, 2'b10 reg[dr]<---pc+4, 2'b11 reg[dr]<----data memory
// jump : we pass the instruction to mem stage 

CONTROL control ( 
    .op_code(id_instruction[6:0]),
    .funct3(id_instruction[14:12]),
    .funct7_5(id_instruction[30]),

    .id_ex(id_EX),      // 2'b00 reg[dr]<---ALU_result, 2'b01 reg[dr]<---imm, 2'b10 reg[dr]<---pc+4, 2'b11 reg[dr]<----data memory
    .id_m(id_M),        // 1'b1 mem_write_enable
    .id_wb(id_WB)       // 1'b1 reg_write_enable
);

REGS regs(
    .clk(clk),
    .rst(rst),
    .we(wb_WB[2]),
    .read_addr_1(id_rs1_addr),
    .read_addr_2(id_rs2_addr),
    .write_addr(wb_rd_addr),
    .write_data(wb_rd_data),
    .read_data_1(id_rs1_data),
    .read_data_2(id_rs2_data),
    .debug_reg_addr(debug_reg_addr),
    .debug_reg_data(debug_reg_data)
);

wire [31:0] id_imm;
ImmGen immgen(
    .inst(id_instruction),
    .im(id_imm)
);

wire [3:0] id_alu_op;
ALUOP aluop (
    .inst(id_instruction),
    .alu_op(id_alu_op)
);

wire [4:0] ex_EX;
wire [2:0] ex_M;
wire [2:0] ex_WB;
wire [31:0] ex_pc_out;
wire [31:0] ex_rs1_data;
wire [31:0] ex_rs2_data;
wire [31:0] ex_imm;
wire [3:0] ex_alu_op;
wire [4:0] ex_rd_addr;
wire [31:0] ex_pc_addr0;
wire [31:0] ex_inst;

IDEXREG idereg(
    .clk(clk),
    .rst(rst),
    .idexin_ex(id_EX),
    .idexin_m(id_M),
    .idexin_wb(id_WB),
    .idexin_id_pc_out(id_pc_out),
    .idexin_id_rs1_data(id_rs1_data),
    .idexin_id_rs2_data(id_rs2_data),
    .idexin_id_imm(id_imm),
    .idexin_id_alu_op(id_alu_op),
    .idexin_id_rd_addr(id_rd_addr),
    .idexin_id_pc_addr0(id_pc_addr0),
    .idexin_id_inst(id_instruction),

    .idexout_ex(ex_EX),
    .idexout_m(ex_M),
    .idexout_wb(ex_WB),
    .idexout_ex_pc_out(ex_pc_out),
    .idexout_ex_rs1_data(ex_rs1_data),
    .idexout_ex_rs2_data(ex_rs2_data),
    .idexout_ex_imm(ex_imm),
    .idexout_ex_alu_op(ex_alu_op),
    .idexout_ex_rd_addr(ex_rd_addr),
    .idexout_ex_pc_addr0(ex_pc_addr0),
    .idexout_ex_inst(ex_inst)
);

// 
// 
// EX stage
// 
// 

// calculate next pc for branch and jump
wire [31:0] ex_add_result;
EXADD ex_add(
    .ex_pc_out(ex_pc_out),
    .ex_imm(ex_imm),
    .ex_rs1_data(ex_rs1_data),
    .ex_inst(ex_inst),
    .ex_add_result(ex_add_result)
);

wire [31:0] ex_mux_result;
MUX2T1_32 ex_mux(
    .in_data_1(ex_rs2_data),
    .in_data_2(ex_imm),
    .sel(ex_EX[4]),
    .out_data(ex_mux_result)
);

wire [3:0] ex_alu_op_result;
ALUCONTROL ex_alucontrol(
    .ALU_op(ex_alu_op),
    .my_ALU_op(ex_alu_op_result)
);

wire [31:0] ex_alu_result;
wire ex_zero;
ALU ex_alu(
    .a(ex_rs1_data),
    .b(ex_mux_result),
    .alu_op(ex_alu_op_result),
    .res(ex_alu_result),
    .zero(ex_zero)
);


wire [2:0] mem_M;
wire [2:0] mem_WB;
wire [31:0] mem_alu_result;
wire [31:0] mem_rs2_data;
wire [4:0] mem_rd_addr;
wire [31:0] mem_imm;
wire [31:0] mem_pc_addr0;
wire [31:0] mem_inst;
wire mem_zero;

EXMEMREG exmemreg(
    .clk(clk),
    .rst(rst),
    .exmemin_m(ex_M),
    .exmemin_wb(ex_WB),
    .exmemin_ex_add_result(ex_add_result),
    .exmemin_ex_zero(ex_zero),
    .exmemin_ex_alu_result(ex_alu_result),
    .exmemin_ex_rs2_data(ex_rs2_data),
    .exmemin_ex_rd_addr(ex_rd_addr),
    .exmemin_ex_imm(ex_imm),
    .exmemin_ex_pc_addr0(ex_pc_addr0),
    .exmemin_ex_inst(ex_inst),

    .exmemout_m(mem_M),
    .exmemout_wb(mem_WB),
    .exmemout_pc_addr1(pc_addr1),
    .exmemout_mem_alu_result(mem_alu_result),
    .exmemout_mem_rs2_data(mem_rs2_data),
    .exmemout_mem_rd_addr(mem_rd_addr),
    .exmemout_mem_imm(mem_imm),
    .exmemout_mem_zero(mem_zero),
    .exmemout_mem_pc_addr0(mem_pc_addr0),
    .exmemout_mem_inst(mem_inst)
);

// 
// 
// MEM stage
// 
// 

// b_type and beq or not (b_type and bne) 
reg pc_src1_reg;
always @ (*) begin 
    if (mem_M[2] == 1'b1) begin
        // branch instruction
        if (mem_M[1] == 1'b1) begin
            // beq
            if(mem_zero == 1'b1) begin
                pc_src1_reg <= 1'b1;
            end
            else begin
                pc_src1_reg <= 1'b0;
            end
        end else begin
            // bne
            if(mem_zero == 1'b0) begin
                pc_src1_reg <= 1'b1;
            end
            else begin
                pc_src1_reg <= 1'b0;
            end
        end
    end 
    else begin
        pc_src1_reg = 1'b0;
    end
end

PCSRC0GEN mem_pc_src0_gen(
    .inst(mem_inst),
    .pc_src0(pc_src[0])
);

assign pc_src[1] = pc_src1_reg;

assign addr_out = mem_alu_result;
assign data_out = mem_rs2_data;
assign mem_write = mem_M[0];

wire [2:0] wb_WB;
wire [31:0] wb_data_in;
wire [31:0] wb_alu_result;
// wire [4:0] wb_rd_addr; have declared in EX stage

wire [31:0] wb_imm;
wire [31:0] wb_pc_addr0;
wire [31:0] wb_inst;

MEMWBREG memwbreg(
    .clk(clk),
    .rst(rst),
    .memwbin_wb(mem_WB),
    .memwbin_mem_data_in(data_in),
    .memwbin_mem_alu_result(mem_alu_result),
    .memwbin_mem_rd_addr(mem_rd_addr),
    .memwbin_mem_imm(mem_imm),
    .memwbin_mem_pc_addr0(mem_pc_addr0),
    .memwbin_mem_inst(mem_inst),

    .memwbout_wb_wb(wb_WB),
    .memwbout_wb_data_in(wb_data_in),
    .memwbout_wb_alu_result(wb_alu_result),
    .memwbout_wb_imm(wb_imm),
    .memwbout_wb_rd_addr(wb_rd_addr),
    .memwbout_wb_pc_addr0(wb_pc_addr0),
    .memwbout_wb_inst(wb_inst)
);

// 
// 
// WB stage
// 
// 

MUX4T1_32 wb_mux(
    .data_in_0(wb_alu_result),
    .data_in_1(wb_imm),
    .data_in_2(wb_pc_addr0),
    .data_in_3(wb_data_in),
    .sel(wb_WB[1:0]),
    .data_out(wb_rd_data)
);

endmodule
