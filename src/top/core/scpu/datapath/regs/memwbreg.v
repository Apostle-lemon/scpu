module MEMWBREG (
    input clk,
    input rst,
    input [3:0] memwbin_wb,
    input [31:0] memwbin_mem_data_in,
    input [31:0] memwbin_mem_alu_result,
    input [4:0] memwbin_mem_rd_addr,

    output [3:0] memwbout_wb_wb,
    output [31:0] memwbout_wb_data_in,
    output [31:0] memwbout_wb_alu_result,
    output [4:0] memwbout_wb_rd_addr
);

    reg [3:0] memwbout_wb_wb_reg;
    reg [31:0] memwbout_wb_data_in_reg;
    reg [31:0] memwbout_wb_alu_result_reg;
    reg [4:0] memwbout_wb_rd_addr_reg;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            memwbout_wb_wb_reg <= 4'b0000;
            memwbout_wb_data_in_reg <= 32'b0;
            memwbout_wb_alu_result_reg <= 32'b0;
            memwbout_wb_rd_addr_reg <= 5'b0;
        end
        else
        begin
            memwbout_wb_wb_reg <= memwbin_wb;
            memwbout_wb_data_in_reg <= memwbin_mem_data_in;
            memwbout_wb_alu_result_reg <= memwbin_mem_alu_result;
            memwbout_wb_rd_addr_reg <= memwbin_mem_rd_addr;
        end
    end

    assign memwbout_wb_wb = memwbout_wb_wb_reg;
    assign memwbout_wb_data_in = memwbout_wb_data_in_reg;
    assign memwbout_wb_alu_result = memwbout_wb_alu_result_reg;
    assign memwbout_wb_rd_addr = memwbout_wb_rd_addr_reg;

endmodule