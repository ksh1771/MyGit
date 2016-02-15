module rle_enc_tdc_en #
(
parameter				   NUM_OF_CHANNEL 			= 64
)
(
input						sys_clk,
input 						sys_rst,
input						sys_clk0,	
input [7:0] 				ch_num,
input [11:0] 				i_tdc_en,
input 						stop,
output                      o_tdc_en_start,
output reg [NUM_OF_CHANNEL-1:0]             tdc_en_start_arry,
output reg [NUM_OF_CHANNEL-1:0]             tdc_en_start_arry2,

input [11:0]                i_calib_bit,
input						fifo_rst,
output 						fifo_empty,
output 						fifo_full,
input 						fifo_rd_en,
output [63:0] 				fifo_data
);


reg [38:0]					integer_counter;
reg [38:0]                  integer_counter_r;
reg [38:0]                  integer_counter_r2;
reg [38:0]                  integer_counter_r3;
reg [38:0]                  integer_counter_r4;
reg [38:0]                  integer_counter_r5;
reg [38:0]                  integer_counter_r6;
reg [38:0]                  integer_counter_r7;
reg [38:0]                  integer_counter_r8;
reg [38:0]                  integer_counter_r9;


wire                        hit_w1, hit_w2;
reg 						hit_w1_r, hit_w2_r;
reg							hit_d1, hit_d2, hit_d3, hit_d4, hit_d5, hit_d6, hit_d7, hit_d8;
reg                         ch_fifo_full_r;


(* dont_touch = "true" *)   reg	[11:0] tdc_data_d0;
(* dont_touch = "true" *)   reg	[11:0] tdc_data_d1;
(* dont_touch = "true" *)   reg	[11:0] tdc_data_d2;
(* dont_touch = "true" *)   reg	[11:0] tdc_data_d3;
(* dont_touch = "true" *)   reg	[11:0] tdc_data_d4;
//(* dont_touch = "true" *)   reg	[11:0] tdc_data_d5;

reg [16:0]                  tdc_data_r, tdc_data_r2, tdc_data_r3, tdc_data_r4, tdc_data_r5;
wire 	[63:0]				fifo_data_tmp;

reg                         fifo_full_flag_r, fifo_full_flag_r2, fifo_full_flag_r3;
wire                        full_flag_w, full_flag_bar;
reg                         full_flag_set, full_flag_clr;
reg [11:0]                  calib_bit, calib_bit_r1, calib_bit_r2;
wire						fifo_wd_en;
wire [63:0]				    ch_fifo_dout;
wire						ch_fifo_full;
wire						ch_fifo_rd_en;
wire						ch_fifo_empty;
wire						ch_fifo_rst;
//wire                        hit_w1, hit_w2;
reg	                        hit_w1h_r, hit_w1l_r, hit_w2h_r, hit_w2l_r;	
wire                        hit_w1h, hit_w1l, hit_w2h, hit_w2l;
reg                         hit_d11, hit_d12;
reg 						tdc_en_start;
wire 						hit0_w, hit1_w;
reg 						end_of_tdc_en;
reg 						hit0_r, hit1_r;
reg [1:0]					end_of_tdc_en_r;

assign ch_fifo_rst = fifo_rst | sys_rst;

assign o_tdc_en_start = tdc_en_start;

ch_fifo ch_fifo_inst(
  .rst(ch_fifo_rst), // input rst
  .wr_clk(sys_clk0), // input wr_clk
  .rd_clk(sys_clk), // input rd_clk
  .din(fifo_data_tmp), // input [63 : 0] din
  .wr_en(fifo_wd_en), // input wr_en
  .rd_en(ch_fifo_rd_en), // input rd_en
  .dout(ch_fifo_dout), // output [63 : 0] dout
  .full(ch_fifo_full), // output full
  .empty(ch_fifo_empty) // output empty  
);
assign fifo_empty = ch_fifo_empty;
assign fifo_full = ch_fifo_full; 
assign fifo_data = ch_fifo_dout;
assign ch_fifo_rd_en = fifo_rd_en;


assign fifo_wd_en = hit_d4;

assign fifo_data_tmp[63:24] = {1'b0, integer_counter_r2};
assign fifo_data_tmp[23:17] = ch_num[6:0];
assign fifo_data_tmp[16:0]  = tdc_data_r2[16:0];

// integer_counter register
always @(posedge sys_clk0)	
		if (sys_rst) 
			integer_counter <= 0;
		else begin
			if(tdc_en_start == 1'b1) 
				integer_counter <= integer_counter + 1;	
			else
			  	integer_counter <= 0;
	   end
			  	
always @(posedge sys_clk0)	
//always @(negedge sys_clk0)	
	if (sys_rst) begin
		tdc_data_d0 <= 0;
		tdc_data_d1 <= 0;
		tdc_data_d2 <= 0;
		tdc_data_d3 <= 0;
		tdc_data_d4 <= 0;		
		integer_counter_r <= 0;
		integer_counter_r2 <= 0;
		tdc_data_r <= 0;
		tdc_data_r2 <= 0;
	end
	else begin 
		tdc_data_d0 <= i_tdc_en;
		tdc_data_d1 <= tdc_data_d0;
		tdc_data_d2 <= tdc_data_d1;
		tdc_data_d3 <= tdc_data_d2;
		tdc_data_d4 <= tdc_data_d3;		
		integer_counter_r <= integer_counter;
		integer_counter_r2 <= integer_counter_r;		
		tdc_data_r <= {tdc_data_d2[1], tdc_data_d2[0], tdc_data_d3, tdc_data_d4[11], tdc_data_d4[10], tdc_data_d4[0]};
		tdc_data_r2 <= tdc_data_r;
	end


always @(posedge sys_clk0)	
		if (sys_rst) begin
			hit0_r <= 0;
			hit1_r <= 0;
		end
		else begin
			hit0_r <= hit0_w;
			hit1_r <= hit1_w;
		end
		
always @(posedge sys_clk0)	
		if (sys_rst) begin
			end_of_tdc_en_r <= 0;
			end_of_tdc_en <= 0;
		end
		else begin
			end_of_tdc_en_r[0] <= i_tdc_en;
			end_of_tdc_en_r[1] <= end_of_tdc_en_r[0];
			end_of_tdc_en <= (~end_of_tdc_en_r[0]) & end_of_tdc_en_r[1];
		end
		
always @(posedge sys_clk0)
//always @(negedge sys_clk0)		
		if (sys_rst) begin
			hit_d1 <= 0;
			hit_d2 <= 0;
			hit_d3 <= 0;	
			hit_d4 <= 0;			
		end
		else begin
			hit_d1 <= (hit0_r | hit1_r);
			hit_d2 <= hit_d1;
			hit_d3 <= hit_d2;	
			hit_d4 <= hit_d3;			
					
		end

always @(posedge sys_clk0)	
		if (sys_rst) begin
			tdc_en_start <= 0;
			tdc_en_start_arry <= 0;
			tdc_en_start_arry2 <= 0;
		end
		else begin
			if((stop == 1'b0) && (hit_d1 == 1'b1)) begin		
				tdc_en_start <= 1;
				tdc_en_start_arry <= {NUM_OF_CHANNEL{1'b1}};
				tdc_en_start_arry2 <= {NUM_OF_CHANNEL{1'b1}};
			end
			else if ((stop == 1'b1) || (end_of_tdc_en == 1'b1)) begin
				tdc_en_start <= 0;
				tdc_en_start_arry <= {NUM_OF_CHANNEL{1'b0}};		
				tdc_en_start_arry2 <= {NUM_OF_CHANNEL{1'b0}};		
			end		
			else begin
			  	tdc_en_start <= tdc_en_start;
			  	tdc_en_start_arry <= tdc_en_start_arry;
			  	tdc_en_start_arry2 <= tdc_en_start_arry2;
			end
	   end
	 
	 
// detecting rising edge only		
assign hit0_w = ((tdc_data_d0[0] == 1'b1) && (tdc_data_d0[11] == 1'b0))? 1 : 0;
assign hit1_w = ((tdc_data_d0[0] == 1'b1) && (tdc_data_d0[11] == 1'b1) && (tdc_data_d1[0] == 1'b0))? 1 : 0;
/*
ila_1 ila_1_inst (
    .clk(sys_clk0),        			          // input wire clk
    .probe0(tdc_data_d0),		              // input wire [11 : 0] probe0
    .probe1(hit_d3),		                  // input wire [0 : 0] probe0
    .probe2(tdc_en_start),		             // input wire [0 : 0] probe0
    .probe3(i_tdc_en)		                 // input wire [0 : 0] probe0
);
*/		
//assign hit_w1h = {tdc_data_d1[0], tdc_data_d0[11:7]} == 6'b000000 ? 0 : 1;
//assign hit_w1l = {tdc_data_d0[6:0]} == 7'b0000000 ? 0 : 1;


//assign hit_w2h = {tdc_data_d1[0], tdc_data_d0[11:7]} == 6'b111111 ? 0 : 1;
//assign hit_w2l = {tdc_data_d0[6:0]} == 7'b1111111 ? 0 : 1;

endmodule
