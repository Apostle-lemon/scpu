module IFINSTMUX (
    input [31:0] ifinstin_id_inst_orig,
    input ifinstmuxin_mem_is_mret,
    input ifinstin_mem_is_branch_jump,

    output [31:0] ifinstout_inst_modified
);

reg [31:0] ifinstout_inst_modified_reg;

always @(*) begin
    if (ifinstmuxin_mem_is_mret == 1'b1) begin // mret，为消除 if 阶段影响，修改为 nop 指令
        ifinstout_inst_modified_reg = 32'h13;
    end else if (ifinstin_mem_is_branch_jump == 1'b1) begin // b or j，修改为 nop 指令
        ifinstout_inst_modified_reg = 32'h13;
    end else begin
        ifinstout_inst_modified_reg = ifinstin_id_inst_orig;
    end
end

assign ifinstout_inst_modified = ifinstout_inst_modified_reg;

endmodule