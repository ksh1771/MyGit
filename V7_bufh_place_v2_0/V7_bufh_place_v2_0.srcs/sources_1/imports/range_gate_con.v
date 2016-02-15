/*
Range Gate Controller*/
`timescale 1 ns / 1 ps

module range_gate_con (
input			sys_clk,					// clk
input			sys_rst,				    // timing reset Active Low, synchronous with sys_clk
		
input			i_tdc_en,					// tdc_en
input           bypass_on,                  // 1: i_tdc_en bypass, 0: internal tdc enable signal generated through the range_gate_con
input [31:0]	i_rg_dur,				    // range gate duration 
input		    i_enet_cap_en,

output			o_sts_reg,
output 			o_rg_async			 	   // range gate output
);



reg							ct_state, nt_state;
reg							ct_state_a, nt_state_a;
parameter  					ST_0 = 1'b0, ST_1 = 1'b1;

reg								op_cycle_cnt_ld, op_cycle_cnt_sel, op_cycle_cnt_rst;
reg [2:0]						tdc_en_int, rg_async_latch;
reg [31:0]						op_cycle_cnt;
reg [1:0]						enet_cap_en_int;
reg							enet_cap_en;
reg							doneflag;
reg							sts_reg;

wire							rg;
wire							rg_async_clr;
wire	[31:0]					rg_dur_int;
wire							rg_con_start;
wire							doneflag_int;
wire [31:0]					op_cycle_cnt_int;
reg							o_rg;
wire						tdc_en_start_pulse;
wire						tdc_en_stop_pulse;
wire						fsm_start, fsm_start_bar;
wire						o_rg_async_bar;
wire						enet_cap_en_valid, enet_cap_en_valid_bar;
wire						o_rg_async_latch;
reg							o_rg_async_r;
	
assign o_sts_reg = sts_reg;

// clock domain crossing
always @(posedge sys_clk or negedge sys_rst)												// Asynchronous reset
		if (!sys_rst) begin
			tdc_en_int <= 0;
			enet_cap_en_int <= 0;
			enet_cap_en <= 0;
			doneflag <= 0;
			rg_async_latch <= 0;
		end
		else begin
			rg_async_latch[0] <= o_rg_async_latch;
			rg_async_latch[1] <= rg_async_latch[0];
			rg_async_latch[2] <= rg_async_latch[1];
			tdc_en_int[0] <= i_tdc_en;
//			tdc_en_int[1] <= (i_tdc_en & (!tdc_en_int[0]));
			tdc_en_int[1] <= tdc_en_int[0];
			tdc_en_int[2] <= tdc_en_int[1];
			enet_cap_en_int[0] <= i_enet_cap_en;
			enet_cap_en_int[1] <= enet_cap_en_int[0];
			enet_cap_en <= (enet_cap_en_int[0] & (!enet_cap_en_int[1]));
			doneflag <= doneflag_int;
		end

always @(posedge sys_clk or negedge sys_rst or posedge enet_cap_en)												// Asynchronous reset
		if ((!sys_rst)  || (enet_cap_en == 1'b1))
			sts_reg <= 1'b0;
		else if (doneflag == 1'b1)
			sts_reg <= 1'b1;
		
assign rg_con_start = (i_rg_dur == 32'h00)? 1'b0 : 1'b1;
assign doneflag_int = ((ct_state == ST_1) && (op_cycle_cnt == rg_dur_int)) ? 1'b1 : 1'b0;

assign rg_dur_int = i_rg_dur - 4;
			
// operation cycle count register
always @(posedge sys_clk or negedge sys_rst)												// Asynchronous reset
		if (!sys_rst)
			op_cycle_cnt <= 0;
		else 
			if(op_cycle_cnt_ld == 1'b1)
				op_cycle_cnt <= op_cycle_cnt_int ;	
				
assign op_cycle_cnt_int = op_cycle_cnt_sel ? op_cycle_cnt + 1 : 0;	// op_cycle_cnt_sel (0: reset, 1: increase by 1)


// output register
always @(posedge sys_clk or negedge sys_rst)												// Asynchronous reset
		if (!sys_rst) begin 
			o_rg <= 0;
		end
		else begin
			o_rg <= rg;
		end

assign rg = ((ct_state == ST_1) || (nt_state == ST_1)) ? 1'b1 : 1'b0;

/*
ila_0 ila_0_inst (
            .clk(sys_clk),        				    // input wire clk
			.probe0(enet_cap_en_valid),  		    // input wire [0 : 0] probe0                        
            .probe1(ct_state),                      // input wire [0 : 0] probe1 
            .probe2(nt_state),                      // input wire [0 : 0] probe2                        
			.probe3(tdc_en_start_pulse),  			// input wire [0 : 0] probe3                        
			.probe4(tdc_en_stop_pulse),  	        // input wire [0 : 0] probe4                       
			.probe5(o_rg_async_latch),		  		// input wire [0 : 0] probe5
			.probe6(op_cycle_cnt),                  // input wire [31 : 0] probe6 
			.probe7(i_rg_dur),                      // input wire [31 : 0] probe7 
			.probe8(enet_cap_en),                   // input wire [0 : 0] probe8
			.probe9(i_enet_cap_en),                 // input wire [0 : 0] probe9	
			.probe10(sys_rst)                       // input wire [0 : 0] probe10								 
);
*/

assign fsm_start = rg_async_latch[1] & !rg_async_latch[2];


nor (enet_cap_en_valid, enet_cap_en_valid_bar , (tdc_en_stop_pulse | !sys_rst));
nor (enet_cap_en_valid_bar, enet_cap_en, enet_cap_en_valid);


assign tdc_en_start_pulse = enet_cap_en_valid & i_tdc_en & !tdc_en_int[0];
assign tdc_en_stop_pulse = ((ct_state == ST_1) && (nt_state == ST_0)) ? 1'b1 : 1'b0;

//assign o_rg_async = o_rg_async_latch;
assign o_rg_async = (bypass_on == 1'b1) ? i_tdc_en : o_rg_async_latch;
nor (o_rg_async_latch,o_rg_async_bar , (tdc_en_stop_pulse | !sys_rst));
//nor (o_rg_async_latch,o_rg_async_bar , (doneflag| !sys_rst));
nor (o_rg_async_bar, tdc_en_start_pulse, o_rg_async_latch);
////////////////////////////////////////////////////////////////////////////////////////////////////
// TDC EN using by latch - bottom
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
// TDC EN using async reset - top
////////////////////////////////////////////////////////////////////////////////////////////////////

//assign rg_async_clr = (i_tdc_en & !sts_reg);

//always @(posedge sys_clk or posedge i_tdc_en or negedge sts_reg or negedge sys_rst)
/*
always @(posedge sys_clk or posedge rg_async_clr or negedge sys_rst)

		if (!sys_rst) begin 
			o_rg_async_r <= 0;
		end
//		else if (i_tdc_en & !sts_reg) begin 
		else if (rg_async_clr) begin 
			o_rg_async_r <= 1;
		end
		else begin
			o_rg_async_r <= rg;
		end

assign o_rg_async = o_rg_async_r;
*/
////////////////////////////////////////////////////////////////////////////////////////////////////
// TDC EN using async reset - bottom 
////////////////////////////////////////////////////////////////////////////////////////////////////


// State machine				
always @(posedge sys_clk or negedge sys_rst)												// Asynchronous reset
		if (!sys_rst) 
			ct_state <= ST_0;
		else 
			ct_state <= nt_state;

// State transition
//always @(ct_state or tdc_en_int[1] or op_cycle_cnt or i_rg_dur or rg_con_start or sts_reg)
always @(ct_state or fsm_start or op_cycle_cnt or i_rg_dur or rg_con_start)
	case (ct_state)
	ST_0: begin											
//			if ((tdc_en_int[1] == 1'b1) && (rg_con_start == 1'b1) && (sts_reg == 1'b0))					// when tdc_en comes,
			if ((fsm_start == 1'b1) && (rg_con_start == 1'b1))					// when tdc_en comes,
				nt_state <= ST_1;
			else 
				nt_state <= ct_state;			
		end		
	ST_1: begin											// making adjustable range gate duration
			if (op_cycle_cnt < i_rg_dur) 							
				nt_state <= ct_state;	
			else
				nt_state <= ST_0;						// Clear op_cycle_cnt value
		end
	default: nt_state <= ST_0;
	endcase

	
// State output
always @(ct_state or op_cycle_cnt or i_rg_dur)
	case (ct_state)
	ST_0: begin
			op_cycle_cnt_ld <= 1'b1;
			op_cycle_cnt_sel <= 1'b0;			// clear op_cycle_cnt
		end
	ST_1: begin
			if (op_cycle_cnt < i_rg_dur) begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b1;	
			end
			else begin
				op_cycle_cnt_ld <= 1'b1;
				op_cycle_cnt_sel <= 1'b0;		// clear op_cycle_cnt
			end	
			
		end
	default: begin
			op_cycle_cnt_ld <= 0;
			op_cycle_cnt_sel <= 1'bx;			// don't care
			end
	endcase

endmodule
