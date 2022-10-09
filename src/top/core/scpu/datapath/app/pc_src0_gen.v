module PCSRC0GEN (
    input [31:0] inst,
    output pc_src0
);

    reg pc_src0_reg;
    always @(*) begin
        // judge jl or jlr
        case (inst[6:0])
            7'b1101111 : pc_src0_reg = 1'b1;
            7'b1100111 : pc_src0_reg = 1'b1;
            default : pc_src0_reg = 1'b0;
        endcase
    end
    assign pc_src0 = pc_src0_reg;
endmodule