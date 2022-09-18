// this is a ALU module
module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_op,
    output reg [31:0] res,
    output wire zero
);
    `include "alu_op.vh"
    always @(*)
        case (alu_op)
            ADD: res = a + b;
            SUB: res = a - b;
            SLL: res = a << b;
            SLT: res = ($signed(a)< $signed(b)) ? 1 : 0;
            SLTU: res = ($unsigned(a)<$unsigned(b)) ? 1 : 0;
            XOR: res = a ^ b;
            SRL: res = a >> b;
            SRA: res = a >>> b;
            OR: res = a | b;
            AND: res = a & b;
            default: res = 0;
        endcase
        assign zero = (res == 0) ? 1 : 0;
endmodule
