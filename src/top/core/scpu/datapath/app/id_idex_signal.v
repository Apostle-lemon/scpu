module ID_IDEX_SIGNAL(
    input [4:0] ididexsignalin_id_EX,
    input [2:0] ididexsignalin_id_M,
    input [2:0] ididexsignalin_id_WB,
    input ididexsignalin_idex_zero,

    output [4:0] ididexsignalout_idex_EX,
    output [2:0] ididexsignalout_idex_M,
    output [2:0] ididexsignalout_idex_WB
);

    reg [4:0] idex_EX_reg;
    reg [2:0] idex_M_reg;
    reg [2:0] idex_WB_reg;

    always @(*) begin 
        if (ididexsignalin_idex_zero == 1'b1) begin
            idex_EX_reg <= 5'b00000;
            idex_M_reg <= 3'b000;
            idex_WB_reg <= 3'b000;
        end else begin
            idex_EX_reg <= ididexsignalin_id_EX;
            idex_M_reg <= ididexsignalin_id_M;
            idex_WB_reg <= ididexsignalin_id_WB;
        end 
    end

    assign ididexsignalout_idex_EX = idex_EX_reg;
    assign ididexsignalout_idex_M = idex_M_reg;
    assign ididexsignalout_idex_WB = idex_WB_reg;

endmodule