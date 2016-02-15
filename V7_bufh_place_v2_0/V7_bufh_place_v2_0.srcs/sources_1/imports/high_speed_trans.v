//  --========================================================================--
//  This confidential and proprietary software may be used only as
//  authorised by a licensing agreement from FEDA Limited
//    (C) COPYRIGHT 2012 FEDA Limited
//        ALL RIGHTS RESERVED
//  The entire notice above must be reproduced on all authorised
//  copies and copies may only be made to the extent permitted
//  by a licensing agreement from FEDA Limited.
//  
//  ----------------------------------------------------------------------------
//  Version and Release Control Information:
//  
//  File Name           : rle_enc.v
//  File Revision       : 1.00
//  
//  Release Information : 
//  
//  ----------------------------------------------------------------------------
//  Purpose             : High Speed Trans
//                        Arbitration between multi fifo and puts data to 
//                        one big fifo to send outof the chip
//  --========================================================================--
`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate

`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module high_speed_trans #
(
parameter								NUM_OF_CHANNEL 			= 64
)
(
input									wr_clk,
input									rd_clk,
input 									reset_n,
input									start,
input                                   fifo_rst,

output [NUM_OF_CHANNEL-1:0] 			rd_en,
input [NUM_OF_CHANNEL-1:0]  			empty,
input [64*NUM_OF_CHANNEL-1:0]			din,

input									tp_gen_start,
input									tp_mode,


output [2:0]							ct_state_test,
output [63:0]							dout_test,
output									wr_out_test,
output [11:0]							sel_cnt_test,
output [3:0]							read_ready_que_test,
output									fifo_ready,
output									fifo_full,
input									fifo_rd_en,
output [63:0]			    			fifo_data,

input       							TVALID_TEST,
input [31:0]							TDATA_TEST,
input									TREADY_TEST,
input									TLAST_TEST,
input [3:0]								STATE_TEST,
input [31:0]                            fifo2ddr_nr_of_writes_TEST
);

//------------------------------------------------------------------------------
// Signal declarations
//------------------------------------------------------------------------------
parameter [2:0]				IDLE = 3'b000,READ_DATA_FROM_FIFO = 3'b001, WRITE_DATA_TO_FIFO = 3'b010;

reg [2:0]						ct_state, nt_state;
reg [11:0]						sel_cnt;
reg								wr_out_r;
reg	[NUM_OF_CHANNEL-1:0]		rd_en_r;
wire [63:0]						dout_r;

reg [NUM_OF_CHANNEL-1:0]		read_ready_que;
reg								read_fifo_load;
reg								write_fifo_done;
reg 							found;
reg 							found2;

wire                            fifo_almost_full;
wire							fifo_empty;
wire [63:0]					    unpacked_din [0:NUM_OF_CHANNEL-1];
wire 							wr_out_mux;
//wire 							tp_mode;
(* dont_touch = "true" *)       wire [63:0] dout_mux;
wire [63:0]                     tp_data;
//(* dont_touch = "true" *)       wire [63:0] dout_mux_w;

reg [63:0]                      dout_mux_r;
reg                             wr_out_mux_r;
reg                             wr_out_mux_r2;

(* dont_touch = "true" *)       wire fifo_full_w;
(* dont_touch = "true" *)       wire [63:0] dout_mux_add;
(* dont_touch = "true" *)       reg [63:0] dout_mux_add_r;



