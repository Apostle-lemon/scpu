module REGS(
    input clk,
    input rst,
    input we,
    input [4:0]read_addr_1,
    input [4:0]read_addr_2,
    input [4:0]write_addr,
    input [31:0]write_data,
    output [31:0]read_data_1,
    output [31:0]read_data_2,
    input [4:0] debug_reg_addr,
    output [31:0] debug_reg_data
);

    integer i;
    reg [31:0] registers[1:31];

    assign read_data_1 = (read_addr_1 == 0) ? 0 : registers[read_addr_1];
    assign read_data_2 = (read_addr_2 == 0) ? 0 : registers[read_addr_2];
    assign debug_reg_data = registers[debug_reg_addr];


    always @(negedge clk or posedge rst) begin
        if(rst) begin
            for(i = 1; i < 32; i = i + 1) begin
                registers[i] <= 0;
            end
        end else begin
            if(we && write_addr != 0) begin
                registers[write_addr] <= write_data;
            end
        end
    end

endmodule