// this is a simple add.v
module ADD(
    input [31:0] in_data_1,
    input [31:0] in_data_2,
    output [31:0] out_data
);
    assign out_data = in_data_1 + in_data_2;
endmodule