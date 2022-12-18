module CSR_CONTROL(
    input [31:0] csrcontrolin_inst,
    output csrcontrolout_csr_write
);

// 这个模组这个决定了要不要将 csr 的数据更新

    `include "csr_name.vh"

// parameter mtvec = 12'h305,
//           mepc  = 12'h341,
//           mstatus = 12'h300;

reg csrcontrolout_csr_write_reg;

always @(*) begin
    case(csrcontrolin_inst[6:0]) 
        7'b1110011: begin // if it is SYSTEM opcode
            case(csrcontrolin_inst[31:20]) // correct csr address
                mtvec: csrcontrolout_csr_write_reg = 1'b1;
                mepc: csrcontrolout_csr_write_reg = 1'b1;
                mstatus: csrcontrolout_csr_write_reg = 1'b1;
                default: csrcontrolout_csr_write_reg = 1'b0;
            endcase
        end
        default: csrcontrolout_csr_write_reg = 1'b0;
    endcase
end

assign csrcontrolout_csr_write = csrcontrolout_csr_write_reg;

endmodule