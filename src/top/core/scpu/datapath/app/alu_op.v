module ALUOP (
    input [31:0] inst,
    output [3:0] alu_op
);
    wire [6:0] op_code = inst[6:0];
    wire [2:0] funct3 = inst[14:12];
    wire funct7 = inst[30];

    reg [3:0] alu_op_reg;

    always @* begin 
        case (op_code)
        7'b0010011:begin 
            alu_op_reg = {1'b0, funct3};
        end
        //lw
        7'b0100011:begin
            alu_op_reg = 4'b0000;
        end
        //sw
        7'b0000011:begin
            alu_op_reg = 4'b0000;
        end
        //bne,beq
        7'b1100011:begin
            alu_op_reg = 4'b1000;
        end
        //lui
        7'b0110111:begin
            alu_op_reg = 4'b0000;
        end
        //jal
        7'b1101111:begin
            alu_op_reg = 4'b0000;
        end
        //TODO: check 
        //R-type
        7'b0110011:begin
            case (funct3)
            3'b000:begin
                case (funct7)
                1'b0:begin // add
                    alu_op_reg = 4'b0000;
                end
                1'b1:begin // sub
                    alu_op_reg = 4'b1000;
                end
                endcase
            end
            3'b001:begin // sll
                alu_op_reg = 4'b0001;
            end
            3'b010:begin // slt
                alu_op_reg = 4'b0010;
            end
            3'b011:begin // sltu
                alu_op_reg = 4'b0011;
            end
            3'b100:begin // xor
                alu_op_reg = 4'b0100;
            end
            3'b101:begin // srl or sra
                case (funct7) 
                1'b0:begin // srl
                    alu_op_reg = 4'b0101;
                end
                1'b1:begin // sra
                    alu_op_reg = 4'b1101;
                end
                endcase
            end
            3'b110:begin // or
                alu_op_reg = 4'b0110;
            end
            3'b111:begin // and
                alu_op_reg = 4'b0111;
            end
            endcase
        end
        default:begin
            alu_op_reg = 4'b0000;
        end
        endcase

    end

    assign alu_op = alu_op_reg;

endmodule
