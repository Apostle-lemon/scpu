module PC_BRANCH_MUX(
    input [31:0] pcbranchmuxin_pc_addr0,
    input [31:0] pcbranchmuxin_pc_addr1,
    input [31:0] pcbranchmuxin_mem_pc_addr0,
    input sel,
    input branchjumpdetectin_mem_is_branch_jump,

    output [31:0] pcbranchmuxout_pc_new
);

    reg [31:0] pc_new_reg;

    always @(*) begin
        if (branchjumpdetectin_mem_is_branch_jump == 1'b1) begin
            if(sel == 0) begin 
                pc_new_reg <= pcbranchmuxin_mem_pc_addr0;
            end else begin
                pc_new_reg <= pcbranchmuxin_pc_addr1;
            end
        end 
        else begin
            pc_new_reg <= pcbranchmuxin_pc_addr0;
        end
    end

    assign pcbranchmuxout_pc_new = pc_new_reg;

endmodule