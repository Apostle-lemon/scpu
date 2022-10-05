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
        //TODO:
        //R-type
        7'b0110011:begin
        
        end
        default:begin
            alu_op_reg = 4'b0000;
        end
        endcase

    end

    assign alu_op = alu_op_reg;

endmodule
