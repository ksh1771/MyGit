`timescale 1ps/1ps

`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate

`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerat


module tdc_front_top
  (
// Inouts
inout [63:0]                            ddr3_dq,
inout [7:0]                             ddr3_dqs_n,
inout [7:0]                             ddr3_dqs_p,
  
// Outputs
output [15:0]                           ddr3_addr,
output [2:0]                            ddr3_ba,
output                                  ddr3_ras_n,
output                                  ddr3_cas_n,
output                                  ddr3_we_n,
output                                  ddr3_reset_n,
output [0:0]                            ddr3_ck_p,
output [0:0]                            ddr3_ck_n,
output [0:0]                            ddr3_cke,
output [0:0]                            ddr3_cs_n,
output [7:0]                            ddr3_dm,
output [0:0]                            ddr3_odt,
output                                  init_calib_complete,        // MIG init complete flag

input                                   sys_clk_p,              	// 200MHz clock for DDR3 memory
input                                   sys_clk_n,              	// 200MHz clock for DDR3 memory

input                                   fe_clk_in_p,                  // 100MHz clock input (p)
input                                   fe_clk_in_n,                  // 100MHz clock input (n)

input                                   sys_rst_n,					// active low POR
input                                   sys_rst,   				    // active low POR

output								    o_clk_mux_oe,
output								    o_clk_mux_sel0,
output								    o_clk_mux_sel1,

output                                  sma_dac_sync,
output                                  sma_dac_clk,
output                                  sma_dac_data,
 
output                                  o_spi_clk_sync,
output                                  o_spi_clk_sclk,
output                                  o_spi_clk_data,
 
// AXI chip2chip   
output	 							   axi_chip2chip_0_axi_c2c_selio_tx_clk_out_pin,
output	 [8:0] 					       axi_chip2chip_0_axi_c2c_selio_tx_data_out_pin,
input 								   axi_chip2chip_0_axi_c2c_selio_rx_clk_in_pin, 
input 	 [8:0] 					       axi_chip2chip_0_axi_c2c_selio_rx_data_in_pin,
output	 							   axi_chip2chip_0_axi_c2c_link_status_out_pin,
output	 							   axi_chip2chip_0_axi_c2c_multi_bit_error_out_pin,

// calibration pulse with loopback
output	                   	          gen_test_pulse_0_once_down_pin,

// differential TDC Enable inputs
input							       i_tdc_en_p,
input                                  i_tdc_en_n,

input                                  i_tdc_ref_p,
input                                  i_tdc_ref_n,

output                                 ufl_tdc_en_out,
output                                 ufl_ref_ch_out,

// TDC inputs   
input [NUM_OF_CHANNEL-1:1]	           i_tdc_in		// TDC channel input

   
);

parameter						NUM_OF_CHANNEL 			= 76;

//wire            init_calib_complete;
wire [31:0] TDATA_TEST;
wire        TVALID_TEST, TREADY_TEST, TLAST_TEST;
wire [3:0]  STATE_TEST;

(* dont_touch = "true" *)   wire tdc_source_clk;
wire							dcm_locked, dcm_locked0, dcm_locked1, dcm_locked2, dcm_locked3, dcm_locked4, dcm_locked5, dcm_locked6, dcm_locked7, dcm_locked8, dcm_locked9, dcm_locked10, dcm_locked11;
(* dont_touch = "true" *)   wire sys_clk0_s, sys_clk1_s, sys_clk2_s, sys_clk3_s, sys_clk4_s, sys_clk5_s, sys_clk6_s, sys_clk7_s, sys_clk8_s, sys_clk9_s, sys_clk10_s, sys_clk11_s;
wire							sys_rst0, sys_rst1, sys_rst2, sys_rst3, sys_rst4, sys_rst5, sys_rst6, sys_rst7, sys_rst8, sys_rst9, sys_rst10, sys_rst11;

wire                            dcm_locked_tdc;

wire [11:0]						psen, psincdec, psdone;
wire							psclk;
wire                         	regfiles_axi4_0_ps_incdec_pin;
wire [3:0] 						regfiles_axi4_0_ps_sel_pin;
wire [15:0] 					regfiles_axi4_0_ps_data_pin;
wire                         	regfiles_axi4_0_ps_start_pin;
wire                         	regfiles_axi4_0_clk_sel_pin;
wire                         	reset_n;
wire [11:0]  					tdc_datas;


(* dont_touch = "true" *) wire [NUM_OF_CHANNEL-1:0]	    tdc_en_start_arry;
(* dont_touch = "true" *) wire [NUM_OF_CHANNEL-1:0]	    tdc_en_start_arry2;
wire [NUM_OF_CHANNEL-1:0]	    multi_fifo_empty;
wire [NUM_OF_CHANNEL-1:0]	    multi_fifo_full;
wire [NUM_OF_CHANNEL-1:0]	   	multi_fifo_rd_en;
wire [63:0]					    multi_fifo_data [0:NUM_OF_CHANNEL-1];
wire [64*NUM_OF_CHANNEL-1:0]    packed_fifo_data;
wire [NUM_OF_CHANNEL-1:0]       multi_tdc_datas [0:11];
wire [11:0]                     ch0_tdc_datas;
  
wire							cali_mode;
wire							stop_oper;
wire [2:0]						ct_state_test;
wire [63:0]						dout_test;
wire							wr_out_test;

wire [3:0]						read_ready_que_test;
wire [11:0]						sel_cnt_test;

wire                            fifo_rd_en_mux;
wire                            fifo2ddr_0_rd_en_pin;
wire [63:0]                     fifo2ddr_0_dout_pin;
wire                            fifo2ddr_0_empty_pin;
wire                            regfiles_axi4_0_sel_fifo2ddr_pin;
wire                            fifo_ready_hst;
wire [63:0]                     fifo_data_hst;
wire                            fifo_rst;
wire                            gen_test_pulse_0_once_down_pin_int;
wire                            capture_en_test;
wire [127:0]                    tdc_calib_test;      
wire 							mmcm_locked;
wire 							spi_sclk, spi_miso, spi_mosi, spi_ss;
wire 							scl_cs, sda_cs;
wire		 					iic_sda_t, iic_sda_o, iic_sda_i;
wire 							iic_scl_t, iic_scl_o, iic_scl_i;	   
wire 							iic_scl_w, iic_sda_w;	   
wire [31:0] 					fifo2ddr_nr_of_writes_TEST;
wire [31:0]                     nr_of_writes_TEST;
wire 							soft_tdc_en;
wire [31:0]  					rg_dur;  
wire 							tdc_en_p_start;
(* dont_touch = "true" *)   wire tdc_en_int;
(* dont_touch = "true" *)   wire tdc_en_w;
(* dont_touch = "true" *)   wire tdc_en_mode;
wire                            axi_chip2chip_0_axi_c2c_link_status_out;
wire                            axi_chip2chip_0_axi_c2c_selio_tx_clk_out;
wire                            ui_clk, ui_rst;
wire [31:0]                     S_AXI_WDATA_dbg, axi_awaddr_dbg;
wire [3:0]                      S_AXI_WSTRB_dbg;
wire [31:0]                     s_axi_awaddr_dbg;
wire [3:0]                      m_axi_wstrb_dbg;
wire [31:0]                     m_axi_wdata_dbg;
wire [7:0]                      m_axi_awlen_dbg;
wire [31:0]                     m_axi_awaddr_c2c_dbg;   
reg [3:0]                       tdc_dbg;
wire                            clk_200MHz;
wire [11:0]                     calib_bit;
wire                            tdc_en_bypass_on;
wire                            tdc_in_ref_w;
wire                            tdc_in_ref;
wire                            tdc_en_start;
wire                            dac_spi_start;
wire [15:0]                     dac_spi_data;
wire                            clk_spi_start;
wire [31:0]                     clk_spi_data;
wire [2:0]                      ct_state, nt_state;
wire                            fe_src_clk, fe_src_clk_w, ui_clk;
wire                            sys_clk_200MHz, sys_clk_200MHz_ibufg;

(* dont_touch = "true" *)   wire internal_tdc_en;
(* dont_touch = "true" *)   wire n_internal_tdc_en;


assign tdc_en_mode = tdc_en_p_start;

assign ufl_tdc_en_out = internal_tdc_en;

assign n_internal_tdc_en = ~internal_tdc_en;

//assign ufl_ref_ch_out = ch0_tdc_datas[0];

//assign ufl_ref_ch_out = fe_src_clk_w;
assign ufl_ref_ch_out = sys_clk_200MHz;

/*
BUF ufl_tdc_en_buf (
            .O(ufl_tdc_en_out),
            .I(internal_tdc_en_bufg)
);
*/

// sel1, sel0: 0, 0 - Q1 (CLK0), Q0(CLK0)
// sel1, sel0: 0, 1 - Q1 (CLK0), Q0(CLK1)
// sel1, sel0: 1, 0 - Q1 (CLK1), Q0(CLK0)
// sel1, sel0: 1, 1 - Q1 (CLK1), Q0(CLK1)
assign o_clk_mux_oe = 1'b1;
assign o_clk_mux_sel0 = 1'b0;
assign o_clk_mux_sel1 = 1'b0;

assign dcm_locked_tdc = dcm_locked0 & dcm_locked1 & dcm_locked2 & dcm_locked3 & dcm_locked4 & dcm_locked5 & dcm_locked6 & dcm_locked7 & dcm_locked8 & dcm_locked9 & dcm_locked10 & dcm_locked11;
  
assign reset_n   = (sys_rst_n & dcm_locked_tdc);
assign sys_rst0  = !reset_n;
assign sys_rst1  = !reset_n;
assign sys_rst2  = !reset_n;
assign sys_rst3  = !reset_n;
assign sys_rst4  = !reset_n;
assign sys_rst5  = !reset_n;
assign sys_rst6  = !reset_n;
assign sys_rst7  = !reset_n;
assign sys_rst8  = !reset_n;
assign sys_rst9  = !reset_n;
assign sys_rst10 = !reset_n;
assign sys_rst11 = !reset_n;
//assign ui_rst = !reset_n;

ps_con ps_con_inst (
			.sys_clk(tdc_source_clk),							// system main clk, usually running at 100MHz
//			.sys_rst(reset_n & dcm_locked),						// system reset Active Low, synchronous with sys_clk
			.sys_rst(!ui_rst),						         // system reset Active Low, synchronous with tdc_source_clk
								
			.i_start(regfiles_axi4_0_ps_start_pin),				// phase shift function start bit 
			.i_ps_data(regfiles_axi4_0_ps_data_pin),			// phase shift amount (0-56)
			.i_ps_sel(regfiles_axi4_0_ps_sel_pin),				// phase shift clock selection (0-9)
			.i_incdec(regfiles_axi4_0_ps_incdec_pin),			// 1: inc. , 0: dec.
				   
			.o_state(),											// FSM state flag (for debug)
			.o_ps_clk(psclk),									// phase shift clock
			.o_psen(psen),										// phase shift enable sen
			.o_psincdec(psincdec),								// phase shift inc/dec
			.i_psdone(psdone)
);
       
       
/*
clk_wiz_0 clk_tdc_source_inst0 (
            .clk_in1_p(fe_clk_in_p),             // input clk_in1
            .clk_in1_n(fe_clk_in_n),             // input clk_in1
            .clk_out1(fe_src_clk),      // output clk_out1 100MHz system clock
            .reset(~reset_n),               // input reset
            .locked()
);     
*/
IBUFDS clk_tdc_source_inst0( 
    .O  (fe_src_clk_w),
    .I  (fe_clk_in_p),
    .IB (fe_clk_in_n)
);
/*
BUFG clkf_buf(
    .O (fe_src_clk),
    .I (fe_src_clk_w)
);
*/
assign fe_src_clk = tdc_source_clk;
assign tdc_source_clk = ui_clk;
// 12 Dynamic Phase Shifted clocks controlled by MMCM    

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_0 (
			.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk0_s), 						// 500MHz front-end clock (phase 0)
         	.PSCLK(psclk),
         	.PSEN(psen[0]),
         	.PSINCDEC(psincdec[0]),
         	.PSDONE(psdone[0]),
                 		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked0)						// locked out signal
);
		 
clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_1(
         	.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk1_s), 						// 500MHz front-end clock (phase 1)
         	.PSCLK(psclk),
         	.PSEN(psen[1]),
         	.PSINCDEC(psincdec[1]),
         	.PSDONE(psdone[1]),
                 		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked1)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_2(
         	.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk2_s), 						// 500MHz front-end clock (phase 2)
         	.PSCLK(psclk),
         	.PSEN(psen[2]),
         	.PSINCDEC(psincdec[2]),
         	.PSDONE(psdone[2]),
                 		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked2)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_3(
        	.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk3_s), 						// 500MHz front-end clock (phase 3)
         	.PSCLK(psclk),
         	.PSEN(psen[3]),
         	.PSINCDEC(psincdec[3]),
         	.PSDONE(psdone[3]),
                 		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked3)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_4(
        	.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk4_s), 						// 500MHz front-end clock (phase 4)
         	.PSCLK(psclk),
         	.PSEN(psen[4]),
         	.PSINCDEC(psincdec[4]),
         	.PSDONE(psdone[4]),
                		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked4)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_5(
       		.CLK_IN1(fe_src_clk),					// 100MHz clk in
       		.CLK_OUT1(sys_clk5_s), 						// 500MHz front-end clock (phase 5)
       		.PSCLK(psclk),
       		.PSEN(psen[5]),
       		.PSINCDEC(psincdec[5]),
       		.PSDONE(psdone[5]),
                 		            		   		  		
      		.RESET(!sys_rst_n), 							// active high reset		
       		.LOCKED(dcm_locked5)						// locked out signal
);
 
clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_6(
         	.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk6_s), 						// 500MHz front-end clock (phase 6)
         	.PSCLK(psclk),
         	.PSEN(psen[6]),
         	.PSINCDEC(psincdec[6]),
         	.PSDONE(psdone[6]),
                 		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked6)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_7(
       		.CLK_IN1(fe_src_clk),					// 100MHz clk in
       		.CLK_OUT1(sys_clk7_s), 						// 500MHz front-end clock (phase 7)
       		.PSCLK(psclk),
       		.PSEN(psen[7]),
       		.PSINCDEC(psincdec[7]),
       		.PSDONE(psdone[7]),
                 		            		   		  		
      		.RESET(!sys_rst_n), 							// active high reset		
       		.LOCKED(dcm_locked7)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_8(
       		.CLK_IN1(fe_src_clk),					// 100MHz clk in
       		.CLK_OUT1(sys_clk8_s), 						// 500MHz front-end clock (phase 8)
       		.PSCLK(psclk),
       		.PSEN(psen[8]),
       		.PSINCDEC(psincdec[8]),
       		.PSDONE(psdone[8]),
                 		            		   		  		
      		.RESET(!sys_rst_n), 							// active high reset		
       		.LOCKED(dcm_locked8)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_9(
         	.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk9_s), 						// 500MHz front-end clock (phase 9)
         	.PSCLK(psclk),
         	.PSEN(psen[9]),
         	.PSINCDEC(psincdec[9]),
         	.PSDONE(psdone[9]),
                 		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked9)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_10(
         	.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk10_s), 					// 500MHz front-end clock (phase 10)
         	.PSCLK(psclk),
         	.PSEN(psen[10]),
         	.PSINCDEC(psincdec[10]),
         	.PSDONE(psdone[10]),
                 		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked10)						// locked out signal
);

clk_mmcme_main 
#(.clk_phase(0))
clk_mmcme_main_11(
         	.CLK_IN1(fe_src_clk),					// 100MHz clk in
         	.CLK_OUT1(sys_clk11_s), 					// 500MHz front-end clock (phase 11)
         	.PSCLK(psclk),
         	.PSEN(psen[11]),
         	.PSINCDEC(psincdec[11]),
         	.PSDONE(psdone[11]),
                 		            		   		  		
        	.RESET(!sys_rst_n), 							// active high reset		
         	.LOCKED(dcm_locked11)						// locked out signal
);

// LVDS buffer for TDC Enable         
IBUFDS lvds_input_tdc_en (.O(i_tdc_en), .I(i_tdc_en_p), .IB(i_tdc_en_n));
IBUFDS lvds_input_tdc_ref (.O(tdc_in_ref), .I(i_tdc_ref_p), .IB(i_tdc_ref_n));
	        
	        
// Internal TDC Enable module	        
range_gate_con range_gate_con_inst(
			.sys_clk(tdc_source_clk),					// clk
//			.sys_rst(sys_rst_n),						// timing reset Active Low, synchronous with sys_clk
			.sys_rst(!ui_rst),							// timing reset Active Low, synchronous with tdc_source_clk
		
			.i_tdc_en(i_tdc_en),						// i_tdc_en
            .bypass_on(tdc_en_bypass_on),               // 1: i_tdc_en bypass, 0: internal tdc enable signal generated through the range_gate_con
			.i_rg_dur(rg_dur),							// range gate duration 
			.i_enet_cap_en(soft_tdc_en), 				// software-driven capture enable

			.o_sts_reg(),
			.o_rg_async(internal_tdc_en)				// range gate output
); 
	   
// internal delay module for TDC Enable channel
IDELAYE2 #(
			.DELAY_SRC                ( "DATAIN" ),
			.HIGH_PERFORMANCE_MODE    ( "TRUE" ),
			.IDELAY_TYPE              ( "FIXED" ),
			.IDELAY_VALUE             ( 0 ),
			.PIPE_SEL                 ( "FALSE" ),
			.REFCLK_FREQUENCY         ( 200.0 ),
			.SIGNAL_PATTERN           ( "DATA" )
) tdc_en_r (
			.CNTVALUEOUT              (),
			.DATAOUT                  (tdc_en_w),
			.C                        (clk_200MHz), 
			.CE                       (),
			.CINVCTRL                 (),
			.CNTVALUEIN               (), 
			.DATAIN                   (internal_tdc_en),
//			.DATAIN                   (i_tdc_en),
			.IDATAIN                  (1'b0),
			.INC                      (),
			.LD                       (),
			.LDPIPEEN                 (1'b0),
			.REGRST                   () 
);

// internal delay module for TDC Enable channel
IDELAYE2 #(
			.DELAY_SRC                ( "IDATAIN" ),
			.HIGH_PERFORMANCE_MODE    ( "TRUE" ),
			.IDELAY_TYPE              ( "FIXED" ),
			.IDELAY_VALUE             ( 0 ),
			.PIPE_SEL                 ( "FALSE" ),
			.REFCLK_FREQUENCY         ( 200.0 ),
			.SIGNAL_PATTERN           ( "DATA" )
) tdc_in_ref_r (
			.CNTVALUEOUT              (),
			.DATAOUT                  (tdc_in_ref_w),
			.C                        (clk_200MHz), 
			.CE                       (),
			.CINVCTRL                 (),
			.CNTVALUEIN               (), 
			.DATAIN                   (1'b0),
			.IDATAIN                  (tdc_in_ref),
			.INC                      (),
			.LD                       (),
			.LDPIPEEN                 (1'b0),
			.REGRST                   () 
);
		
// IDELAY Control module for IDELAYE2		 
IDELAYCTRL idelayctrl_inst0(
			.RDY    (),
			.REFCLK (clk_200MHz),
//			.RST    (!sys_rst_n)			// active high reset
			.RST    (ui_rst)			// active high reset			
);	 

IDELAYCTRL idelayctrl_inst1(
			.RDY    (),
			.REFCLK (clk_200MHz),
//			.RST    (!sys_rst_n)			// active high reset
			.RST    (ui_rst)			// active high reset			
);	 
		 
//assign tdc_en_int = internal_tdc_en;		 
assign tdc_en_int = tdc_en_mode ? 1'b1 : internal_tdc_en;
//assign tdc_en_int = tdc_en_mode ? 1'b1 : i_tdc_en;
             
tdc_en # (
       		.NUM_OF_CHANNEL(NUM_OF_CHANNEL)
) tdc_en_inst(
			.sys_clk(tdc_source_clk),
         	.sys_clk0(sys_clk0_s),
         	.sys_clk1(sys_clk1_s),
         	.sys_clk2(sys_clk2_s),
         	.sys_clk3(sys_clk3_s),
         	.sys_clk4(sys_clk4_s),
         	.sys_clk5(sys_clk5_s),
         	.sys_clk6(sys_clk6_s),
         	.sys_clk7(sys_clk7_s),
         	.sys_clk8(sys_clk8_s),
         	.sys_clk9(sys_clk9_s),
         	.sys_clk10(sys_clk10_s),
         	.sys_clk11(sys_clk11_s),
         			
         	.sys_rst0(sys_rst0),
         	.sys_rst1(sys_rst1),
         	.sys_rst2(sys_rst2),
         	.sys_rst3(sys_rst3),
         	.sys_rst4(sys_rst4),
         	.sys_rst5(sys_rst5),
         	.sys_rst6(sys_rst6),
         	.sys_rst7(sys_rst7),	
         	.sys_rst8(sys_rst8),
         	.sys_rst9(sys_rst9),	
         	.sys_rst10(sys_rst10),	
         	.sys_rst11(sys_rst11),	
         			
			.ch_num(8'h4B),
			.i_tdc_in(tdc_en_w),
					
//			.stop(stop_oper),
			.stop(stop_oper),			
			.o_tdc_en_start(tdc_en_start),
			.tdc_en_start_arry(tdc_en_start_arry),
			.tdc_en_start_arry2(tdc_en_start_arry2),
			.i_calib_bit(calib_bit),			
			.fifo_rst(fifo_rst),
			.fifo_empty(multi_fifo_empty[75]),
			.fifo_full(multi_fifo_full[75]),
			.fifo_rd_en(multi_fifo_rd_en[75]),
			.fifo_data(multi_fifo_data[75])
);

// Calibration channel (with loopback)			
front_TDC_1ch_cs tdc_multi_ch_0_front_TDC_1ch_inst(
       		.sys_clk(tdc_source_clk),
         	.sys_clk0(sys_clk0_s),
         	.sys_clk1(sys_clk1_s),
         	.sys_clk2(sys_clk2_s),
         	.sys_clk3(sys_clk3_s),
         	.sys_clk4(sys_clk4_s),
         	.sys_clk5(sys_clk5_s),
         	.sys_clk6(sys_clk6_s),
         	.sys_clk7(sys_clk7_s),
         	.sys_clk8(sys_clk8_s),
         	.sys_clk9(sys_clk9_s),
         	.sys_clk10(sys_clk10_s),
         	.sys_clk11(sys_clk11_s),
         			
         	.sys_rst0(sys_rst0),
         	.sys_rst1(sys_rst1),
         	.sys_rst2(sys_rst2),
         	.sys_rst3(sys_rst3),
         	.sys_rst4(sys_rst4),
         	.sys_rst5(sys_rst5),
         	.sys_rst6(sys_rst6),
         	.sys_rst7(sys_rst7),	
         	.sys_rst8(sys_rst8),
         	.sys_rst9(sys_rst9),	
         	.sys_rst10(sys_rst10),	
         	.sys_rst11(sys_rst11),	
         			
			.ch_num(8'h4A),
			.i_tdc_in(i_tdc_in[74]),
			.cali_mode(cali_mode),
			.stop1(stop_oper),
			.stop2(stop_oper),
			.i_calib_bit(calib_bit),			
			.fifo_rst(fifo_rst),
			.tdc_datas(tdc_datas),
			.fifo_empty(multi_fifo_empty[74]),
			.fifo_full(multi_fifo_full[74]),
			.fifo_rd_en(multi_fifo_rd_en[74]),
			.fifo_data(multi_fifo_data[74])
);


front_TDC_1ch front_TDC_1ch_ref_inst(
       		.sys_clk(tdc_source_clk),
         	.sys_clk0(sys_clk0_s),
         	.sys_clk1(sys_clk1_s),
         	.sys_clk2(sys_clk2_s),
         	.sys_clk3(sys_clk3_s),
         	.sys_clk4(sys_clk4_s),
         	.sys_clk5(sys_clk5_s),
         	.sys_clk6(sys_clk6_s),
         	.sys_clk7(sys_clk7_s),
         	.sys_clk8(sys_clk8_s),
         	.sys_clk9(sys_clk9_s),
         	.sys_clk10(sys_clk10_s),
         	.sys_clk11(sys_clk11_s),
         			
         	.sys_rst0(sys_rst0),
         	.sys_rst1(sys_rst1),
         	.sys_rst2(sys_rst2),
         	.sys_rst3(sys_rst3),
         	.sys_rst4(sys_rst4),
         	.sys_rst5(sys_rst5),
         	.sys_rst6(sys_rst6),
         	.sys_rst7(sys_rst7),	
         	.sys_rst8(sys_rst8),
         	.sys_rst9(sys_rst9),	
         	.sys_rst10(sys_rst10),	
         	.sys_rst11(sys_rst11),	
         			
            .ch_num(8'h00),
            .i_tdc_in(tdc_in_ref_w),
            .cali_mode(cali_mode),
			.stop1((!tdc_en_start_arry[0])),
			.stop2((!tdc_en_start_arry2[0])),
			.i_calib_bit(calib_bit),
            .fifo_rst(fifo_rst),
            .fifo_empty(multi_fifo_empty[0]),
            .fifo_full(multi_fifo_full[0]),
            .fifo_rd_en(multi_fifo_rd_en[0]),
            .tdc_datas(ch0_tdc_datas[11:0]),
            .fifo_data(multi_fifo_data[0])
);
// TDC input channels
genvar var_i;
	generate
		for (var_i=1; var_i < NUM_OF_CHANNEL-2; var_i=var_i+1) 
		begin: tdc_multi_ch 
         
front_TDC_1ch front_TDC_1ch_inst(
       		.sys_clk(tdc_source_clk),
         	.sys_clk0(sys_clk0_s),
         	.sys_clk1(sys_clk1_s),
         	.sys_clk2(sys_clk2_s),
         	.sys_clk3(sys_clk3_s),
         	.sys_clk4(sys_clk4_s),
         	.sys_clk5(sys_clk5_s),
         	.sys_clk6(sys_clk6_s),
         	.sys_clk7(sys_clk7_s),
         	.sys_clk8(sys_clk8_s),
         	.sys_clk9(sys_clk9_s),
         	.sys_clk10(sys_clk10_s),
         	.sys_clk11(sys_clk11_s),
         			
         	.sys_rst0(sys_rst0),
         	.sys_rst1(sys_rst1),
         	.sys_rst2(sys_rst2),
         	.sys_rst3(sys_rst3),
         	.sys_rst4(sys_rst4),
         	.sys_rst5(sys_rst5),
         	.sys_rst6(sys_rst6),
         	.sys_rst7(sys_rst7),	
         	.sys_rst8(sys_rst8),
         	.sys_rst9(sys_rst9),	
         	.sys_rst10(sys_rst10),	
         	.sys_rst11(sys_rst11),	
         			
            .ch_num(var_i),
            .i_tdc_in(i_tdc_in[var_i]),
            .cali_mode(cali_mode),
			.stop1((!tdc_en_start_arry[var_i])),
			.stop2((!tdc_en_start_arry2[var_i])),
			.i_calib_bit(calib_bit),
            .fifo_rst(fifo_rst),
            .fifo_empty(multi_fifo_empty[var_i]),
            .fifo_full(multi_fifo_full[var_i]),
            .fifo_rd_en(multi_fifo_rd_en[var_i]),
//            .tdc_datas(multi_tdc_datas[var_i][11:0]),
            .tdc_datas(),
            .fifo_data(multi_fifo_data[var_i])
);
end
endgenerate

// A macro to pack arrays
`PACK_ARRAY(64,NUM_OF_CHANNEL,multi_fifo_data,packed_fifo_data)
      
