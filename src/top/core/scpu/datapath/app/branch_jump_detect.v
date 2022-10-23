module BRANCH_JUMP_DETECT(
    input [31:0] branchjumpdetectin_inst,
    output branchjumpdetectout_is_branch_jump
);

    reg branchjumpdetect_is_branch_jump_reg;

    always @(*) begin
        if(branchjumpdetectin_inst[6:0] == 7'b1100011) begin // branch type
            branchjumpdetect_is_branch_jump_reg <= 1'b1;
        end else if(branchjumpdetectin_inst[6:0] == 7'b1101111) begin // jump type
            branchjumpdetect_is_branch_jump_reg <= 1'b1;
        end else if(branchjumpdetectin_inst[6:0] == 7'b1100111) begin // jalr type
            branchjumpdetect_is_branch_jump_reg <= 1'b1;
        end else begin
            branchjumpdetect_is_branch_jump_reg <= 1'b0;
        end
    end

    assign branchjumpdetectout_is_branch_jump = branchjumpdetect_is_branch_jump_reg;

endmodule