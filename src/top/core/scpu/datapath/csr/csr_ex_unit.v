module CSR_EX_UNIT(
    input [31:0] csrexin_inst,
    input [31:0] csrexin_csr_gpr_rs1,
    input [31:0] csrexin_csr_data,
    output [31:0] csrexout_csr_ex_result
);
    // 要实现 csrrw,csrrs,csrrc 指令

    `include "csr_name.vh"

// parameter mtvec = 12'h305,
//           mepc  = 12'h341,
//           mstatus = 12'h300;

reg [31:0] csrexout_csr_ex_result_reg;

always @(*) begin
    case(csrexin_inst[14:12]) // check csr instruction
        3'b001: begin // csrrw
            csrexout_csr_ex_result_reg = csrexin_csr_gpr_rs1;
        end
        3'b010: begin // csrrs
            csrexout_csr_ex_result_reg = csrexin_csr_data | csrexin_csr_gpr_rs1;
        end
        3'b011: begin // csrrc
            csrexout_csr_ex_result_reg = csrexin_csr_data & ~csrexin_csr_gpr_rs1;
        end
        default: csrexout_csr_ex_result_reg = 32'h0;
    endcase
end

assign csrexout_csr_ex_result = csrexout_csr_ex_result_reg;

endmodule