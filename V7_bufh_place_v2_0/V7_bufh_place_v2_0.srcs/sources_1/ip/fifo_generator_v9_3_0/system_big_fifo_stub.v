// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Mon Feb 15 20:13:48 2016
// Host        : sang_linc running 64-bit Red Hat Enterprise Linux Client release 6.5 (Santiago)
// Command     : write_verilog -force -mode synth_stub
//               /mnt/share/MyGit/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo_stub.v
// Design      : system_big_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v12_0,Vivado 2015.2" *)
module system_big_fifo(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, almost_full, overflow, empty, underflow)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[63:0],wr_en,rd_en,dout[63:0],full,almost_full,overflow,empty,underflow" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [63:0]din;
  input wr_en;
  input rd_en;
  output [63:0]dout;
  output full;
  output almost_full;
  output overflow;
  output empty;
  output underflow;
endmodule
