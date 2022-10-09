module EXADD (
    input [31:0] ex_pc_out,
    input [31:0] ex_imm,
    input [31:0] ex_rs1_data,
    input [31:0] ex_inst,

    output [31:0] ex_add_result
);
    wire [31:0] ex_imm_shelft_left1;
    SHEFT_LEFT1 ex_shelft_left1(
        .in_data(ex_imm),
        .out_data(ex_imm_shelft_left1)
    );

    reg [31:0] ex_add_result_reg;
    always @(*)
    begin
        case (ex_inst[6:0])
        // b-type
        7'b1100011: ex_add_result_reg = ex_pc_out + ex_imm_shelft_left1;
        // jal
        7'b1101111: ex_add_result_reg = ex_pc_out + ex_imm_shelft_left1;
        // jalr
        7'b1100111: ex_add_result_reg = ex_rs1_data + ex_imm;
        default: ex_add_result_reg = 0;
        endcase
    end

    assign ex_add_result = ex_add_result_reg;

endmodule