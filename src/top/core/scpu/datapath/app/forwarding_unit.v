module FORWARDING_UNIT (
    input [4:0] forwardin_ex_rs1_addr,
    input [4:0] forwardin_ex_rs2_addr,
    input [4:0] forwardin_mem_rd_addr,
    input [4:0] forwardin_wb_rd_addr,
    input [2:0] forwardin_mem_WB,
    input [2:0] forwardin_wb_WB,

    output [1:0] forwardout_rs1,
    output [1:0] forwardout_rs2
);

    // 00 : operand from reg
    // 10 : operand from mem_alu_result
    // 01 : operand from wb_rd_data
    // 11 : arbitary value

    reg [1:0] forward_rs1_reg;
    reg [1:0] forward_rs2_reg;

    // rs1
    always @(*) begin
        if (forwardin_mem_WB[2]==1'b1 && forwardin_mem_rd_addr != 0 && forwardin_mem_rd_addr == forwardin_ex_rs1_addr ) begin
            forward_rs1_reg = 2'b10;
        end else if (forwardin_wb_WB[2]==1'b1 && forwardin_wb_rd_addr != 0 && forwardin_wb_rd_addr == forwardin_ex_rs1_addr && ~(forwardin_mem_WB[2]==1'b1 && forwardin_mem_rd_addr != 0 && forwardin_mem_rd_addr == forwardin_ex_rs1_addr)) begin
            forward_rs1_reg = 2'b01;
        end else begin
            forward_rs1_reg = 2'b00;
        end
    end

    always @(*) begin
        if (forwardin_mem_WB[2]==1'b1 && forwardin_mem_rd_addr != 0 && forwardin_mem_rd_addr == forwardin_ex_rs2_addr ) begin
            forward_rs2_reg = 2'b10;
        end else if (forwardin_wb_WB[2]==1'b1 && forwardin_wb_rd_addr != 0 && forwardin_wb_rd_addr == forwardin_ex_rs2_addr && ~(forwardin_mem_WB[2]==1'b1 && forwardin_mem_rd_addr != 0 && forwardin_mem_rd_addr == forwardin_ex_rs2_addr)) begin
            forward_rs2_reg = 2'b01;
        end else begin
            forward_rs2_reg = 2'b00;
        end
    end

    assign forwardout_rs1 = forward_rs1_reg;
    assign forwardout_rs2 = forward_rs2_reg;

endmodule