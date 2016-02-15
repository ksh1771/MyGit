-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
-- Date        : Sat Dec 12 07:54:39 2015
-- Host        : sang_linc running 64-bit Red Hat Enterprise Linux Client release 6.5 (Santiago)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo_stub.vhdl
-- Design      : system_big_fifo
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx485tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_big_fifo is
  Port ( 
    rst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 63 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 63 downto 0 );
    full : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    overflow : out STD_LOGIC;
    empty : out STD_LOGIC;
    underflow : out STD_LOGIC
  );

end system_big_fifo;

architecture stub of system_big_fifo is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "rst,wr_clk,rd_clk,din[63:0],wr_en,rd_en,dout[63:0],full,almost_full,overflow,empty,underflow";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v12_0,Vivado 2015.2";
begin
end;