// FIFO to DMA	  
high_speed_trans # (
       		.NUM_OF_CHANNEL(NUM_OF_CHANNEL)
) high_speed_trans_inst(
       		.wr_clk(tdc_source_clk),
       		.rd_clk(tdc_source_clk),
//       		.reset_n(reset_n),
       		.reset_n(!ui_rst),
       		.start(),
       		.fifo_rst(fifo_rst),
       		.rd_en(multi_fifo_rd_en),
       		.empty(multi_fifo_empty),
       		.din(packed_fifo_data),
			
			.tp_gen_start(regfiles_axi4_0_sel_fifo2ddr_pin),
			.tp_mode(regfiles_axi4_0_sel_fifo2ddr_pin),
			
       		.ct_state_test(ct_state_test),
       		.dout_test(dout_test),
       		.sel_cnt_test(sel_cnt_test),
       		.wr_out_test(wr_out_test),
       		.read_ready_que_test(read_ready_que_test),
       		.fifo_ready(fifo_ready_hst),
       		.fifo_full(),
       		.fifo_rd_en(fifo_rd_en_mux),
       		.fifo_data(fifo_data_hst),
       		
       		.TVALID_TEST (TVALID_TEST ),
            .TDATA_TEST (TDATA_TEST ),
            .TREADY_TEST (TREADY_TEST ),
            .TLAST_TEST (TLAST_TEST ),
            .STATE_TEST (STATE_TEST ),
            .fifo2ddr_nr_of_writes_TEST(fifo2ddr_nr_of_writes_TEST)       		
);

