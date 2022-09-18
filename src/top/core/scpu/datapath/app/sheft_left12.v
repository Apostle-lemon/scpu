module SheftLeft12(
    input [31:0] in,
    output [31:0] out
);

    reg[31:0] out_reg;
    always @(*) begin
        // logical sheft left 12
        out_reg = in << 12;
    end
    assign out = out_reg;

endmodule