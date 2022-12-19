module EXMEMREG(
    input clk,
    input rst,
    input [2:0] exmemin_m,
    input [2:0] exmemin_wb,
    input [31:0] exmemin_ex_add_result,
    input exmemin_ex_zero,
    input [31:0] exmemin_ex_alu_result,
    input [31:0] exmemin_ex_rs1_data,
    input [31:0] exmemin_ex_rs2_data,
    input [4:0] exmemin_ex_rd_addr,
    input [31:0] exmemin_ex_imm,
    input [31:0] exmemin_ex_pc_addr0,
    input [31:0] exmemin_ex_inst,
    input [31:0] exmemin_ex_pc_out,
    input [31:0] exmemin_csr_output_data,

    output [2:0] exmemout_m,
    output [2:0] exmemout_wb,
    output [31:0] exmemout_pc_addr1,
    output [31:0] exmemout_mem_alu_result,
    output [31:0] exmemout_mem_rs1_data,
    output [31:0] exmemout_mem_rs2_data,
    output [4:0] exmemout_mem_rd_addr,
    output [31:0] exmemout_mem_imm,
    output [31:0] exmemout_mem_pc_addr0,
    output [31:0] exmemout_mem_inst,
    output exmemout_mem_zero,
    output [31:0] exmemout_mem_pc_out
);

    reg [2:0] exmemout_m_reg;
    reg [2:0] exmemout_wb_reg;
    reg [31:0] exmemout_pc_addr1_reg;
    reg [31:0] exmemout_mem_alu_result_reg;
    reg [31:0] exmemout_mem_rs1_data_reg;
    reg [31:0] exmemout_mem_rs2_data_reg;
    reg [4:0] exmemout_mem_rd_addr_reg;
    reg [31:0] exmemout_mem_imm_reg;
    reg [31:0] exmeout_mem_pc_addr0_reg;
    reg [31:0] exmemout_mem_inst_reg;
    reg exmeout_mem_zero_reg;
    reg [31:0] exmemout_mem_pc_out_reg;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            exmemout_m_reg <= 3'b000;
            exmemout_wb_reg <= 4'b0000;
            exmemout_pc_addr1_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_alu_result_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_rs1_data_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_rs2_data_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_rd_addr_reg <= 5'b00000;
            exmemout_mem_imm_reg <= 32'b00000000000000000000000000000000;
            exmeout_mem_pc_addr0_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_inst_reg <= 32'h00000013;
            exmeout_mem_zero_reg <= 1'b0;
            exmemout_mem_pc_out_reg <= 32'b00000000000000000000000000000000;
        end
        else
        begin
            exmemout_m_reg <= exmemin_m;
            case(exmemin_ex_inst[6:0]) 
                7'b1110011 : // 如果是 SYSTEM 指令，就设置 WB 使能
                    case (exmemin_ex_inst[11:7])
                        5'b00000 : exmemout_wb_reg <= 3'b000; // 最高位为 0，表示不写回
                        default : exmemout_wb_reg <= 3'b100; // 最高位为 1，表示写回, 00 代表选择 alu_result
                    endcase
                default : exmemout_wb_reg <= exmemin_wb; // 如果不是 SYSTEM 指令，就直接从 EXMEMIN 中读取
            endcase
            exmemout_pc_addr1_reg <= exmemin_ex_add_result;
            case(exmemin_ex_inst[6:0]) // 如果是 SYSTEM 指令，就从 CSR 模块中读取数据
                7'b1110011 : exmemout_mem_alu_result_reg <= exmemin_csr_output_data;
                default : exmemout_mem_alu_result_reg <= exmemin_ex_alu_result;
            endcase
            exmemout_mem_rs1_data_reg <= exmemin_ex_rs1_data;
            exmemout_mem_rs2_data_reg <= exmemin_ex_rs2_data;
            exmemout_mem_rd_addr_reg <= exmemin_ex_rd_addr;
            exmemout_mem_imm_reg <= exmemin_ex_imm;
            exmeout_mem_pc_addr0_reg <= exmemin_ex_pc_addr0;
            exmemout_mem_inst_reg <= exmemin_ex_inst;
            exmeout_mem_zero_reg <= exmemin_ex_zero;
            exmemout_mem_pc_out_reg <= exmemin_ex_pc_out;
        end
    end

    assign exmemout_m = exmemout_m_reg;
    assign exmemout_wb = exmemout_wb_reg;
    assign exmemout_pc_addr1 = exmemout_pc_addr1_reg;
    assign exmemout_mem_alu_result = exmemout_mem_alu_result_reg;
    assign exmemout_mem_rs1_data = exmemout_mem_rs1_data_reg;
    assign exmemout_mem_rs2_data = exmemout_mem_rs2_data_reg;
    assign exmemout_mem_rd_addr = exmemout_mem_rd_addr_reg;
    assign exmemout_mem_imm = exmemout_mem_imm_reg;
    assign exmemout_mem_pc_addr0 = exmeout_mem_pc_addr0_reg;
    assign exmemout_mem_inst = exmemout_mem_inst_reg;
    assign exmemout_mem_zero = exmeout_mem_zero_reg;
    assign exmemout_mem_pc_out = exmemout_mem_pc_out_reg;

endmodule