`UNPACK_ARRAY(64,NUM_OF_CHANNEL,unpacked_din,din)


assign ct_state_test = ct_state;
assign dout_test = dout_r;
assign wr_out_test = wr_out_r;
assign sel_cnt_test = sel_cnt;
assign read_ready_que_test = read_ready_que;

always @(posedge rd_clk)
begin
	if(reset_n == 1'b0) begin
		wr_out_r <= 0;
	end
	else if(ct_state == WRITE_DATA_TO_FIFO && nt_state == WRITE_DATA_TO_FIFO) begin
		wr_out_r <= 1'b1;
	end
	else begin
		wr_out_r <= 1'b0;
	end
end
//always @(posedge rd_clk)
//begin
//	if(reset_n == 1'b0) begin
//		dout_r <= 0;
//	end
//	else if(ct_state == WRITE_DATA_TO_FIFO) begin
//		dout_r <= unpacked_din[sel_cnt];
//	end
//	else begin
//		dout_r <= dout_r;
//	end
//end
assign dout_r = unpacked_din[sel_cnt];

integer i;
always @(posedge rd_clk)
begin
  	found = 1'b0;
	if(reset_n == 1'b0) begin
		sel_cnt = 0;
	end
	else if (ct_state == WRITE_DATA_TO_FIFO) begin
//		for (i=0; i<NUM_OF_CHANNEL; i=i+1) begin
		for (i=NUM_OF_CHANNEL-1; i>=0; i=i-1) begin
			if(read_ready_que[i] == 1'b1 && found == 1'b0) begin
				sel_cnt = i;
				found = 1'b1;
			end
		end
	end
end

//------------------------------------------------------------------------------
// Arbitration between NUM_OF_CHANNEL of FIFOs
//------------------------------------------------------------------------------
always @(posedge rd_clk)
begin
	if(reset_n == 1'b0) begin
		rd_en_r <= 1'b0;
	end
	else if (read_fifo_load) begin
		rd_en_r <= ~empty;
	end
	else begin
		rd_en_r <= 1'b0;
	end
end
assign rd_en = rd_en_r;
//------------------------------------------------------------------------------
// State machine				
//------------------------------------------------------------------------------
always @(posedge rd_clk)
	if (!reset_n) 
		ct_state <= IDLE;
	else 
		ct_state <= nt_state;

always @(ct_state or empty or read_ready_que)
	case (ct_state)
	IDLE: begin											
		read_fifo_load <= 0;
		if (~empty) begin
			nt_state <= READ_DATA_FROM_FIFO;
		end
		else begin
			nt_state <= ct_state;			
		end
	end		
	READ_DATA_FROM_FIFO: begin									
		read_fifo_load <= 1;
		nt_state <= WRITE_DATA_TO_FIFO;	
	end
	WRITE_DATA_TO_FIFO: begin									
		read_fifo_load <= 0;
		if(!read_ready_que) begin
			nt_state <= IDLE;
		end
		else begin
			nt_state <= ct_state;
		end
	end
	default: begin
	        nt_state <= IDLE;
            read_fifo_load <= 0;	       
	end
	endcase
//------------------------------------------------------------------------------
// Arbitration between NUM_OF_CHANNEL of FIFOs
//------------------------------------------------------------------------------
always @(posedge rd_clk)
begin
	found2 = 1'b0;
	if(reset_n == 1'b0) begin
		read_ready_que = 0;
	end
	else if (read_fifo_load) begin
		read_ready_que = ~empty;
	end
	else if (ct_state == WRITE_DATA_TO_FIFO) begin
//		for (i=0; i<NUM_OF_CHANNEL; i=i+1) begin
		for (i=NUM_OF_CHANNEL-1; i>=0; i=i-1) begin		
			if(read_ready_que[i] == 1'b1 && found2 == 1'b0) begin
				read_ready_que[i] = 0;
				found2 = 1'b1;
			end
		end
	end
end



//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
wire [63:0] fifo_data_int;
wire        fifo_full_int;
wire        sys_fifo_rst;
wire		wr_out_int, tp_wr_en_int;
wire		fifo_overflow;
wire		fifo_underflow;

//assign wr_out_int = wr_out_r & (~fifo_full_int);
assign wr_out_int = wr_out_r;
assign tp_wr_en_int = tp_wr_en & (~fifo_full_int);


//assign dout_mux_w[63:24] = dout_mux[63:24];
//assign dout_mux_w[13] = (dout_mux[13] | fifo_almost_full);
//assign dout_mux_w[12:0] = dout_mux[12:0]; 

system_big_fifo system_big_fifo_inst(
  .rst(sys_fifo_rst), // input rst
  .wr_clk(wr_clk), // input wr_clk
  .rd_clk(rd_clk), // input rd_clk
//  .din(dout_mux_add), // input [63 : 0] din
  .din(dout_mux_add_r), // input [63 : 0] din
//  .wr_en(wr_out_mux_r), // input wr_en
  .wr_en(wr_out_mux_r2), // input wr_en
  .rd_en(fifo_rd_en), // input rd_en
  .dout(fifo_data_int), // output [63 : 0] dout
  .full(fifo_full_int), // output full
  .empty(fifo_empty), // output empty
  .overflow(fifo_overflow),    // output wire overflow
  .underflow(fifo_underflow),  // output wire underflow
  .almost_full(fifo_almost_full)  
);


assign fifo_ready = !fifo_empty;
assign fifo_data = fifo_data_int;
assign fifo_full = fifo_full_int;
assign sys_fifo_rst = (~reset_n) | fifo_rst;

//assign wr_out_mux = (tp_mode == 1'b1) ? tp_wr_en : wr_out_int;
assign wr_out_mux = (tp_mode == 1'b1) ? tp_wr_en_int : wr_out_int;
assign dout_mux = (tp_mode == 1'b1) ? tp_data : dout_r;
//assign dout_mux = (tp_mode == 1'b1) ? tp_data : {dout_r[63:14], (fifo_almost_full & (~fifo_full_int)), dout_r[12:0]};

always @(posedge wr_clk)
begin
	if(reset_n == 1'b0) begin
		dout_mux_r <= 0;
		wr_out_mux_r <= 0;
		wr_out_mux_r2 <= 0;		
		dout_mux_add_r <= 0;
	end
	else begin
	   dout_mux_r <= dout_mux;
	   wr_out_mux_r <= wr_out_mux;
		wr_out_mux_r2 <= wr_out_mux_r;		
	   dout_mux_add_r <= dout_mux_add;
	end
end

assign fifo_full_w = (fifo_almost_full & (~fifo_full_int));

// [63]: fifo full flag (1 bit)
// [62:24]: integer coounter (39 bits)
// [23:17]: channel number (7 bits)
// [16:0]: fractional counter (17 bits)
assign dout_mux_add = {fifo_full_w, dout_mux_r[62:0]};

tp_gen tp_gen_inst (
	.sys_clk(wr_clk),						
	.sys_rst(reset_n),						 
		
	.i_tp_gen_start(tp_gen_start),			
	.i_fifo_full(fifo_full_int),		

	.o_wr_en(tp_wr_en),
	.o_tp(tp_data)
);

endmodule
