module CSR_UNIT(
    input csrin_write,
    input clk,
    input rst,
    input [31:0] csrin_write_data,
    input [31:0] csrin_inst,
    output [31:0] csrout_csr_data
);

// 在每次 postedg 时，读取对应 csr 的值放到 csrout_csr_data
// 在每次 negedge 时，根据 csrin_write 使能信号，确定是否写入 csr

reg [31:0] csrout_csr_data_reg;

    `include "csr_name.vh"

// parameter mtvec = 12'h305,
//           mepc  = 12'h341,
//           mstatus = 12'h300;

reg [31:0] mtvec_reg;
reg [31:0] mepc_reg;
reg [31:0] mstatus_reg;

always @(posedge clk) begin
    case(csrin_inst[31:20])
        mtvec: csrout_csr_data_reg = mtvec_reg;
        mepc: csrout_csr_data_reg = mepc_reg;
        mstatus: csrout_csr_data_reg = mstatus_reg;
        default: csrout_csr_data_reg = 32'h0;
    endcase
end

always @(negedge clk) begin
    if(csrin_write) begin
        case(csrin_inst[31:20])
            mtvec: mtvec_reg = csrin_write_data;
            mepc: mepc_reg = csrin_write_data;
            mstatus: mstatus_reg = csrin_write_data;
            default: csrout_csr_data_reg = 32'h0;
        endcase
    end
end

always @(posedge rst) begin
    mtvec_reg <= 32'h0;
    mepc_reg <= 32'h0;
    mstatus_reg <= 32'h0;
end

assign csrout_csr_data = csrout_csr_data_reg;

endmodule