// get the immediate number from the riscv instruction
module ImmGen(
    input [31:0] inst,
    output [31:0] im
);

    // get the immediate number according to the instruction type
    reg [31:0] imm = 0;
    always @(*)
    begin
        case (inst[6:0])
        // addi,slti,andi,ori
        // signal extension
        //7'b0010011: imm = inst[31:20];
        7'b0010011: imm = {inst[31]==1?20'hfffff:20'b0, inst[31:20]};
        // lui
        7'b0110111: imm = {inst[31]==1?12'hfff:12'b0, inst[31:12]};
        // jal
        7'b1101111: imm = {inst[31]==1?12'hfff:12'b0, inst[31],inst[19:12],inst[20],inst[30:21]};
        // beq,bne
        7'b1100011: imm = {inst[31]==1?20'hfffff:20'b0,inst[31],inst[7],inst[30:25],inst[11:8]};
        // lw
        7'b0000011: imm = inst[31:20];
        // sw
        7'b0100011: imm = inst[31:25];
        default: imm = 0;
        endcase
    end
    assign im = imm;
endmodule