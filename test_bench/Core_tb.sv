`timescale 1ns / 1ps


module Core_tb
    #(parameter T = 40)();
    // input
    logic        clk;               // 时钟信号
    logic        aresetn;           // 复位信号
    logic        step;              // 单步执行信号
    logic        debug_mode;        // 调试模式信号
    logic [31:0] data_in;           // 输入数据
    logic [31:0] chip_debug_in;     // 调试模式下的输入数据

    // output
    logic [31:0] address;           // 地址信号
    logic [31:0] data_out;          // 输出数据
    logic [31:0] chip_debug_out0;   // 调试模式下的输出数据
    logic [31:0] chip_debug_out1;
    logic [31:0] chip_debug_out2;
    logic [31:0] chip_debug_out3;

    logic [4:0] reg_index;

    // local
    logic [31:0]pc_out, addr_out, inst;

    Core uut(
        .clk(clk),
        .aresetn(aresetn),
        .step(step),
        .debug_mode(debug_mode),
        .debug_reg_addr(reg_index),

        .address(address),      // 没有管
        .data_out(data_out),    // 没有管
        .data_in(data_in),      // 没有管
        .chip_debug_in(chip_debug_in), // 没有管

        .chip_debug_out0(chip_debug_out0),
        .chip_debug_out1(chip_debug_out1),
        .chip_debug_out2(chip_debug_out2),
        .chip_debug_out3(chip_debug_out3)
    );

    assign pc_out = chip_debug_out0;
    assign addr_out = chip_debug_out1;
    assign inst = chip_debug_out2;

    integer i;
    initial begin
        aresetn = 0;
        clk = 1;
        step = 0;
        debug_mode = 1;
        reg_index = 20;
        #100;
        
        fork
            forever #(T/2) clk <= ~clk;
            #(2*T) aresetn = 1;
        join
    end
endmodule
