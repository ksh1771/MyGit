//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
//Date        : Tue Dec 15 08:03:44 2015
//Host        : sang_linc running 64-bit Red Hat Enterprise Linux Client release 6.5 (Santiago)
//Command     : generate_target axi_system_wrapper.bd
//Design      : axi_system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module axi_system_wrapper
   (M_AXIS_TDATA_TEST,
    M_AXIS_TLAST_TEST,
    M_AXIS_TREADY_TEST,
    M_AXIS_TVALID_TEST,
    STATE_TEST,
    S_AXI_WDATA_dbg,
    S_AXI_WSTRB_dbg,
    axi_awaddr_dbg,
    axi_c2c_link_status_out,
    axi_c2c_multi_bit_error_out,
    axi_c2c_selio_rx_clk_in,
    axi_c2c_selio_rx_data_in,
    axi_c2c_selio_tx_clk_out,
    axi_c2c_selio_tx_data_out,
    calib_bit,
    clk_200MHz,
    clk_in1,
    clk_spi_data,
    clk_spi_start,
    dac_spi_data,
    dac_spi_start,
    ddr3_addr,
    ddr3_ba,
    ddr3_cas_n,
    ddr3_ck_n,
    ddr3_ck_p,
    ddr3_cke,
    ddr3_cs_n,
    ddr3_dm,
    ddr3_dq,
    ddr3_dqs_n,
    ddr3_dqs_p,
    ddr3_odt,
    ddr3_ras_n,
    ddr3_reset_n,
    ddr3_we_n,
    dout,
    empty,
    ext_reset_in,
    fifo2stream_numofwrite,
    fifo2stream_start,
    fifo_rst,
    gp0,
    init_calib_complete,
    nr_of_writes_TEST,
    once_down,
    ps_data,
    ps_incdec,
    ps_sel,
    ps_start,
    rd_en,
    rg_dur,
    s_axi_awaddr_dbg,
    sel_fifo2ddr,
    slv_reg_wren_dbg,
    soft_tdc_en,
    stop_oper,
    sys_clk0,
    sys_clk1,
    sys_clk10,
    sys_clk11,
    sys_clk2,
    sys_clk3,
    sys_clk4,
    sys_clk5,
    sys_clk6,
    sys_clk7,
    sys_clk8,
    sys_clk9,
    sys_clk_n,
    sys_clk_p,
    sys_rst,
    tdc_en_bypass_on,
    tdc_en_p_dur,
    tdc_en_p_start,
    tdc_in,
    ui_clk,
    ui_clk_sync_rst);
  output [31:0]M_AXIS_TDATA_TEST;
  output M_AXIS_TLAST_TEST;
  output M_AXIS_TREADY_TEST;
  output M_AXIS_TVALID_TEST;
  output [3:0]STATE_TEST;
  output [31:0]S_AXI_WDATA_dbg;
  output [3:0]S_AXI_WSTRB_dbg;
  output [31:0]axi_awaddr_dbg;
  output axi_c2c_link_status_out;
  output axi_c2c_multi_bit_error_out;
  input axi_c2c_selio_rx_clk_in;
  input [8:0]axi_c2c_selio_rx_data_in;
  output axi_c2c_selio_tx_clk_out;
  output [8:0]axi_c2c_selio_tx_data_out;
  output [11:0]calib_bit;
  output clk_200MHz;
  input clk_in1;
  output [31:0]clk_spi_data;
  output clk_spi_start;
  output [15:0]dac_spi_data;
  output dac_spi_start;
  output [15:0]ddr3_addr;
  output [2:0]ddr3_ba;
  output ddr3_cas_n;
  output [0:0]ddr3_ck_n;
  output [0:0]ddr3_ck_p;
  output [0:0]ddr3_cke;
  output [0:0]ddr3_cs_n;
  output [7:0]ddr3_dm;
  inout [63:0]ddr3_dq;
  inout [7:0]ddr3_dqs_n;
  inout [7:0]ddr3_dqs_p;
  output [0:0]ddr3_odt;
  output ddr3_ras_n;
  output ddr3_reset_n;
  output ddr3_we_n;
  input [63:0]dout;
  input empty;
  input ext_reset_in;
  output [31:0]fifo2stream_numofwrite;
  output fifo2stream_start;
  output fifo_rst;
  output gp0;
  output init_calib_complete;
  output [31:0]nr_of_writes_TEST;
  output once_down;
  output [15:0]ps_data;
  output ps_incdec;
  output [3:0]ps_sel;
  output ps_start;
  output rd_en;
  output [31:0]rg_dur;
  output [31:0]s_axi_awaddr_dbg;
  output sel_fifo2ddr;
  output slv_reg_wren_dbg;
  output soft_tdc_en;
  output stop_oper;
  input sys_clk0;
  input sys_clk1;
  input sys_clk10;
  input sys_clk11;
  input sys_clk2;
  input sys_clk3;
  input sys_clk4;
  input sys_clk5;
  input sys_clk6;
  input sys_clk7;
  input sys_clk8;
  input sys_clk9;
  input sys_clk_n;
  input sys_clk_p;
  input sys_rst;
  output tdc_en_bypass_on;
  output [15:0]tdc_en_p_dur;
  output tdc_en_p_start;
  input [11:0]tdc_in;
  output ui_clk;
  output ui_clk_sync_rst;

  wire [31:0]M_AXIS_TDATA_TEST;
  wire M_AXIS_TLAST_TEST;
  wire M_AXIS_TREADY_TEST;
  wire M_AXIS_TVALID_TEST;
  wire [3:0]STATE_TEST;
  wire [31:0]S_AXI_WDATA_dbg;
  wire [3:0]S_AXI_WSTRB_dbg;
  wire [31:0]axi_awaddr_dbg;
  wire axi_c2c_link_status_out;
  wire axi_c2c_multi_bit_error_out;
  wire axi_c2c_selio_rx_clk_in;
  wire [8:0]axi_c2c_selio_rx_data_in;
  wire axi_c2c_selio_tx_clk_out;
  wire [8:0]axi_c2c_selio_tx_data_out;
  wire [11:0]calib_bit;
  wire clk_200MHz;
  wire clk_in1;
  wire [31:0]clk_spi_data;
  wire clk_spi_start;
  wire [15:0]dac_spi_data;
  wire dac_spi_start;
  wire [15:0]ddr3_addr;
  wire [2:0]ddr3_ba;
  wire ddr3_cas_n;
  wire [0:0]ddr3_ck_n;
  wire [0:0]ddr3_ck_p;
  wire [0:0]ddr3_cke;
  wire [0:0]ddr3_cs_n;
  wire [7:0]ddr3_dm;
  wire [63:0]ddr3_dq;
  wire [7:0]ddr3_dqs_n;
  wire [7:0]ddr3_dqs_p;
  wire [0:0]ddr3_odt;
  wire ddr3_ras_n;
  wire ddr3_reset_n;
  wire ddr3_we_n;
  wire [63:0]dout;
  wire empty;
  wire ext_reset_in;
  wire [31:0]fifo2stream_numofwrite;
  wire fifo2stream_start;
  wire fifo_rst;
  wire gp0;
  wire init_calib_complete;
  wire [31:0]nr_of_writes_TEST;
  wire once_down;
  wire [15:0]ps_data;
  wire ps_incdec;
  wire [3:0]ps_sel;
  wire ps_start;
  wire rd_en;
  wire [31:0]rg_dur;
  wire [31:0]s_axi_awaddr_dbg;
  wire sel_fifo2ddr;
  wire slv_reg_wren_dbg;
  wire soft_tdc_en;
  wire stop_oper;
  wire sys_clk0;
  wire sys_clk1;
  wire sys_clk10;
  wire sys_clk11;
  wire sys_clk2;
  wire sys_clk3;
  wire sys_clk4;
  wire sys_clk5;
  wire sys_clk6;
  wire sys_clk7;
  wire sys_clk8;
  wire sys_clk9;
  wire sys_clk_n;
  wire sys_clk_p;
  wire sys_rst;
  wire tdc_en_bypass_on;
  wire [15:0]tdc_en_p_dur;
  wire tdc_en_p_start;
  wire [11:0]tdc_in;
  wire ui_clk;
  wire ui_clk_sync_rst;

  axi_system axi_system_i
       (.M_AXIS_TDATA_TEST(M_AXIS_TDATA_TEST),
        .M_AXIS_TLAST_TEST(M_AXIS_TLAST_TEST),
        .M_AXIS_TREADY_TEST(M_AXIS_TREADY_TEST),
        .M_AXIS_TVALID_TEST(M_AXIS_TVALID_TEST),
        .STATE_TEST(STATE_TEST),
        .S_AXI_WDATA_dbg(S_AXI_WDATA_dbg),
        .S_AXI_WSTRB_dbg(S_AXI_WSTRB_dbg),
        .axi_awaddr_dbg(axi_awaddr_dbg),
        .axi_c2c_link_status_out(axi_c2c_link_status_out),
        .axi_c2c_multi_bit_error_out(axi_c2c_multi_bit_error_out),
        .axi_c2c_selio_rx_clk_in(axi_c2c_selio_rx_clk_in),
        .axi_c2c_selio_rx_data_in(axi_c2c_selio_rx_data_in),
        .axi_c2c_selio_tx_clk_out(axi_c2c_selio_tx_clk_out),
        .axi_c2c_selio_tx_data_out(axi_c2c_selio_tx_data_out),
        .calib_bit(calib_bit),
        .clk_200MHz(clk_200MHz),
        .clk_in1(clk_in1),
        .clk_spi_data(clk_spi_data),
        .clk_spi_start(clk_spi_start),
        .dac_spi_data(dac_spi_data),
        .dac_spi_start(dac_spi_start),
        .ddr3_addr(ddr3_addr),
        .ddr3_ba(ddr3_ba),
        .ddr3_cas_n(ddr3_cas_n),
        .ddr3_ck_n(ddr3_ck_n),
        .ddr3_ck_p(ddr3_ck_p),
        .ddr3_cke(ddr3_cke),
        .ddr3_cs_n(ddr3_cs_n),
        .ddr3_dm(ddr3_dm),
        .ddr3_dq(ddr3_dq),
        .ddr3_dqs_n(ddr3_dqs_n),
        .ddr3_dqs_p(ddr3_dqs_p),
        .ddr3_odt(ddr3_odt),
        .ddr3_ras_n(ddr3_ras_n),
        .ddr3_reset_n(ddr3_reset_n),
        .ddr3_we_n(ddr3_we_n),
        .dout(dout),
        .empty(empty),
        .ext_reset_in(ext_reset_in),
        .fifo2stream_numofwrite(fifo2stream_numofwrite),
        .fifo2stream_start(fifo2stream_start),
        .fifo_rst(fifo_rst),
        .gp0(gp0),
        .init_calib_complete(init_calib_complete),
        .nr_of_writes_TEST(nr_of_writes_TEST),
        .once_down(once_down),
        .ps_data(ps_data),
        .ps_incdec(ps_incdec),
        .ps_sel(ps_sel),
        .ps_start(ps_start),
        .rd_en(rd_en),
        .rg_dur(rg_dur),
        .s_axi_awaddr_dbg(s_axi_awaddr_dbg),
        .sel_fifo2ddr(sel_fifo2ddr),
        .slv_reg_wren_dbg(slv_reg_wren_dbg),
        .soft_tdc_en(soft_tdc_en),
        .stop_oper(stop_oper),
        .sys_clk0(sys_clk0),
        .sys_clk1(sys_clk1),
        .sys_clk10(sys_clk10),
        .sys_clk11(sys_clk11),
        .sys_clk2(sys_clk2),
        .sys_clk3(sys_clk3),
        .sys_clk4(sys_clk4),
        .sys_clk5(sys_clk5),
        .sys_clk6(sys_clk6),
        .sys_clk7(sys_clk7),
        .sys_clk8(sys_clk8),
        .sys_clk9(sys_clk9),
        .sys_clk_n(sys_clk_n),
        .sys_clk_p(sys_clk_p),
        .sys_rst(sys_rst),
        .tdc_en_bypass_on(tdc_en_bypass_on),
        .tdc_en_p_dur(tdc_en_p_dur),
        .tdc_en_p_start(tdc_en_p_start),
        .tdc_in(tdc_in),
        .ui_clk(ui_clk),
        .ui_clk_sync_rst(ui_clk_sync_rst));
endmodule
