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

// .__  _____ 
// |__|/ ____\
// |  \   __\ 
// |  ||  |   
// |__||__|   

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
wire [31:0] mem_pc_addr0;
wire mem_is_branch_jump;

PC_BRANCH_MUX pc_branch_mux(
    .pcbranchmuxin_pc_addr0(pc_addr0),
    .pcbranchmuxin_pc_addr1(pc_addr1),
    .pcbranchmuxin_mem_pc_addr0(mem_pc_addr0),
    .sel(pc_src[1]),
    .branchjumpdetectin_mem_is_branch_jump(mem_is_branch_jump),
    .pcbranchmuxout_pc_new(pc_new)
);

MUX2T1_32 pc_mux2(
    .in_data_1(pc_new),
    .in_data_2(pc_addr1),
    .sel(pc_src[0]),
    .out_data(pc_new2)
);

// pc_src[1] : choose pc_addr0 (pc+4) or pc_addr1 (branch)
// pc_src[0] : choose pc_new or pc_addr1 (jump)

wire pc_write;

wire ex_is_branch_jump;
PC pc(
    .clk(clk),
    .rst(rst),
    .pc_write(pc_write),
    .addr(pc_new2),
    .new_addr(pc_out)
);

wire [31:0] if_inst_modified;
MUX2T1_32 if_inst_mux(
    .in_data_1(inst_in),
    .in_data_2(32'h00000013),
    .sel(mem_is_branch_jump),
    .out_data(if_inst_modified)
);

wire[31:0] id_inst_orig;
wire[31:0] id_pc_out;
wire[31:0] id_pc_addr0;
wire ifid_write;

IFIDREG ifidreg(
    .clk(clk),
    .rst(rst),
    .ifidin_pc_out(pc_out),
    .ifidin_inst(if_inst_modified),
    .ifidin_pc_addr0(pc_addr0),
    .ifidin_ifid_write(ifid_write),

    .ifidout_inst(id_inst_orig),
    .ifidout_pc_out(id_pc_out),
    .ifidout_id_pc_addr0(id_pc_addr0)
);

// .__    .___
// |__| __| _/
// |  |/ __ | 
// |  / /_/ | 
// |__\____ | 
//         \/

wire [31:0] id_rs1_data;
wire [31:0] id_rs2_data;
wire [4:0] id_rs1_addr;
wire [4:0] id_rs2_addr;
wire [4:0] id_rd_addr;
wire [4:0] wb_rd_addr;
wire [31:0] wb_rd_data;

wire [31:0] id_inst;
ID_INST_MUX id_inst_mux(
    .idpcmuxin_id_inst_orig(id_inst_orig),
    .idpcmuxin_ex_is_branch_jump(ex_is_branch_jump),
    .idpcmuxin_mem_is_branch_jump(mem_is_branch_jump),
    .idpcmuxout_id_inst(id_inst)
);


assign id_rs1_addr = id_inst[19:15];
assign id_rs2_addr = id_inst[24:20];
assign id_rd_addr = id_inst[11:7];

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
    .op_code(id_inst[6:0]),
    .funct3(id_inst[14:12]),
    .funct7_5(id_inst[30]),

    .id_ex(id_EX),      // 2'b00 reg[dr]<---ALU_result, 2'b01 reg[dr]<---imm, 2'b10 reg[dr]<---pc+4, 2'b11 reg[dr]<----data memory
    .id_m(id_M),        // 1'b1 mem_write_enable
    .id_wb(id_WB)       // 1'b1 reg_write_enable
);

wire idex_zero;
wire [31:0] ex_inst;
wire [4:0] ex_rd_addr;

RAW_HAZARD_UNIT raw_hazard_unit(
    .rawhazardin_id_rs1_addr(id_rs1_addr),
    .rawhazardin_id_rs2_addr(id_rs2_addr),
    .rawhazardin_ex_rd_addr(ex_rd_addr),
    .rawhazardin_ex_inst(ex_inst),
    .rawhazardout_pc_write(pc_write),
    .rawhazardout_ifid_write(ifid_write),
    .rawhazardout_idex_zero(idex_zero)
);

