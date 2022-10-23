module PC(
    input clk,
    input rst,
    input [31:0] addr,
    input pc_write,
    output [31:0] new_addr
);

    reg [31:0] addr_reg = 0;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            addr_reg <= -4;
        end else begin
            if (pc_write) begin
                addr_reg <= addr;
            end 
            else begin
                addr_reg <= addr_reg;
            end
        end
    end
    
    assign new_addr = addr_reg;

endmodule