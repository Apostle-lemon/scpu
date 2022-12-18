// this is a ALU module
module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_op,
    input [31:0] inst,
    input [31:0] pc,
    output [31:0] res,
    output wire zero
);
    `include "alu_op.vh"

    reg [31:0] res_reg;

    always @(*) begin
        if(inst[6:0] == 7'b0110111) begin //lui
            res_reg = {inst[31:12], 12'b0};
        end else begin
            case (alu_op)
                ADD: 
                    case(inst[6:0])
                        7'b0010111: // auipc 
                            res_reg = pc + b;
                        default:
                            res_reg = a + b;
                    endcase
                SUB: res_reg = a - b;
                SLL: res_reg = a << b;
                SLT: res_reg = ($signed(a)< $signed(b)) ? 1 : 0;
                SLTU: res_reg = ($unsigned(a)<$unsigned(b)) ? 1 : 0;
                XOR: res_reg = a ^ b;
                SRL: res_reg = a >> b;
                SRA: res_reg = a >>> b;
                OR: res_reg = a | b;
                AND: res_reg = a & b;
                default: res_reg = 0;
            endcase
        end
    end

    assign res = res_reg;
    assign zero = (res == 0) ? 1 : 0;

endmodule
