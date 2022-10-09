module EXMEMREG(
    input clk,
    input rst,
    input [2:0] exmemin_m,
    input [2:0] exmemin_wb,
    input [31:0] exmemin_ex_add_result,
    input exmemin_ex_zero,
    input [31:0] exmemin_ex_alu_result,
    input [31:0] exmemin_ex_rs2_data,
    input [4:0] exmemin_ex_rd_addr,
    input [31:0] exmemin_ex_imm,
    input [31:0] exmemin_ex_pc_addr0,
    input [31:0] exmemin_ex_inst,

    output [2:0] exmemout_m,
    output [2:0] exmemout_wb,
    output [31:0] exmemout_pc_addr1,
    output [31:0] exmemout_mem_alu_result,
    output [31:0] exmemout_mem_rs2_data,
    output [4:0] exmemout_mem_rd_addr,
    output [31:0] exmemout_mem_imm,
    output [31:0] exmemout_mem_pc_addr0,
    output [31:0] exmemout_mem_inst,
    output exmemout_mem_zero
);

    reg [2:0] exmemout_m_reg;
    reg [2:0] exmemout_wb_reg;
    reg [31:0] exmemout_pc_addr1_reg;
    reg [31:0] exmemout_mem_alu_result_reg;
    reg [31:0] exmemout_mem_rs2_data_reg;
    reg [4:0] exmemout_mem_rd_addr_reg;
    reg [31:0] exmemout_mem_imm_reg;
    reg [31:0] exmeout_mem_pc_addr0_reg;
    reg [31:0] exmemout_mem_inst_reg;
    reg exmeout_mem_zero_reg;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            exmemout_m_reg <= 3'b000;
            exmemout_wb_reg <= 4'b0000;
            exmemout_pc_addr1_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_alu_result_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_rs2_data_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_rd_addr_reg <= 5'b00000;
            exmemout_mem_imm_reg <= 32'b00000000000000000000000000000000;
            exmeout_mem_pc_addr0_reg <= 32'b00000000000000000000000000000000;
            exmemout_mem_inst_reg <= 32'h00000013;
            exmeout_mem_zero_reg <= 1'b0;
        end
        else
        begin
            exmemout_m_reg <= exmemin_m;
            exmemout_wb_reg <= exmemin_wb;
            exmemout_pc_addr1_reg <= exmemin_ex_add_result;
            exmemout_mem_alu_result_reg <= exmemin_ex_alu_result;
            exmemout_mem_rs2_data_reg <= exmemin_ex_rs2_data;
            exmemout_mem_rd_addr_reg <= exmemin_ex_rd_addr;
            exmemout_mem_imm_reg <= exmemin_ex_imm;
            exmeout_mem_pc_addr0_reg <= exmemin_ex_pc_addr0;
            exmemout_mem_inst_reg <= exmemin_ex_inst;
            exmeout_mem_zero_reg <= exmemin_ex_zero;
        end
    end

    assign exmemout_m = exmemout_m_reg;
    assign exmemout_wb = exmemout_wb_reg;
    assign exmemout_pc_addr1 = exmemout_pc_addr1_reg;
    assign exmemout_mem_alu_result = exmemout_mem_alu_result_reg;
    assign exmemout_mem_rs2_data = exmemout_mem_rs2_data_reg;
    assign exmemout_mem_rd_addr = exmemout_mem_rd_addr_reg;
    assign exmemout_mem_imm = exmemout_mem_imm_reg;
    assign exmemout_mem_pc_addr0 = exmeout_mem_pc_addr0_reg;
    assign exmemout_mem_inst = exmemout_mem_inst_reg;
    assign exmemout_mem_zero = exmeout_mem_zero_reg;

endmodule