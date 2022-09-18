// Control 单元会传入 ALU_op
// 但是如果自己的 ALU 接受的是不同的 ALU_op , 则需要这里 ALUcontrol 模块进行控制
// 因为我没有替换 ALU op 的想法，所以没关系
module ALUcontrol(
    input [3:0] ALU_op,
    output [3:0] my_ALU_op
);
    assign my_ALU_op = ALU_op;
endmodule