/*
Device Serial Interface module
*/
module DSI (
input 							sys_clk,
input 							sys_rst,


input							i_dsi_start,

input [15:0]					i_dsi_data,

output [2:0]					o_ct_state,
output [2:0]					o_nt_state,
output 							o_dsi_sclk,
output							o_dsi_sync,
output 							o_dsi_sdata
);

parameter		PH0 = 1;
parameter		PH1 = 1;
parameter		PH2 = 1;
parameter		PH3 = 1;
parameter		PH4 = 1;

parameter [2:0] 				INIT = 3'd0, S0 = 3'd1, S1 = 3'd2, S2 = 3'd3, S3 = 3'd4, S4 = 3'd5;
parameter						DSI_DATA_BIT_MN_1 = 15;

reg	[2:0]						ct_state, nt_state;
reg								op_cycle_cnt_ld;
reg								op_cycle_cnt_sel;
reg [7:0]						op_cycle_cnt;
reg 							dsi_sclk, dsi_sclk_int;
reg								dsi_ld, dsi_ld_int;
reg								dsi_start_clr;
reg								data_cnt_ld;
reg								data_cnt_sel;
reg [7:0]						data_cnt;
reg [15:0]						shft_reg;
reg								shft_sel;
reg								shft_ld;

wire							dsi_start_clr_int;
wire [15:0]						shft_int;
wire [7:0]						op_cycle_cnt_int;
wire [7:0]						data_cnt_int;
reg                             dsi_start;
reg [1:0]                       dsi_start_r;

assign o_ct_state = ct_state;
assign o_nt_state = nt_state;
assign o_dsi_sclk = dsi_sclk;
assign o_dsi_sync = dsi_ld;
//assign o_dsi_sdata = shft_reg[0];
assign o_dsi_sdata = shft_reg[15];
assign o_dsi_start_clr = dsi_start_clr;

always @(posedge sys_clk)		// synchronous reset
		if (!sys_rst) begin 
			dsi_start <= 0;
			dsi_start_r <= 0;
		end
		else begin
			dsi_start_r[0] <= i_dsi_start;
			dsi_start_r[1] <= dsi_start_r[0];
			dsi_start <= dsi_start_r[0] & (~dsi_start_r[1]);
		end 

