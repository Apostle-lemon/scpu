module IDEXREG (
    input clk,
    input rst,
    input [4:0] idexin_ex,
    input [2:0] idexin_m,
    input [2:0] idexin_wb,
    input [31:0] idexin_id_pc_out,
    input [31:0] idexin_id_rs1_data,
    input [31:0] idexin_id_rs2_data,
    input [31:0] idexin_id_imm,
    input [3:0] idexin_id_alu_op,
    input [4:0] idexin_id_rd_addr,
    input [31:0] idexin_id_pc_addr0,
    input [31:0] idexin_id_inst,
    input idexin_ex_is_branch_jump,
    input idexin_mem_is_branch_jump,

    output [4:0] idexout_ex,
    output [2:0] idexout_m,
    output [2:0] idexout_wb,
    output [31:0] idexout_ex_pc_out,
    output [31:0] idexout_ex_rs1_data,
    output [31:0] idexout_ex_rs2_data,
    output [31:0] idexout_ex_imm,
    output [3:0] idexout_ex_alu_op,
    output [4:0] idexout_ex_rd_addr,
    output [31:0] idexout_ex_pc_addr0,
    output [31:0] idexout_ex_inst
);

    reg [4:0] idexout_ex_reg;
    reg [2:0] idexout_m_reg;
    reg [2:0] idexout_wb_reg;
    reg [31:0] idexout_ex_pc_out_reg;
    reg [31:0] idexout_ex_rs1_data_reg;
    reg [31:0] idexout_ex_rs2_data_reg;
    reg [31:0] idexout_ex_imm_reg;
    reg [3:0] idexout_ex_alu_op_reg;
    reg [4:0] idexout_ex_rd_addr_reg;
    reg [31:0] idexout_ex_pc_addr0_reg;
    reg [31:0] idexout_ex_inst_reg;
    
    always @(posedge clk or posedge rst)
    begin
        if(rst) begin
            idexout_ex_reg <= 5'b0;
            idexout_m_reg <= 3'b0;
            idexout_wb_reg <= 4'b0;
            idexout_ex_pc_out_reg <= 32'b0;
            idexout_ex_rs1_data_reg <= 32'b0;
            idexout_ex_rs2_data_reg <= 32'b0;
            idexout_ex_imm_reg <= 32'b0;
            idexout_ex_alu_op_reg <= 4'b0;
            idexout_ex_rd_addr_reg <= 5'b0;
            idexout_ex_pc_addr0_reg <= 32'b0;
            idexout_ex_inst_reg <= 32'h00000013;
        end else if (idexin_ex_is_branch_jump || idexin_mem_is_branch_jump) begin
            idexout_ex_reg <= 5'b0;
            idexout_m_reg <= 3'b0;
            idexout_wb_reg <= 4'b0;
            idexout_ex_pc_out_reg <= 32'b0;
            idexout_ex_rs1_data_reg <= 32'b0;
            idexout_ex_rs2_data_reg <= 32'b0;
            idexout_ex_imm_reg <= 32'b0;
            idexout_ex_alu_op_reg <= 4'b0;
            idexout_ex_rd_addr_reg <= 5'b0;
            idexout_ex_pc_addr0_reg <= 32'b0;
            idexout_ex_inst_reg <= 32'h00000013;
        end else begin
            idexout_ex_reg <= idexin_ex;
            idexout_m_reg <= idexin_m;
            idexout_wb_reg <= idexin_wb;
            idexout_ex_pc_out_reg <= idexin_id_pc_out;
            idexout_ex_rs1_data_reg <= idexin_id_rs1_data;
            idexout_ex_rs2_data_reg <= idexin_id_rs2_data;
            idexout_ex_imm_reg <= idexin_id_imm;
            idexout_ex_alu_op_reg <= idexin_id_alu_op;
            idexout_ex_rd_addr_reg <= idexin_id_rd_addr;
            idexout_ex_pc_addr0_reg <= idexin_id_pc_addr0;
            idexout_ex_inst_reg <= idexin_id_inst;
        end
    end

    assign idexout_ex = idexout_ex_reg;
    assign idexout_m = idexout_m_reg;
    assign idexout_wb = idexout_wb_reg;
    assign idexout_ex_pc_out = idexout_ex_pc_out_reg;
    assign idexout_ex_rs1_data = idexout_ex_rs1_data_reg;
    assign idexout_ex_rs2_data = idexout_ex_rs2_data_reg;
    assign idexout_ex_imm = idexout_ex_imm_reg;
    assign idexout_ex_alu_op = idexout_ex_alu_op_reg;
    assign idexout_ex_rd_addr = idexout_ex_rd_addr_reg;
    assign idexout_ex_pc_addr0 = idexout_ex_pc_addr0_reg;
    assign idexout_ex_inst = idexout_ex_inst_reg;

endmodule