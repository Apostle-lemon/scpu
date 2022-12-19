module ID_INST_MUX (
    input [31:0] idpcmuxin_id_inst_orig,
    input idpcmuxin_ex_is_branch_jump,
    input idpcmuxin_mem_is_branch_jump,
    input idpcmuxin_ex_is_mret,

    output [31:0] idpcmuxout_id_inst
);

    reg [31:0] idpcmuxout_id_inst_reg;

    always @(*)
        begin
            if (idpcmuxin_ex_is_branch_jump || idpcmuxin_mem_is_branch_jump)
                idpcmuxout_id_inst_reg <= 32'h00000013;
            else if(idpcmuxin_ex_is_mret) begin
                idpcmuxout_id_inst_reg <= 32'h00000073;
            end
                idpcmuxout_id_inst_reg <= idpcmuxin_id_inst_orig;
        end

    assign idpcmuxout_id_inst = idpcmuxout_id_inst_reg;

endmodule