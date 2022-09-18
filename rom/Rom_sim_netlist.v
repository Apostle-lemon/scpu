// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Sun Sep 18 13:15:06 2022
// Host        : DESKTOP-IT8J4BG running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/ethereal/Desktop/university/3-00ZJUcourse/computerSystemI/datapath_and_control/rom/Rom_sim_netlist.v
// Design      : Rom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Rom,dist_mem_gen_v8_0_13,{}" *) (* ORIG_REF_NAME = "xil_defaultlib_Rom" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module Rom
   (a,
    spo);
  input [10:0]a;
  output [31:0]spo;

  wire [10:0]a;
  wire [31:0]spo;
  wire [31:0]NLW_U0_dpo_UNCONNECTED;
  wire [31:0]NLW_U0_qdpo_UNCONNECTED;
  wire [31:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* c_addr_width = "11" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "2048" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "Rom.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "32" *) 
  Rom_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[31:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[31:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[31:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(1'b0));
endmodule

(* C_ADDR_WIDTH = "11" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "2048" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "artix7" *) (* C_HAS_CLK = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "0" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "0" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "1" *) (* C_HAS_WE = "0" *) 
(* C_MEM_INIT_FILE = "Rom.mif" *) (* C_MEM_TYPE = "0" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "1" *) (* C_REG_A_D_INPUTS = "0" *) (* C_REG_DPRA_INPUT = "0" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "32" *) (* ORIG_REF_NAME = "dist_mem_gen_v8_0_13" *) 
module Rom_dist_mem_gen_v8_0_13
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [10:0]a;
  input [31:0]d;
  input [10:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [31:0]spo;
  output [31:0]dpo;
  output [31:0]qspo;
  output [31:0]qdpo;

  wire \<const0> ;
  wire [10:0]a;
  wire [31:0]\^spo ;

  assign dpo[31] = \<const0> ;
  assign dpo[30] = \<const0> ;
  assign dpo[29] = \<const0> ;
  assign dpo[28] = \<const0> ;
  assign dpo[27] = \<const0> ;
  assign dpo[26] = \<const0> ;
  assign dpo[25] = \<const0> ;
  assign dpo[24] = \<const0> ;
  assign dpo[23] = \<const0> ;
  assign dpo[22] = \<const0> ;
  assign dpo[21] = \<const0> ;
  assign dpo[20] = \<const0> ;
  assign dpo[19] = \<const0> ;
  assign dpo[18] = \<const0> ;
  assign dpo[17] = \<const0> ;
  assign dpo[16] = \<const0> ;
  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qdpo[31] = \<const0> ;
  assign qdpo[30] = \<const0> ;
  assign qdpo[29] = \<const0> ;
  assign qdpo[28] = \<const0> ;
  assign qdpo[27] = \<const0> ;
  assign qdpo[26] = \<const0> ;
  assign qdpo[25] = \<const0> ;
  assign qdpo[24] = \<const0> ;
  assign qdpo[23] = \<const0> ;
  assign qdpo[22] = \<const0> ;
  assign qdpo[21] = \<const0> ;
  assign qdpo[20] = \<const0> ;
  assign qdpo[19] = \<const0> ;
  assign qdpo[18] = \<const0> ;
  assign qdpo[17] = \<const0> ;
  assign qdpo[16] = \<const0> ;
  assign qdpo[15] = \<const0> ;
  assign qdpo[14] = \<const0> ;
  assign qdpo[13] = \<const0> ;
  assign qdpo[12] = \<const0> ;
  assign qdpo[11] = \<const0> ;
  assign qdpo[10] = \<const0> ;
  assign qdpo[9] = \<const0> ;
  assign qdpo[8] = \<const0> ;
  assign qdpo[7] = \<const0> ;
  assign qdpo[6] = \<const0> ;
  assign qdpo[5] = \<const0> ;
  assign qdpo[4] = \<const0> ;
  assign qdpo[3] = \<const0> ;
  assign qdpo[2] = \<const0> ;
  assign qdpo[1] = \<const0> ;
  assign qdpo[0] = \<const0> ;
  assign qspo[31] = \<const0> ;
  assign qspo[30] = \<const0> ;
  assign qspo[29] = \<const0> ;
  assign qspo[28] = \<const0> ;
  assign qspo[27] = \<const0> ;
  assign qspo[26] = \<const0> ;
  assign qspo[25] = \<const0> ;
  assign qspo[24] = \<const0> ;
  assign qspo[23] = \<const0> ;
  assign qspo[22] = \<const0> ;
  assign qspo[21] = \<const0> ;
  assign qspo[20] = \<const0> ;
  assign qspo[19] = \<const0> ;
  assign qspo[18] = \<const0> ;
  assign qspo[17] = \<const0> ;
  assign qspo[16] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  assign spo[31:2] = \^spo [31:2];
  assign spo[1] = \^spo [0];
  assign spo[0] = \^spo [0];
  GND GND
       (.G(\<const0> ));
  Rom_dist_mem_gen_v8_0_13_synth \synth_options.dist_mem_inst 
       (.a(a),
        .spo({\^spo [31:2],\^spo [0]}));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_13_rom" *) 
module Rom_dist_mem_gen_v8_0_13_rom
   (spo,
    a);
  output [30:0]spo;
  input [10:0]a;

  wire [10:0]a;
  wire [30:0]spo;
  wire \spo[0]_INST_0_i_1_n_0 ;
  wire \spo[10]_INST_0_i_1_n_0 ;
  wire \spo[11]_INST_0_i_1_n_0 ;
  wire \spo[12]_INST_0_i_1_n_0 ;
  wire \spo[13]_INST_0_i_1_n_0 ;
  wire \spo[14]_INST_0_i_1_n_0 ;
  wire \spo[15]_INST_0_i_1_n_0 ;
  wire \spo[16]_INST_0_i_1_n_0 ;
  wire \spo[17]_INST_0_i_1_n_0 ;
  wire \spo[18]_INST_0_i_1_n_0 ;
  wire \spo[19]_INST_0_i_1_n_0 ;
  wire \spo[20]_INST_0_i_1_n_0 ;
  wire \spo[21]_INST_0_i_1_n_0 ;
  wire \spo[22]_INST_0_i_1_n_0 ;
  wire \spo[23]_INST_0_i_1_n_0 ;
  wire \spo[24]_INST_0_i_1_n_0 ;
  wire \spo[25]_INST_0_i_1_n_0 ;
  wire \spo[26]_INST_0_i_1_n_0 ;
  wire \spo[27]_INST_0_i_1_n_0 ;
  wire \spo[28]_INST_0_i_1_n_0 ;
  wire \spo[29]_INST_0_i_1_n_0 ;
  wire \spo[2]_INST_0_i_1_n_0 ;
  wire \spo[30]_INST_0_i_1_n_0 ;
  wire \spo[31]_INST_0_i_1_n_0 ;
  wire \spo[3]_INST_0_i_1_n_0 ;
  wire \spo[4]_INST_0_i_1_n_0 ;
  wire \spo[5]_INST_0_i_1_n_0 ;
  wire \spo[6]_INST_0_i_1_n_0 ;
  wire \spo[7]_INST_0_i_1_n_0 ;
  wire \spo[8]_INST_0_i_1_n_0 ;
  wire \spo[9]_INST_0_i_1_n_0 ;

  LUT5 #(
    .INIT(32'h00010000)) 
    \spo[0]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[7]),
        .I3(a[8]),
        .I4(\spo[0]_INST_0_i_1_n_0 ),
        .O(spo[0]));
  LUT6 #(
    .INIT(64'h000013FF0000FFFF)) 
    \spo[0]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[1]),
        .I3(a[5]),
        .I4(a[6]),
        .I5(a[4]),
        .O(\spo[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[10]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[10]_INST_0_i_1_n_0 ),
        .O(spo[9]));
  LUT6 #(
    .INIT(64'h0103AA624080F3AA)) 
    \spo[10]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[2]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[5]),
        .I5(a[1]),
        .O(\spo[10]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[11]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[11]_INST_0_i_1_n_0 ),
        .O(spo[10]));
  LUT6 #(
    .INIT(64'h13001160BF00F508)) 
    \spo[11]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[5]),
        .I4(a[0]),
        .I5(a[4]),
        .O(\spo[11]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[12]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[12]_INST_0_i_1_n_0 ),
        .O(spo[11]));
  LUT6 #(
    .INIT(64'h0049200009410800)) 
    \spo[12]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .I5(a[1]),
        .O(\spo[12]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[13]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[13]_INST_0_i_1_n_0 ),
        .O(spo[12]));
  LUT6 #(
    .INIT(64'h22106A2C2210A24C)) 
    \spo[13]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[4]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[5]),
        .I5(a[0]),
        .O(\spo[13]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \spo[14]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[5]),
        .I5(\spo[14]_INST_0_i_1_n_0 ),
        .O(spo[13]));
  LUT6 #(
    .INIT(64'h000500000000000C)) 
    \spo[14]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[6]),
        .I3(a[4]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[14]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[15]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[15]_INST_0_i_1_n_0 ),
        .O(spo[14]));
  LUT6 #(
    .INIT(64'h080DD900224E00DA)) 
    \spo[15]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[4]),
        .I5(a[3]),
        .O(\spo[15]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[16]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[16]_INST_0_i_1_n_0 ),
        .O(spo[15]));
  LUT6 #(
    .INIT(64'h1300D9EC002BC0E2)) 
    \spo[16]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[4]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[5]),
        .I5(a[3]),
        .O(\spo[16]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[17]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[17]_INST_0_i_1_n_0 ),
        .O(spo[16]));
  LUT6 #(
    .INIT(64'h153504981B0A20EA)) 
    \spo[17]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[1]),
        .I4(a[5]),
        .I5(a[0]),
        .O(\spo[17]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[18]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[18]_INST_0_i_1_n_0 ),
        .O(spo[17]));
  LUT6 #(
    .INIT(64'h444E540051004D8A)) 
    \spo[18]_INST_0_i_1 
       (.I0(a[5]),
        .I1(a[1]),
        .I2(a[0]),
        .I3(a[4]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[18]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[19]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[19]_INST_0_i_1_n_0 ),
        .O(spo[18]));
  LUT6 #(
    .INIT(64'h10C006F030F010E0)) 
    \spo[19]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[3]),
        .I2(a[5]),
        .I3(a[4]),
        .I4(a[0]),
        .I5(a[2]),
        .O(\spo[19]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[20]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[20]_INST_0_i_1_n_0 ),
        .O(spo[19]));
  LUT6 #(
    .INIT(64'h13551B69534C0185)) 
    \spo[20]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[5]),
        .I5(a[1]),
        .O(\spo[20]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[21]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[21]_INST_0_i_1_n_0 ),
        .O(spo[20]));
  LUT6 #(
    .INIT(64'h0000FB2202407057)) 
    \spo[21]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[0]),
        .I2(a[1]),
        .I3(a[5]),
        .I4(a[4]),
        .I5(a[3]),
        .O(\spo[21]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[22]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[22]_INST_0_i_1_n_0 ),
        .O(spo[21]));
  LUT6 #(
    .INIT(64'h05008CA872AB8B4E)) 
    \spo[22]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[0]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[22]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[23]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[23]_INST_0_i_1_n_0 ),
        .O(spo[22]));
  LUT6 #(
    .INIT(64'h0000B00C77C90317)) 
    \spo[23]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[1]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[23]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[24]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[24]_INST_0_i_1_n_0 ),
        .O(spo[23]));
  LUT6 #(
    .INIT(64'h02C810AC80200205)) 
    \spo[24]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[1]),
        .I3(a[4]),
        .I4(a[0]),
        .I5(a[5]),
        .O(\spo[24]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[25]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[25]_INST_0_i_1_n_0 ),
        .O(spo[24]));
  LUT6 #(
    .INIT(64'h027400808101080F)) 
    \spo[25]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[2]),
        .I5(a[5]),
        .O(\spo[25]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[26]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[26]_INST_0_i_1_n_0 ),
        .O(spo[25]));
  LUT6 #(
    .INIT(64'h000810002A218057)) 
    \spo[26]_INST_0_i_1 
       (.I0(a[5]),
        .I1(a[0]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[4]),
        .O(\spo[26]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[27]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[27]_INST_0_i_1_n_0 ),
        .O(spo[26]));
  LUT6 #(
    .INIT(64'h0020820058C02004)) 
    \spo[27]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[1]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[27]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[28]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[28]_INST_0_i_1_n_0 ),
        .O(spo[27]));
  LUT6 #(
    .INIT(64'h2440080044204000)) 
    \spo[28]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[28]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[29]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[29]_INST_0_i_1_n_0 ),
        .O(spo[28]));
  LUT6 #(
    .INIT(64'h0440028040404020)) 
    \spo[29]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[29]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \spo[2]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[5]),
        .I5(\spo[2]_INST_0_i_1_n_0 ),
        .O(spo[1]));
  LUT6 #(
    .INIT(64'h0003003000000022)) 
    \spo[2]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[6]),
        .I2(a[0]),
        .I3(a[4]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[2]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[30]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[30]_INST_0_i_1_n_0 ),
        .O(spo[29]));
  LUT6 #(
    .INIT(64'h060C010040082040)) 
    \spo[30]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[4]),
        .I3(a[0]),
        .I4(a[5]),
        .I5(a[3]),
        .O(\spo[30]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[31]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[31]_INST_0_i_1_n_0 ),
        .O(spo[30]));
  LUT6 #(
    .INIT(64'h0460104002000020)) 
    \spo[31]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[1]),
        .I4(a[0]),
        .I5(a[5]),
        .O(\spo[31]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \spo[3]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[5]),
        .I3(a[2]),
        .I4(a[0]),
        .I5(\spo[3]_INST_0_i_1_n_0 ),
        .O(spo[2]));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \spo[3]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[6]),
        .I2(a[1]),
        .I3(a[3]),
        .I4(a[8]),
        .I5(a[7]),
        .O(\spo[3]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[4]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[4]_INST_0_i_1_n_0 ),
        .O(spo[3]));
  LUT6 #(
    .INIT(64'h0F1D905F0BAE478F)) 
    \spo[4]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[4]),
        .I3(a[3]),
        .I4(a[5]),
        .I5(a[2]),
        .O(\spo[4]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[5]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[5]_INST_0_i_1_n_0 ),
        .O(spo[4]));
  LUT6 #(
    .INIT(64'h00F520642A8844C4)) 
    \spo[5]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[4]),
        .I4(a[2]),
        .I5(a[3]),
        .O(\spo[5]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[6]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[6]_INST_0_i_1_n_0 ),
        .O(spo[5]));
  LUT6 #(
    .INIT(64'h0109100920080000)) 
    \spo[6]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[1]),
        .I4(a[4]),
        .I5(a[5]),
        .O(\spo[6]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[7]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[7]_INST_0_i_1_n_0 ),
        .O(spo[6]));
  LUT6 #(
    .INIT(64'h082104197A41000F)) 
    \spo[7]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[4]),
        .I2(a[5]),
        .I3(a[0]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[7]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[8]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[8]_INST_0_i_1_n_0 ),
        .O(spo[7]));
  LUT6 #(
    .INIT(64'h00002188958403F0)) 
    \spo[8]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[4]),
        .I5(a[5]),
        .O(\spo[8]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \spo[9]_INST_0 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[8]),
        .I3(a[7]),
        .I4(a[6]),
        .I5(\spo[9]_INST_0_i_1_n_0 ),
        .O(spo[8]));
  LUT6 #(
    .INIT(64'h150304DD2B145464)) 
    \spo[9]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[2]),
        .I2(a[1]),
        .I3(a[5]),
        .I4(a[0]),
        .I5(a[4]),
        .O(\spo[9]_INST_0_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_13_synth" *) 
module Rom_dist_mem_gen_v8_0_13_synth
   (spo,
    a);
  output [30:0]spo;
  input [10:0]a;

  wire [10:0]a;
  wire [30:0]spo;

  Rom_dist_mem_gen_v8_0_13_rom \gen_rom.rom_inst 
       (.a(a),
        .spo(spo));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif