module front_TDC_1ch_cs
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
  reg  [11:0]					tdc_data_2, tdc_data_3;	

  assign tdc_datas = tdc_data_3;

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
/*
  rle_enc rle_enc_inst_0 (
		.sys_clk(sys_clk),
  		.sys_clk0(sys_clk0),
  		
  		.sys_rst(sys_rst0),
  		
		.ch_num(ch_num),
  		.i_tdc_in(tdc_data_1),
		.stop(stop),
		.fifo_empty(fifo_empty),
		.fifo_full(fifo_full),
		.fifo_rd_en(fifo_rd_en),
		.fifo_data(fifo_data)
	);
*/
  rle_enc_v2 rle_enc_inst_cs (
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
	
	
    always @(posedge sys_clk0 or posedge sys_rst0)		
    		if (sys_rst0) begin 
    			tdc_data_2[0] <= 0;
    			tdc_data_3[0] <= 0;
    		end
    		else begin 
    			tdc_data_2[0] <= tdc_data_1[0];
    			tdc_data_3[0] <= tdc_data_2[0];
            end
            
    always @(posedge sys_clk1 or posedge sys_rst1)		
    		if (sys_rst1) begin 
    			tdc_data_2[1] <= 0;
    			tdc_data_3[1] <= 0;
    		end
    		else begin 
    			tdc_data_2[1] <= tdc_data_1[1];
    			tdc_data_3[1] <= tdc_data_2[1];
            end
            
    always @(posedge sys_clk2 or posedge sys_rst2)		
    		if (sys_rst2) begin 
    			tdc_data_2[2] <= 0;
    			tdc_data_3[2] <= 0;
    		end
    		else begin 
    			tdc_data_2[2] <= tdc_data_1[2];
    			tdc_data_3[2] <= tdc_data_2[2];
            end
            
    always @(posedge sys_clk3 or posedge sys_rst3)		
    		if (sys_rst3) begin 
    			tdc_data_2[3] <= 0;
    			tdc_data_3[3] <= 0;
    		end
    		else begin 
    			tdc_data_2[3] <= tdc_data_1[3];
    			tdc_data_3[3] <= tdc_data_2[3];
            end
            
    always @(posedge sys_clk4 or posedge sys_rst4)		
    		if (sys_rst4) begin 
    			tdc_data_2[4] <= 0;
    			tdc_data_3[4] <= 0;
    		end
    		else begin 
    			tdc_data_2[4] <= tdc_data_1[4];
    			tdc_data_3[4] <= tdc_data_2[4];
            end
            
    always @(posedge sys_clk5 or posedge sys_rst5)		
    		if (sys_rst5) begin 
    			tdc_data_2[5] <= 0;
    			tdc_data_3[5] <= 0;
    		end
    		else begin 
    			tdc_data_2[5] <= tdc_data_1[5];
    			tdc_data_3[5] <= tdc_data_2[5];
            end
            
    always @(posedge sys_clk6 or posedge sys_rst6)		
    		if (sys_rst6) begin 
    			tdc_data_2[6] <= 0;
    			tdc_data_3[6] <= 0;
    		end
    		else begin 
    			tdc_data_2[6] <= tdc_data_1[6];
    			tdc_data_3[6] <= tdc_data_2[6];
            end
            
    always @(posedge sys_clk7 or posedge sys_rst7)		
    		if (sys_rst7) begin 
    			tdc_data_2[7] <= 0;
    			tdc_data_3[7] <= 0;
    		end
    		else begin 
    			tdc_data_2[7] <= tdc_data_1[7];
    			tdc_data_3[7] <= tdc_data_2[7];
            end
            
    always @(posedge sys_clk8 or posedge sys_rst8)		
    		if (sys_rst8) begin 
    			tdc_data_2[8] <= 0;
    			tdc_data_3[8] <= 0;
    		end
    		else begin 
    			tdc_data_2[8] <= tdc_data_1[8];
    			tdc_data_3[8] <= tdc_data_2[8];
            end
            
    always @(posedge sys_clk9 or posedge sys_rst9)		
    		if (sys_rst9) begin 
    			tdc_data_2[9] <= 0;
    			tdc_data_3[9] <= 0;
    		end
    		else begin 
    			tdc_data_2[9] <= tdc_data_1[9];
    			tdc_data_3[9] <= tdc_data_2[9];
            end
            
    always @(posedge sys_clk10 or posedge sys_rst10)		
    		if (sys_rst10) begin 
    			tdc_data_2[10] <= 0;
    			tdc_data_3[10] <= 0;
    		end
    		else begin 
    			tdc_data_2[10] <= tdc_data_1[10];
    			tdc_data_3[10] <= tdc_data_2[10];
            end
            
    always @(posedge sys_clk11 or posedge sys_rst11)		
    		if (sys_rst11) begin 
    			tdc_data_2[11] <= 0;
    			tdc_data_3[11] <= 0;
    		end
    		else begin 
    			tdc_data_2[11] <= tdc_data_1[11];
    			tdc_data_3[11] <= tdc_data_2[11];
            end	

endmodule
