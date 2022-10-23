module IFIDREG(
    input clk,
    input rst,
    input [31:0] ifidin_pc_out,
    input [31:0] ifidin_inst,
    input [31:0] ifidin_pc_addr0,
    input ifidin_ifid_write,

    output [31:0] ifidout_pc_out,
    output [31:0] ifidout_inst,
    output [31:0] ifidout_id_pc_addr0
);

reg [31:0] ifidout_pc_out_reg;
reg [31:0] ifidout_inst_reg;
reg [31:0] ifidout_id_pc_addr0_reg;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        ifidout_pc_out_reg <= 32'h00000000;
        // addi x0, x0, 0
        ifidout_inst_reg <= 32'h00000013;
        ifidout_id_pc_addr0_reg <= 32'h00000000;
    end
    else if(ifidin_ifid_write) begin
        ifidout_pc_out_reg <= ifidin_pc_out;
        ifidout_inst_reg <= ifidin_inst;
        ifidout_id_pc_addr0_reg <= ifidin_pc_addr0;
    end else begin
        ifidout_pc_out_reg <= ifidout_pc_out_reg;
        ifidout_inst_reg <= ifidout_inst_reg;
        ifidout_id_pc_addr0_reg <= ifidout_id_pc_addr0_reg;
    end
end

assign ifidout_pc_out = ifidout_pc_out_reg;
assign ifidout_inst = ifidout_inst_reg;
assign ifidout_id_pc_addr0 = ifidout_id_pc_addr0_reg;

endmodule