wire [4:0] idex_EX;
wire [2:0] idex_M;
wire [2:0] idex_WB;

ID_IDEX_SIGNAL id_idex_signal(
    .ididexsignalin_id_EX(id_EX),
    .ididexsignalin_id_M(id_M),
    .ididexsignalin_id_WB(id_WB),
    .ididexsignalin_idex_zero(idex_zero),

    .ididexsignalout_idex_EX(idex_EX),
    .ididexsignalout_idex_M(idex_M),
    .ididexsignalout_idex_WB(idex_WB)
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
    .inst(id_inst),
    .im(id_imm)
);

wire [3:0] id_alu_op;
ALUOP aluop (
    .inst(id_inst),
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
wire [31:0] ex_pc_addr0;

IDEXREG idereg(
    .clk(clk),
    .rst(rst),
    .idexin_ex(idex_EX),
    .idexin_m(idex_M),
    .idexin_wb(idex_WB),
    .idexin_id_pc_out(id_pc_out),
    .idexin_id_rs1_data(id_rs1_data),
    .idexin_id_rs2_data(id_rs2_data),
    .idexin_id_imm(id_imm),
    .idexin_id_alu_op(id_alu_op),
    .idexin_id_rd_addr(id_rd_addr),
    .idexin_id_pc_addr0(id_pc_addr0),
    .idexin_id_inst(id_inst),
    .idexin_ex_is_branch_jump(ex_is_branch_jump),
    .idexin_mem_is_branch_jump(mem_is_branch_jump),

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

//   ____ ___  ___
// _/ __ \\  \/  /
// \  ___/ >    < 
//  \___  >__/\_ \
//      \/      \/

// calculate next pc for branch and jump
wire [31:0] ex_add_result;
wire [31:0] ex_mux_rs1_data;
EXADD ex_add(
    .ex_pc_out(ex_pc_out),
    .ex_imm(ex_imm),
    .ex_rs1_data(ex_mux_rs1_data),
    .ex_inst(ex_inst),
    .ex_add_result(ex_add_result)
);

BRANCH_JUMP_DETECT ex_branch_jump_detect(
    .branchjumpdetectin_inst(ex_inst),
    .branchjumpdetectout_is_branch_jump(ex_is_branch_jump)
);

wire [1:0] forward_rs1;
wire [1:0] forward_rs2;
wire [4:0] mem_rd_addr;
wire [2:0] mem_WB;
wire [2:0] wb_WB;

FORWARDING_UNIT forwarding_unit(
    .forwardin_ex_rs1_addr(ex_inst[19:15]),
    .forwardin_ex_rs2_addr(ex_inst[24:20]),
    .forwardin_mem_rd_addr(mem_rd_addr),
    .forwardin_wb_rd_addr(wb_rd_addr),
    .forwardin_mem_WB(mem_WB),
    .forwardin_wb_WB(wb_WB),

    .forwardout_rs1(forward_rs1),
    .forwardout_rs2(forward_rs2)
);

MUX4T1_32 ex_mux_rs1(
    .data_in_0(ex_rs1_data),
    .data_in_1(wb_rd_data),
    .data_in_2(mem_alu_result),
    .data_in_3(32'b0),
    .sel(forward_rs1),
    .data_out(ex_mux_rs1_data)
);

wire [31:0] ex_mux_rs2_data;
wire [31:0] mem_alu_result;
MUX4T1_32 ex_mux_rs2(
    .data_in_0(ex_rs2_data),
    .data_in_1(wb_rd_data),
    .data_in_2(mem_alu_result),
    .data_in_3(32'b0),
    .sel(forward_rs2),
    .data_out(ex_mux_rs2_data)
);

wire [31:0] ex_alu2_mux_result;
MUX2T1_32 ex_alu2_mux(
    .in_data_1(ex_mux_rs2_data),
    .in_data_2(ex_imm),
    .sel(ex_EX[4]),
    .out_data(ex_alu2_mux_result)
);

wire [3:0] ex_alu_op_result;
ALUCONTROL ex_alucontrol(
    .ALU_op(ex_alu_op),
    .my_ALU_op(ex_alu_op_result)
);

wire [31:0] ex_alu_result;
wire ex_zero;
ALU ex_alu(
    .a(ex_mux_rs1_data),
    .b(ex_alu2_mux_result),
    .alu_op(ex_alu_op_result),
    .inst(ex_inst),
    .res(ex_alu_result),
    .zero(ex_zero)
);


wire [2:0] mem_M;
wire [31:0] mem_rs2_data;
wire [31:0] mem_imm;
wire [31:0] mem_inst;
wire [31:0] mem_pc_out;
wire mem_zero;

EXMEMREG exmemreg(
    .clk(clk),
    .rst(rst),
    .exmemin_m(ex_M),
    .exmemin_wb(ex_WB),
    .exmemin_ex_add_result(ex_add_result),
    .exmemin_ex_zero(ex_zero),
    .exmemin_ex_alu_result(ex_alu_result),
    .exmemin_ex_rs2_data(ex_mux_rs2_data),
    .exmemin_ex_rd_addr(ex_rd_addr),
    .exmemin_ex_imm(ex_imm),
    .exmemin_ex_pc_addr0(ex_pc_addr0),
    .exmemin_ex_inst(ex_inst),
    .exmemin_ex_pc_out(ex_pc_out),

    .exmemout_m(mem_M),
    .exmemout_wb(mem_WB),
    .exmemout_pc_addr1(pc_addr1),
    .exmemout_mem_alu_result(mem_alu_result),
    .exmemout_mem_rs2_data(mem_rs2_data),
    .exmemout_mem_rd_addr(mem_rd_addr),
    .exmemout_mem_imm(mem_imm),
    .exmemout_mem_zero(mem_zero),
    .exmemout_mem_pc_addr0(mem_pc_addr0),
    .exmemout_mem_inst(mem_inst),
    .exmemout_mem_pc_out(mem_pc_out)
);

//   _____   ____   _____  
//  /     \_/ __ \ /     \ 
// |  Y Y  \  ___/|  Y Y  \
// |__|_|  /\___  >__|_|  /
//       \/     \/      \/

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
        pc_src1_reg <= 1'b0;
    end
end


BRANCH_JUMP_DETECT mem_branch_jump_detect(
    .branchjumpdetectin_inst(mem_inst),
    .branchjumpdetectout_is_branch_jump(mem_is_branch_jump)
);

PCSRC0GEN mem_pc_src0_gen(
    .inst(mem_inst),
    .pc_src0(pc_src[0])
);

assign pc_src[1] = pc_src1_reg;
assign addr_out = mem_alu_result;
assign data_out = mem_rs2_data;
assign mem_write = mem_M[0];

wire [31:0] wb_data_in;
wire [31:0] wb_alu_result;
wire [31:0] wb_imm;
wire [31:0] wb_pc_addr0;
wire [31:0] wb_inst;
wire [31:0] wb_pc_out;

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
    .memwbin_mem_pc_out(mem_pc_out),

    .memwbout_wb_wb(wb_WB),
    .memwbout_wb_data_in(wb_data_in),
    .memwbout_wb_alu_result(wb_alu_result),
    .memwbout_wb_imm(wb_imm),
    .memwbout_wb_rd_addr(wb_rd_addr),
    .memwbout_wb_pc_addr0(wb_pc_addr0),
    .memwbout_wb_inst(wb_inst),
    .memwbout_wb_pc_out(wb_pc_out)
);

//         ___.    
// __  _  _\_ |__  
// \ \/ \/ /| __ \ 
//  \     / | \_\ \
//   \/\_/  |___  /
//              \/ 

MUX4T1_32 wb_mux(
    .data_in_0(wb_alu_result),
    .data_in_1(wb_imm),
    .data_in_2(wb_pc_addr0),
    .data_in_3(wb_data_in),
    .sel(wb_WB[1:0]),
    .data_out(wb_rd_data)
);

endmodule