assign fifo_rd_en_mux = fifo2ddr_0_rd_en_pin;
assign fifo2ddr_0_dout_pin = fifo_data_hst;
assign fifo2ddr_0_empty_pin = !fifo_ready_hst;

     
// AXI system
axi_system_wrapper axi_system_inst (
           .M_AXIS_TDATA_TEST(TDATA_TEST),
           .M_AXIS_TLAST_TEST(TLAST_TEST),
           .M_AXIS_TREADY_TEST(TREADY_TEST),
           .M_AXIS_TVALID_TEST(TVALID_TEST),
           .STATE_TEST(STATE_TEST),
           .nr_of_writes_TEST(nr_of_writes_TEST),
           .S_AXI_WDATA_dbg(S_AXI_WDATA_dbg),
           .S_AXI_WSTRB_dbg(S_AXI_WSTRB_dbg),
           .axi_awaddr_dbg(axi_awaddr_dbg),
           .s_axi_awaddr_dbg(s_axi_awaddr_dbg),
		   .axi_c2c_link_status_out (axi_chip2chip_0_axi_c2c_link_status_out_pin),
		   .axi_c2c_multi_bit_error_out (axi_chip2chip_0_axi_c2c_multi_bit_error_out_pin),
		   .axi_c2c_selio_rx_clk_in (axi_chip2chip_0_axi_c2c_selio_rx_clk_in_pin),
		   .axi_c2c_selio_rx_data_in (axi_chip2chip_0_axi_c2c_selio_rx_data_in_pin),
		   .axi_c2c_selio_tx_clk_out (axi_chip2chip_0_axi_c2c_selio_tx_clk_out_pin),
		   .axi_c2c_selio_tx_data_out (axi_chip2chip_0_axi_c2c_selio_tx_data_out_pin),
//		   .ext_reset_in (reset_n),
		   .ext_reset_in (sys_rst_n),		   
           .gp0(),
           .empty (fifo2ddr_0_empty_pin),
           .dout (fifo2ddr_0_dout_pin),           
           .rd_en (fifo2ddr_0_rd_en_pin),
           .slv_reg_wren_dbg(slv_reg_wren_dbg),
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
           .init_calib_complete(init_calib_complete),
//           .mmcm_locked(dcm_locked),
//           .sys_clk_i(sys_clk_200MHz),
           .sys_clk_n(sys_clk_n),
           .sys_clk_p(sys_clk_p),
           .sys_rst(sys_rst),
           .fifo2stream_start(),
           .fifo_rst(fifo_rst),
           .once_down(gen_test_pulse_0_once_down_pin_int),
           .ps_data(regfiles_axi4_0_ps_data_pin),
           .ps_incdec(regfiles_axi4_0_ps_incdec_pin),
           .ps_sel(regfiles_axi4_0_ps_sel_pin),
           .ps_start(regfiles_axi4_0_ps_start_pin),
           .rg_dur(rg_dur),
           .sel_fifo2ddr(regfiles_axi4_0_sel_fifo2ddr_pin),
           .fifo2stream_numofwrite(),
           .soft_tdc_en(soft_tdc_en),
           .stop_oper(stop_oper),
           .calib_bit(calib_bit),
           .dac_spi_data(dac_spi_data),
           .dac_spi_start(dac_spi_start),   
           .clk_spi_start(clk_spi_start),
           .clk_spi_data(clk_spi_data),
		   .sys_clk0 (sys_clk0_s),
           .sys_clk1 (sys_clk1_s),
           .sys_clk2 (sys_clk2_s),
           .sys_clk3 (sys_clk3_s),
           .sys_clk4 (sys_clk4_s),
           .sys_clk5 (sys_clk5_s),
           .sys_clk6 (sys_clk6_s),
           .sys_clk7 (sys_clk7_s),
           .sys_clk8 (sys_clk8_s),
           .sys_clk9 (sys_clk9_s),
           .sys_clk10 (sys_clk10_s),
           .sys_clk11 (sys_clk11_s), 
           .clk_200MHz(clk_200MHz), 
           .tdc_en_bypass_on(tdc_en_bypass_on),
           .tdc_en_p_dur(),
           .tdc_en_p_start(tdc_en_p_start),           
           .tdc_in (tdc_datas),    
           .clk_in1(ui_clk),     
           .ui_clk(ui_clk),
           .ui_clk_sync_rst(ui_rst)		       // active high reset			 			 
);     
/*
IBUFGDS # 
(
         .DIFF_TERM    ("TRUE"),
         .IBUF_LOW_PWR ("FALSE")
) sys_clk_ref 
(
        .O(sys_clk_200MHz_ibufg),
        .I(sys_clk_p),
        .IB(sys_clk_n)
);

BUFG sys_clk_ref_bufg (
    .O    (sys_clk_200MHz),
    .I    (sys_clk_200MHz_ibufg)
);
*/
assign gen_test_pulse_0_once_down_pin = gen_test_pulse_0_once_down_pin_int;


