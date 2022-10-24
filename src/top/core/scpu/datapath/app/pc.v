module PC(
    input clk,
    input rst,
    input [31:0] addr,
    input [31:0] cur_inst,
    input pc_write,
    output [31:0] new_addr
);

    reg [31:0] addr_reg = 0;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            addr_reg <= 0;
        end else begin
            if(cur_inst[6:0] == 7'b1101111 || cur_inst[6:0] == 7'b1100111 || cur_inst[6:0] == 7'b1100011) begin
                addr_reg <= addr_reg;
            end else if (pc_write) begin
                addr_reg <= addr;
            end else begin
                addr_reg <= addr_reg;
            end
        end
    end
    
    assign new_addr = addr_reg;

endmodule