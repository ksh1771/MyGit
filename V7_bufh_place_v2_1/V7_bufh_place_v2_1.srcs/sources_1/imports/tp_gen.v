/*
test pattern generating module 
*/


`timescale 1 ns / 1 ps

module tp_gen (
input				sys_clk,						// system  clock
input				sys_rst,						// active low reset 
		
input				i_tp_gen_start,					// start
input               i_fifo_full,                    // fifo full flag

output reg			o_wr_en,
output wire [63:0]	o_tp
);

reg	[1:0]						ct_state, nt_state;
parameter [1:0] 				ST_INIT = 2'b00, ST_0 = 2'b01;
parameter [15:0]				PATTERN_LEN = 16'hFFFF;
reg								op_cycle_cnt_ld, op_cycle_cnt_sel;
reg [15:0]						op_cycle_cnt;
wire [15:0]						op_cycle_cnt_int;

reg [2:0]						tp_gen_start_r;
reg								tp_gen_start;
wire							wr_en;

				
// operation cycle count register
always @(posedge sys_clk)												
		if (!sys_rst) 
			op_cycle_cnt <= 0;
		else 
			if(op_cycle_cnt_ld == 1'b1) 
				op_cycle_cnt <= op_cycle_cnt_int;	
assign op_cycle_cnt_int = op_cycle_cnt_sel ? op_cycle_cnt + 1 : 0;	// op_cycle_cnt_sel (0: reset, 1: increase by 1)
	
// start signal
always @(posedge sys_clk)		
		if (!sys_rst) begin 
			tp_gen_start_r <= 0;
			tp_gen_start <= 0; 
		end
		else begin
			tp_gen_start_r[0] <= i_tp_gen_start;		
			tp_gen_start_r[1] <= tp_gen_start_r[0];
			tp_gen_start_r[2] <= tp_gen_start_r[1];			
			tp_gen_start <= ((!tp_gen_start_r[2]) & tp_gen_start_r[1]);			
		end	
			
// State machine				
always @(posedge sys_clk)
		if (!sys_rst) 
			ct_state <= ST_INIT;
		else 
			ct_state <= nt_state;
			
// State transition
always @(ct_state or tp_gen_start or op_cycle_cnt)
	case (ct_state)
	ST_INIT: begin	
			if (tp_gen_start == 1'b1)
				nt_state <= ST_0;
			else 
				nt_state <= ct_state;			
		end
	ST_0: begin												
			if (op_cycle_cnt != PATTERN_LEN)				
				nt_state <= ct_state;					
			else
				nt_state <= ST_INIT;	
		end
	default: nt_state <= ST_INIT;
	endcase

	// State output
always @(ct_state or tp_gen_start or op_cycle_cnt or i_fifo_full)
	case (ct_state)
	ST_INIT: begin
			op_cycle_cnt_ld <= 1;
			op_cycle_cnt_sel <= 1'b0;						// reset op_cycle_cnt register
		end
	ST_0: begin
			if ((op_cycle_cnt != PATTERN_LEN) && (i_fifo_full != 1'b1)) begin	
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b1;	                  // increase op_cycle_cnt value
			end
			else if ((i_fifo_full == 1'b1) && (op_cycle_cnt != PATTERN_LEN)) begin
				op_cycle_cnt_ld <= 1'b0;
                op_cycle_cnt_sel <= 1'b0;                    // do nothing
			end
			else begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b0;					// clear op_cycle_cnt
			end	
		end				
	default: begin
			op_cycle_cnt_ld <= 1'b0;
			op_cycle_cnt_sel <= 1'bx;						// don't care
			end
	endcase

assign o_tp = {48'h000000000000, op_cycle_cnt};
assign wr_en = (ct_state == ST_0) ? 1'b1 : 1'b0;

always @(posedge sys_clk)												
		if (!sys_rst) 
			o_wr_en <= 0;
		else 
			o_wr_en <= wr_en; 
/*
ila_0 ila_0_inst (
    .clk(sys_clk),        			// input wire clk
    .probe0(ct_state),  			// input wire [1 : 0] probe0
    .probe1(nt_state),  		    // input wire [1 : 0] probe1
    .probe2(op_cycle_cnt), 		    // input wire [15 : 0] probe2
    .probe3(i_fifo_full)            // input wire [0 : 0] probe3
);
*/

endmodule