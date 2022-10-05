// select 1 from 2 32bit input
module MUX2T1_32(
    input [31:0] in_data_1,
    input [31:0] in_data_2,
    input sel,
    output [31:0] out_data
);
    assign out_data = (sel == 0) ? in_data_1 : in_data_2;

endmodule