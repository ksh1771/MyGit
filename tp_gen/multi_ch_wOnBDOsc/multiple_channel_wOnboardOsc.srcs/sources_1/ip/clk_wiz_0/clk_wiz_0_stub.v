// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
// Date        : Tue Dec 01 08:23:53 2015
// Host        : MSDN-SPECIAL running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               D:/SangsWork/tp_gen_2015_feb/tp_gen_2015_feb/tp_gen_2015-2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_in1_p, clk_in1_n, clk_out1, clk_out2, clk_out3, clk_out4, reset, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1_p,clk_in1_n,clk_out1,clk_out2,clk_out3,clk_out4,reset,locked" */;
  input clk_in1_p;
  input clk_in1_n;
  output clk_out1;
  output clk_out2;
  output clk_out3;
  output clk_out4;
  input reset;
  output locked;
endmodule
