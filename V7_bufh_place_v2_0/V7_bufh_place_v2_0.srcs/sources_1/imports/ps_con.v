/*
Phase Shift Control module for TDC
*/
`timescale 1 ns / 1 ps

module ps_con (
input			sys_clk,							// system main clk, usually running at 100MHz
input			sys_rst,							// system reset Active Low, synchronous with sys_clk
		
input			i_start,						// phase shift function start bit 
input [15:0]		i_ps_data,						// phase shift amount (0-56)
input [3:0]		i_ps_sel,						// phase shift clock selection (0-9)
input			i_incdec,						// 1: inc. , 0: dec.

//output wire		o_ct_state,
//output wire		o_nt_state,						// for debug purpose
output reg				o_state,						// FSM state flag (for debug)
output wire				o_ps_clk,						// phase shift clock
output reg [11:0]		o_psen,							// phase shift enable sen
output wire [11:0]		o_psincdec,						// phase shift inc/dec
input [11:0]				i_psdone
);


reg	[1:0]						ct_state, nt_state;
parameter [1:0] 				ST_INIT = 2'd0,  ST_0 = 2'd1, ST_1 = 2'd2;

wire								ps_data_cnt_ld, ps_data_cnt_sel;
reg [15:0]						ps_data_cnt;

reg [2:0]						start_r;
reg								start;
reg								psen_r, psincdec_r;

wire							state;
wire 							psen, psincdec;

wire [15:0]						PS_DATA;
reg								ps_done;
wire [15:0]						ps_data_cnt_int;

//assign o_ct_state = ct_state;
//assign o_nt_state = nt_state;
assign o_ps_clk = sys_clk;
assign o_psincdec = {psincdec_r, psincdec_r, psincdec_r, psincdec_r, psincdec_r, psincdec_r, psincdec_r, psincdec_r, psincdec_r, psincdec_r, psincdec_r, psincdec_r};
// mux to select clock source
always @(i_ps_sel or psen_r or i_psdone)
	case (i_ps_sel)
	4'd0: begin											// clock source 0
			ps_done <= i_psdone[0];
			o_psen[0] <= psen_r;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end		
	4'd1: begin											// clock source 1
			ps_done <= i_psdone[1];
			o_psen[0] <= 1'b0;
			o_psen[1] <= psen_r;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end	
	4'd2: begin											// clock source 2
			ps_done <= i_psdone[2];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= psen_r;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end	
	4'd3: begin											// clock source 3
			ps_done <= i_psdone[3];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= psen_r;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end		
	4'd4: begin											// clock source 4
			ps_done <= i_psdone[4];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= psen_r;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end		
	4'd5: begin											// clock source 5
			ps_done <= i_psdone[5];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= psen_r;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end		
	4'd6: begin											// clock source 6
			ps_done <= i_psdone[6];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= psen_r;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end		
	4'd7: begin											// clock source 7
			ps_done <= i_psdone[7];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= psen_r;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end		
	4'd8: begin											// clock source 8
			ps_done <= i_psdone[8];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= psen_r;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end		
	4'd9: begin											// clock source 9
			ps_done <= i_psdone[9];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= psen_r;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end			
	4'd10: begin											// clock source 10 
			ps_done <= i_psdone[10];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= psen_r;			
			o_psen[11] <= 1'b0;			
		end			
	4'd11: begin											// clock source 11 
			ps_done <= i_psdone[11];
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= psen_r;			
		end			
	default: begin											// default
			ps_done <= 1'b0;
			o_psen[0] <= 1'b0;
			o_psen[1] <= 1'b0;
			o_psen[2] <= 1'b0;
			o_psen[3] <= 1'b0;
			o_psen[4] <= 1'b0;
			o_psen[5] <= 1'b0;
			o_psen[6] <= 1'b0;
			o_psen[7] <= 1'b0;
			o_psen[8] <= 1'b0;
			o_psen[9] <= 1'b0;			
			o_psen[10] <= 1'b0;			
			o_psen[11] <= 1'b0;			
		end		
	endcase

		
// ps data count register
always @(posedge sys_clk)												
		if (!sys_rst) 
			ps_data_cnt <= 0;
		else 
			if(ps_data_cnt_ld == 1'b1) 
				ps_data_cnt <= ps_data_cnt_int;	
assign ps_data_cnt_int = ps_data_cnt_sel ? ps_data_cnt + 1 : 0;	// ps_data_cnt_sel (0: reset, 1: increase by 1)



always @(posedge sys_clk)	
		if (!sys_rst) begin 
			start_r <= 0;			
			start <= 0;
			psen_r <= 0;
			psincdec_r <= 0;
			o_state <= 0;
		end
		else begin
			start_r[0] <= i_start;
			start_r[1] <= start_r[0];
			start_r[2] <= start_r[1];
			start <= start_r[1] & (!start_r[2]);
			psen_r <= psen;
			psincdec_r <= psincdec;		
			o_state <= state;
		end		

// State machine				
always @(posedge sys_clk)
		if (!sys_rst) 
			ct_state <= ST_INIT;
		else 
			ct_state <= nt_state;

// State transition
always @(ct_state or start or PS_DATA or ps_done or ps_data_cnt)
	case (ct_state)
	ST_INIT: begin											
			if (start == 1'b1)							// start
				nt_state <= ST_0;
			else 
				nt_state <= ct_state;			
		end		
	ST_0: begin											// psen high, psinc/dec
			if (ps_done != 1'b1)						// wait until ps_done gets high 						
				nt_state <= ct_state;	
			else			
				nt_state <= ST_1;						
		end
		
	ST_1: begin											
			if (ps_data_cnt != PS_DATA) 						
				nt_state <= ST_0;					
			else
				nt_state <= ST_INIT;					// Clear ps_data_cnt value
		end
	default: nt_state <= ST_INIT;
	endcase
	
assign PS_DATA = i_ps_data - 1;
assign ps_data_cnt_ld = (ct_state == ST_1) ? 1'b1 : 1'b0;
assign ps_data_cnt_sel = ((ct_state == ST_1) && (nt_state == ST_0)) ? 1'b1 : 1'b0;

assign state = ((ct_state == ST_0) || (ct_state == ST_1)) ? 1'b1 : 1'b0;
assign psen = (((ct_state == ST_INIT) && (nt_state == ST_0)) || ((ct_state == ST_1) && (nt_state == ST_0)))? 1'b1 : 1'b0;
assign psincdec = (((ct_state == ST_INIT) && (nt_state == ST_0)) || ((ct_state == ST_1) && (nt_state == ST_0))) ? i_incdec : 1'b0;

endmodule
