module IFIDREG(
    input clk,
    input rst,
    input [31:0] ifidin_pc_out,
    input [31:0] ifidin_inst,

    output [31:0] ifidout_pc_out,
    output [31:0] ifidout_inst
);

reg [31:0] ifidout_pc_out_reg;
reg [31:0] ifidout_inst_reg;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        ifidout_pc_out_reg <= 32'h00000000;
        // addi x0, x0, 0
        ifidout_inst_reg <= 32'h00000013;
    end
    else
    begin
        ifidout_pc_out_reg <= ifidin_pc_out;
        ifidout_inst_reg <= ifidin_inst;
    end
end

assign ifidout_pc_out = ifidout_pc_out_reg;
assign ifidout_inst = ifidout_inst_reg;

endmodule