assign sma_dac_sync = dsi_sync;
assign sma_dac_clk = dsi_sclk;
assign sma_dac_data = dsi_data;


DSI DSI_inst (
            .sys_clk(tdc_source_clk),
            .sys_rst(!ui_rst),
            
            
            .i_dsi_start(dac_spi_start),
            
            .i_dsi_data(dac_spi_data),
            
            .o_ct_state(),
            .o_nt_state(),
            .o_dsi_sclk(dsi_sclk),
            .o_dsi_sync(dsi_sync),
            .o_dsi_sdata(dsi_data)
);

SPI_CLK SPI_CLK_inst (
            .sys_clk(tdc_source_clk),
            .sys_rst(!ui_rst),
            
            
            .i_dsi_start(clk_spi_start),
            
            .i_dsi_data(clk_spi_data),
            
            .o_ct_state(ct_state),
            .o_nt_state(nt_state),
            .o_dsi_sclk(spi_clk_sclk),
            .o_dsi_sync(spi_clk_sync),
            .o_dsi_sdata(spi_clk_data)
);

assign o_spi_clk_sync = spi_clk_sync;
assign o_spi_clk_sclk = spi_clk_sclk;
assign o_spi_clk_data = spi_clk_data;

/*
ila_0 ila_0_inst (
    .clk(tdc_source_clk),        			 // input wire clk
    .probe0(nr_of_writes_TEST),		         // input wire [31 : 0] probe0
    .probe1(TDATA_TEST),		             // input wire [31 : 0] probe0
    .probe2(TLAST_TEST),		             // input wire [0 : 0] probe0
    .probe3(TREADY_TEST),		             // input wire [0 : 0] probe0
    .probe4(TVALID_TEST),		             // input wire [0 : 0] probe0
    .probe5(STATE_TEST)		                 // input wire [3 : 0] probe0
);
*/
endmodule
