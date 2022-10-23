module RAW_HAZARD_UNIT(
    input [4:0] rawhazardin_id_rs1_addr,
    input [4:0] rawhazardin_id_rs2_addr,
    input [4:0] rawhazardin_ex_rd_addr,
    input [31:0] rawhazardin_ex_inst,
    output rawhazardout_pc_write,
    output rawhazardout_ifid_write,
    output rawhazardout_idex_zero
);

    reg rawhazard_pc_write_reg;
    reg rawhazard_ifid_write_reg;
    reg rawhazard_idex_zero_reg;

    always @(*) begin
        if(rawhazardin_ex_inst[6:0] == 7'b0000011) begin // load type
            if(rawhazardin_id_rs1_addr == rawhazardin_ex_rd_addr) begin
                rawhazard_pc_write_reg <= 1'b0;
                rawhazard_ifid_write_reg <= 1'b0;
                rawhazard_idex_zero_reg <= 1'b1;
            end else if (rawhazardin_id_rs2_addr == rawhazardin_ex_rd_addr) begin
                rawhazard_pc_write_reg <= 1'b0;
                rawhazard_ifid_write_reg <= 1'b0;
                rawhazard_idex_zero_reg <= 1'b1;
            end else begin
                rawhazard_pc_write_reg <= 1'b1;
                rawhazard_ifid_write_reg <= 1'b1;
                rawhazard_idex_zero_reg <= 1'b0;
            end
        end else begin
            rawhazard_pc_write_reg <= 1'b1;
            rawhazard_ifid_write_reg <= 1'b1;
            rawhazard_idex_zero_reg <= 1'b0;
        end
    end

    assign rawhazardout_pc_write = rawhazard_pc_write_reg;
    assign rawhazardout_ifid_write = rawhazard_ifid_write_reg;
    assign rawhazardout_idex_zero = rawhazard_idex_zero_reg;

endmodule