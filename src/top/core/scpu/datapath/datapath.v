module Datapath(
    input clk,
    input rst,

    //control signals
    input [1:0] pc_src,
    input reg_write,
    input alu_src_b, 
    input branch,
    input b_type,
    input [3:0]alu_op,
    input [1:0]mem_to_reg,
    input [31:0] inst_in,
    input [31:0] data_in,            // data from data memory

    // output
    output [31:0] addr_out,          // data memory address    
    output [31:0] data_out,          // data to data memory
    output [31:0] pc_out,             // program counter
    output zero_wire,
    input [4:0] debug_reg_addr,
    output [31:0] debug_reg_data
);

    // this part is about the registers. it has 5 input and 2 output.
    wire[4:0] read_addr_1;
    wire[4:0] read_addr_2;
    wire[4:0] write_register;
    wire[31:0] read_data_1;
    wire[31:0] read_data_2;
    assign read_addr_1 = inst_in[19:15];
    assign read_addr_2 = inst_in[24:20];
    assign write_register = inst_in[11:7];

    wire[31:0] data_to_reg;
    wire[31:0] immediate;
    wire[31:0] pc_addr0;
    wire[31:0] alu_another_input;
    wire [31:0] alu_res;
    wire[31:0] imm_shifted;
    wire[31:0] pc_addr1;
    wire[31:0] pc_new1;
    wire[31:0] pc_out_wire;
    wire[31:0] immediate_left_12;

    //DONE:
    REGS regs(
        .clk(clk),
        .rst(rst),
        .we(reg_write),
        .read_addr_1(read_addr_1),
        .read_addr_2(read_addr_2),
        .write_addr(write_register),
        .write_data(data_to_reg),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2),
        .debug_reg_addr(debug_reg_addr),
        .debug_reg_data(debug_reg_data)
    );

    //DONE:select reg or imm
    MUX2T1_32 mux3(
        .in_data_1(read_data_2),
        .in_data_2(immediate),
        .sel(alu_src_b),
        .out_data(alu_another_input)
    );

    //DONE:ALU

    ALU alu(
        .a(read_data_1),
        .b(alu_another_input),
        .alu_op(alu_op),
        .res(alu_res),
        .zero(zero_wire)
    );

    //DONE:
    MUX4T1_32 select_data_write(
        .data_in_0(alu_res),
        .data_in_1(immediate_left_12),
        .data_in_2(pc_addr0),
        .data_in_3(data_in),
        .sel(mem_to_reg),
        .data_out(data_to_reg)
    );

    // this is the part to get the immediate number
    // one input : instruction, one output : immediate
    //DONE: ADDI
    //TODO: other instructions

    ImmGen immgen(
        .inst(inst_in),
        .im(immediate)
    );

    // DONE: IMM_SHIFT

    Sheftletf1 Sheftletf1(
        .in_data(immediate),
        .out_data(imm_shifted)
    );

    SheftLeft12 sheftleft12(
        .in(immediate),
        .out(immediate_left_12)
    );

    //DONE: pc_addr0 = pc_addr1 + 4
    ADD add2(
        .in_data_1(pc_out),
        .in_data_2(32'h4),
        .out_data(pc_addr0)
    );

    //DONE: pc_addr1 = pc_out + imm_shifted

    ADD add1(
        .in_data_1(pc_out),
        .in_data_2(imm_shifted),
        .out_data(pc_addr1)
    );

    //DONE: pc_new1 = (pc_addr0) | (pc_addr1)
    MUX2T1_32 mux1(
        .in_data_1(pc_addr0),
        .in_data_2(pc_addr1),
        .sel(pc_src[1]),
        .out_data(pc_new1)
    );

    //DONE:select between pc_new1 and pc_addr2, this will result in the pc_out

    MUX2T1_32 mux2(
        .in_data_1(pc_new1),
        .in_data_2(pc_addr1),
        .sel(pc_src[0]),
        .out_data(pc_out_wire)
    );

    //DONE: PC update
    PC pc(
        .clk(clk),
        .rst(rst),
        .addr(pc_out_wire),
        .new_addr(pc_out)
    );

    assign addr_out = alu_res;
    assign data_out = read_data_2;

endmodule
