module front_TDC_1ch
(
    input sys_clk,
    input sys_clk0,
    input sys_clk1,
    input sys_clk2,
    input sys_clk3,
    input sys_clk4,
    input sys_clk5,
    input sys_clk6,
    input sys_clk7,
    input sys_clk8,
    input sys_clk9,
    input sys_clk10,
    input sys_clk11,

	input sys_rst0,
	input sys_rst1,
	input sys_rst2,
	input sys_rst3,
	input sys_rst4,
	input sys_rst5,
	input sys_rst6,
	input sys_rst7,
	input sys_rst8,
	input sys_rst9,
	input sys_rst10,
	input sys_rst11,

	input [7:0] ch_num,
	input i_tdc_in,
	input cali_mode,
	input stop1,
	input stop2,
	input [11:0] i_calib_bit,
	input fifo_rst,
	output fifo_empty,
	output fifo_full,
	input fifo_rd_en,
	output [11:0] tdc_datas,
	output [63:0] fifo_data
);


  wire [11:0]  					tdc_data_0;
  wire [11:0]  					tdc_data_1;

  assign tdc_datas = tdc_data_1;

  front_dFFs_v3 front_dFFs_inst0_0 (
  		.sys_clk0(sys_clk0),
  		.sys_clk1(sys_clk1),
  		.sys_clk2(sys_clk2),
  		.sys_clk3(sys_clk3),
  		.sys_clk4(sys_clk4),
  		.sys_clk5(sys_clk5),
  		.sys_clk6(sys_clk6),
  		.sys_clk7(sys_clk7),
  		.sys_clk8(sys_clk8),
  		.sys_clk9(sys_clk9),
  		.sys_clk10(sys_clk10),
  		.sys_clk11(sys_clk11),
  		
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
  		
  		.i_tdc_in(i_tdc_in),
  		
  		.o_tdc_data(tdc_data_0)
  );

  front_dFFs_v4 front_dFFs_inst0_1 (
  		.sys_clk0(sys_clk0),
  		.sys_clk1(sys_clk1),
  		.sys_clk2(sys_clk2),
  		.sys_clk3(sys_clk3),
  		.sys_clk4(sys_clk4),
  		.sys_clk5(sys_clk5),
  		.sys_clk6(sys_clk6),
  		.sys_clk7(sys_clk7),
  		.sys_clk8(sys_clk8),
  		.sys_clk9(sys_clk9),
  		.sys_clk10(sys_clk10),
  		.sys_clk11(sys_clk11),
  		
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
  		
  		.i_tdc_in(tdc_data_0),
  		
  		.o_tdc_data(tdc_data_1)
  );

  rle_enc_v2 rle_enc_inst_0 (
		.sys_clk(sys_clk),
        //.sys_clk0(sys_clk0),
        .sys_clk0(sys_clk11),
        //.sys_rst(sys_rst0),
        .sys_rst(sys_rst11),
  		  		
		.ch_num(ch_num),
  		.i_tdc_in(tdc_data_1),
		.stop1(stop1),
		.stop2(stop2),
		.i_calib_bit(i_calib_bit),
		.fifo_rst(fifo_rst),
		.fifo_empty(fifo_empty),
		.fifo_full(fifo_full),
		.fifo_rd_en(fifo_rd_en),
		.fifo_data(fifo_data)
	);

        
        
endmodule