// op cycle cnt register
always @(posedge sys_clk)		// synchronous reset
		if (!sys_rst) 
			op_cycle_cnt <= 0;
		else 
			if(op_cycle_cnt_ld == 1'b1) 
				op_cycle_cnt <= op_cycle_cnt_int;	

assign op_cycle_cnt_int = op_cycle_cnt_sel ? op_cycle_cnt + 1 : 0;

// data shift register
always @(posedge sys_clk)		// synchronous reset
		if (!sys_rst) 
			shft_reg <= 0;
		else 
			if(shft_ld == 1'b1) 
				shft_reg <= shft_int;	

assign shft_int = shft_sel ? {shft_reg[14:0], 1'b0} : i_dsi_data;

// data cnt register
always @(posedge sys_clk)		// synchronous reset
		if (!sys_rst) 
			data_cnt <= 0;
		else 
			if(data_cnt_ld == 1'b1) 
				data_cnt <= data_cnt_int;	

assign data_cnt_int = data_cnt_sel ? data_cnt + 1 : 0;


assign dsi_start_clr_int = ((ct_state == S0) && (op_cycle_cnt == 0)) ? 1'b1 : 1'b0;
// output register
always @(posedge sys_clk)		// synchronous reset
		if (!sys_rst) begin 
			dsi_sclk <= 1'b0;
			dsi_ld <= 1'b0;
			dsi_start_clr <= 1'b0;
		end
		else begin
			dsi_sclk <= dsi_sclk_int;
			dsi_ld <= dsi_ld_int;
			dsi_start_clr <= dsi_start_clr_int;
		end			
	
// State machine				
always @(posedge sys_clk)
		if (!sys_rst) 
			ct_state <= INIT;
		else 
			ct_state <= nt_state;

		
// State transition
always @(ct_state or dsi_start or op_cycle_cnt or data_cnt)
	case (ct_state)
	INIT: begin
			if (dsi_start == 1) 
				nt_state <= S0;						// Data Load
			else 
				nt_state <= ct_state;
		end
	S0: begin
			if (op_cycle_cnt != PH0) 				// SCLK High, Data
				nt_state <= ct_state;
			else
				nt_state <= S1;						// op_cycle_cnt clear
		end
	S1: begin										// SCLK Low, Data
			if (op_cycle_cnt != PH1)
				nt_state <= ct_state;
			else begin								// op_cycle_cnt clear
				if(data_cnt != DSI_DATA_BIT_MN_1)
					nt_state <= S0;					// shift data	
				else
					nt_state <= S2;					// data_cnt clear
				end
		end
	S2: begin										// SCLK Low, Data
			if (op_cycle_cnt != PH2)
				nt_state <= ct_state;
			else
				nt_state <= S3;						// op_cycle_cnt clear
		end
	S3: begin										// SCLK Low, Data
			if (op_cycle_cnt != PH3)
				nt_state <= ct_state;
			else
				nt_state <= S4;						// op_cycle_cnt clear
		end
	S4: begin										// SCLK Low, Data
			if (op_cycle_cnt != PH4)
				nt_state <= ct_state;
			else
				nt_state <= INIT;					// op_cycle_cnt clear	
		end
	default: nt_state <= INIT;
	endcase

	
// State output
always @(ct_state or op_cycle_cnt or data_cnt or dsi_start)
	case (ct_state)
	INIT: begin
			if (dsi_start == 1) begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b0;		// clear op_cycle_cnt
				shft_ld <= 1'b1;				// load data into shift register
				shft_sel <= 1'b0;
				data_cnt_ld <= 1'b1;
				data_cnt_sel <= 1'b0;			// data_cnt clear
				end				
			else begin
				op_cycle_cnt_ld <= 1'b0;
				op_cycle_cnt_sel <= 1'bx;		// don't care
				shft_ld <= 1'b0;
				shft_sel <= 1'bx;				// don't care
				data_cnt_ld <= 1'b0;
				data_cnt_sel <= 1'bx;
				end
			dsi_ld_int <= 1'b1;
			dsi_sclk_int <= 1'b0;
		end
	S0: begin
			if (op_cycle_cnt != PH0)  begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b1;		// op cycle cnt update
				end
			else begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b0;		// op cycle cnt clear
				end
// for falling edge-triggered								
//			dsi_sclk_int <= 1'b0;
// for rising edge-triggered				
			dsi_sclk_int <= 1'b1;
			dsi_ld_int <= 1'b0;
			data_cnt_ld <= 1'b0;
			data_cnt_sel <= 1'bx;			
			shft_ld <= 1'b0;
			shft_sel <= 1'bx;				// load data value
		end
	S1: begin
			if (op_cycle_cnt != PH1)  begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b1;		// op cycle cnt update
				data_cnt_ld <= 1'b0;
				data_cnt_sel <= 1'bx;			// data_cnt update
				shft_ld <= 1'b0;
				shft_sel <= 1'bx;				// shift data				
				end
			else begin
				if(data_cnt != DSI_DATA_BIT_MN_1) begin
					shft_ld <= 1'b1;
					shft_sel <= 1'b1;				// shift data
					data_cnt_ld <= 1'b1;
					data_cnt_sel <= 1'b1;			// data_cnt update
				end
				else begin
					shft_ld <= 1'b1;
					shft_sel <= 1'b1;				// don't care
					data_cnt_ld <= 1'b1;
					data_cnt_sel <= 1'b0;			// data_cnt clear
				end
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b0;		// op cycle cnt clear
				end
// for falling edge-triggered				
//			dsi_sclk_int <= 1'b1;
// for rising edge-triggered
			dsi_sclk_int <= 1'b0;
			dsi_ld_int <= 1'b0;
		end
	S2: begin
			if (op_cycle_cnt != PH2)  begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b1;		// op cycle cnt update
				end
			else begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b0;		// op cycle cnt clear
				end			
			dsi_sclk_int <= 1'b0;
			dsi_ld_int <= 1'b0;
			data_cnt_ld <= 1'b0;
			data_cnt_sel <= 1'bx;			
			shft_ld <= 1'b0;
			shft_sel <= 1'bx;				// don't care
		end		
	S3: begin
			if (op_cycle_cnt != PH3)  begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b1;		// op cycle cnt update
				end
			else begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b0;		// op cycle cnt clear
				end			
			dsi_sclk_int <= 1'b0;				
			dsi_ld_int <= 1'b1;
			data_cnt_ld <= 1'b0;
			data_cnt_sel <= 1'bx;						
			shft_ld <= 1'b0;
			shft_sel <= 1'bx;				// don't care
		end
	S4: begin
			if (op_cycle_cnt != PH4)  begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b1;		// op cycle cnt update
				end
			else begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b0;		// op cycle cnt clear
				end
			dsi_sclk_int <= 1'b0;
			dsi_ld_int <= 1'b1;
			data_cnt_ld <= 1'b0;
			data_cnt_sel <= 1'bx;						
			shft_ld <= 1'b0;
			shft_sel <= 1'bx;				// don't care
		end
	default: begin
			op_cycle_cnt_ld <= 1'b0;
			op_cycle_cnt_sel <= 1'bx;		// don't care
			dsi_sclk_int <= 1'b0;
			dsi_ld_int <= 1'b1;
			data_cnt_ld <= 1'b0;
			data_cnt_sel <= 1'bX;			
			shft_ld <= 1'b0;
			shft_sel <= 1'bX;		
			end
	endcase

endmodule