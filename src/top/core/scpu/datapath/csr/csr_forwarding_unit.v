module CSR_FORWARDING_UNIT(
    input [4:0] forward_in_source,
    input [4:0] forwardin_mem_rd_addr,
    input [4:0] forwardin_wb_rd_addr,
    input [2:0] forwardin_mem_WB,
    input [2:0] forwardin_wb_WB,

    output [1:0] forwardout_rs1
);

// this module will generate a 2-bit signal to indicate the source of the operand

    // 00 : operand from source register
    // 01 : operand from wb
    // 10 : operand from mem
    // 11 : never used

    reg [1:0] forward_rs1_reg;
    always @(*) begin 
        if (forwardin_mem_WB[2]==1'b1 && forwardin_mem_rd_addr != 0 && forwardin_mem_rd_addr == forward_in_source ) begin
            forward_rs1_reg = 2'b10;
        end else if (forwardin_wb_WB[2]==1'b1 && forwardin_wb_rd_addr != 0 && forwardin_wb_rd_addr == forward_in_source && ~(forwardin_mem_WB[2]==1'b1 && forwardin_mem_rd_addr != 0 && forwardin_mem_rd_addr == forward_in_source)) begin
            forward_rs1_reg = 2'b01;
        end else begin
            forward_rs1_reg = 2'b00;
        end
    end

    assign forwardout_rs1 = forward_rs1_reg;

endmodule