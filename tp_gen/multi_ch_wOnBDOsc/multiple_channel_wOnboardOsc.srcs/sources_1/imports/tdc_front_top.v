`timescale 1ps/1ps

module tdc_front_top
  (

   input                                clk_in_p,       // 200MHz differential clock input from the board (p)
   input                                clk_in_n,       // 200MHz differential clock input from the board (n)

//   input                                clk_in,       //user clock input through SMA

   input                                sys_rst,
   
   input  [1:0]                         dip_input,
   output                               tdc_en_out,
   output                               dummy_out,
   output [3:0]                         led,
   output [74:0]                   	    tp_out
   
   );

parameter state0  = 2'd0;
parameter state1  = 2'd1;
parameter state2  = 2'd2;

reg [1:0] 	state = 2'b00;
reg [24:0]	state_cnt = 24'b0;
reg [74:0]	tp_out_r2 = 75'h0000000000000000000;

reg [3:0]   temp_clk = 4'b0000;
reg         led_blink;
reg         tdc_en_r;
reg         state_en0, state_en1, state_en2, state_en3;
wire        tdc_en;

wire	   state_en_w;    // only used internally.
wire       sys_rst_n;
wire       sys_clk;
wire       ila_clk;
wire       t_clk;
wire       clk_a, clk_b, clk_c, clk_d, clk_w0, clk_w1, ila_clk; 
wire [1:0]  clk_sel;

assign sys_rst_n = !sys_rst;
assign led = 4'b1010;
assign dummy_out = 1'b1;
assign clk_sel = dip_input;

// when using on-board differential clock source
clk_wiz_0 clk_wiz_inst (
			.clk_in1_p(clk_in_p),      	// input clk_in1
			.clk_in1_n(clk_in_n),      	// input clk_in1
            .clk_out1(clk_a),         	// output clk_out1 (5MHz)
            .clk_out2(clk_b),         	// output clk_out2 (6MHz)
            .clk_out3(clk_c),         	// output clk_out3 (7MHz)
            .clk_out4(clk_d),        	// output clk_out4 (8MHz)
//            .clk_out5(ila_clk),         // clock for ila (100MHz)
            .reset(~sys_rst_n),		   	// input reset
            .locked()
);

BUFGMUX bufgmux_0 (
            .I0(clk_a),
            .I1(clk_b),
            .S(clk_sel[0]),
            .O(clk_w0)
);             

BUFGMUX bufgmux_1 (
            .I0(clk_c),
            .I1(clk_d),
            .S(clk_sel[0]),
            .O(clk_w1)
);             

BUFGMUX bufgmux_2 (
            .I0(clk_w0),
            .I1(clk_w1),
            .S(clk_sel[1]),
            .O(sys_clk)
);  


// when using user clock source through the SMA
//BUFG (
//    .O(sys_clk),
//    .I(clk_in)
//);

always @(posedge sys_clk)
		if (!sys_rst_n) begin 
			state <= state0;
			state_cnt <= 0;
		end
		else begin
        case (state)
            state0 : begin
               state <= state1;
               state_cnt <= state_cnt;
            end
            state1 : begin
               state <= state2;
			   state_cnt <= state_cnt;
            end
            state2 : begin
			   if (state_cnt != 24'd59999) begin         // 2 * 60000 * period (83.33ns when 12MHz -> around 9.96ms)
                    state <= state1;			   
					state_cnt <= state_cnt + 1;
			   end
			   else	begin
                    state <= state0;			   			  
					state_cnt <= 0;
			   end
            end
        endcase  
		end
assign tdc_en = ((state == state1) || (state == state2)) ? 1'b1 : 1'b0; 

//assign state_en_w = ((state == state2) && (state_cnt[2:0] == 3'b000)) ? 1'b1 : 1'b0;    
// test pulse is generated at every 1/8th clock 
// for example, if 5MHz sys_clk is selected for the clock,
// test pulse frequency is around 0.625MHz

assign state_en_w = ((state == state2) && (state_cnt[3:0] == 4'b0000)) ? 1'b1 : 1'b0;    
// test pulse is generated at every 1/16th clock 
// for example, if 7MHz is selected for the clock,
// test pulse frequency is around 0.4375MHz

assign tdc_en_out = tdc_en_r;

always @(posedge sys_clk)
		if (!sys_rst_n) begin 
			tdc_en_r <= 0;
			state_en0 <= 0;
			state_en1 <= 0;
			state_en2 <= 0;
            state_en3 <= 0;
		end
		else begin 
            tdc_en_r <= tdc_en;
			state_en0 <= state_en_w;
            state_en1 <= state_en0;
            state_en2 <= state_en1;
            state_en3 <= state_en2;
        end 		 
 
always @(posedge sys_clk)
		if (!sys_rst_n) begin 
			tp_out_r2 <= 0;
		end
		else begin
				tp_out_r2[0] <= state_en0;   
				tp_out_r2[1] <= state_en1;   
				tp_out_r2[2] <= state_en0;   
				tp_out_r2[3] <= state_en1;   
				tp_out_r2[4] <= state_en0;   
                tp_out_r2[5] <= state_en1;   
                tp_out_r2[6] <= state_en0;   
                tp_out_r2[7] <= state_en1;   
				tp_out_r2[8] <= state_en0;   
                tp_out_r2[9] <= state_en1;   
                tp_out_r2[10] <= state_en0;   
                tp_out_r2[11] <= state_en1;   
				tp_out_r2[12] <= state_en0;   
                tp_out_r2[13] <= state_en1;   
                tp_out_r2[14] <= state_en0;   
                tp_out_r2[15] <= state_en1;   
				tp_out_r2[16] <= state_en0;   
                tp_out_r2[17] <= state_en1;   
                tp_out_r2[18] <= state_en0;   
                tp_out_r2[19] <= state_en1;   
				tp_out_r2[20] <= state_en0;   
                tp_out_r2[21] <= state_en1;   
                tp_out_r2[22] <= state_en0;   
                tp_out_r2[23] <= state_en1;   
				tp_out_r2[24] <= state_en0;   
                tp_out_r2[25] <= state_en1;   
                tp_out_r2[26] <= state_en0;   
                tp_out_r2[27] <= state_en1;   
				tp_out_r2[28] <= state_en0;   
                tp_out_r2[29] <= state_en1;   
                tp_out_r2[30] <= state_en0;   
                tp_out_r2[31] <= state_en1;   
				tp_out_r2[32] <= state_en0;   
                tp_out_r2[33] <= state_en1;   
                tp_out_r2[34] <= state_en0;   
                tp_out_r2[35] <= state_en1;   
				tp_out_r2[36] <= state_en0;   
                tp_out_r2[37] <= state_en1;   
                tp_out_r2[38] <= state_en0;   
                tp_out_r2[39] <= state_en1;   
				tp_out_r2[40] <= state_en0;   
                tp_out_r2[41] <= state_en1;   
                tp_out_r2[42] <= state_en0;   
                tp_out_r2[43] <= state_en1;   
				tp_out_r2[44] <= state_en0;   
                tp_out_r2[45] <= state_en1;   
                tp_out_r2[46] <= state_en0;   
                tp_out_r2[47] <= state_en1;   
				tp_out_r2[48] <= state_en0;   
                tp_out_r2[49] <= state_en1;   
                tp_out_r2[50] <= state_en0;   
                tp_out_r2[51] <= state_en1;   
				tp_out_r2[52] <= state_en0;   
                tp_out_r2[53] <= state_en1;   
                tp_out_r2[54] <= state_en0;   
                tp_out_r2[55] <= state_en1;   
				tp_out_r2[56] <= state_en0;   
                tp_out_r2[57] <= state_en1;   
                tp_out_r2[58] <= state_en0;   
                tp_out_r2[59] <= state_en1;   
				tp_out_r2[60] <= state_en0;   
                tp_out_r2[61] <= state_en1;   
                tp_out_r2[62] <= state_en0;   
                tp_out_r2[63] <= state_en1;   
				tp_out_r2[64] <= state_en0;   
                tp_out_r2[65] <= state_en1;   
                tp_out_r2[66] <= state_en0;   
                tp_out_r2[67] <= state_en1;   
				tp_out_r2[68] <= state_en0;   
                tp_out_r2[69] <= state_en1;   
                tp_out_r2[70] <= state_en0;   
                tp_out_r2[71] <= state_en1;   
				tp_out_r2[72] <= state_en0;   
                tp_out_r2[73] <= state_en1;   
                tp_out_r2[74] <= state_en0;   
		end
		
assign tp_out[74:0] = tp_out_r2[74:0];
		
ila_0 ila_0_inst (
            .clk(sys_clk),        			// input wire clk
            .probe0(state_en_w),  			// input wire [0 : 0] probe1			
            .probe1(tp_out_r2),	            // input wire [74 : 0] probe2
            .probe2(tdc_en)                 // input wire [0 : 0] probe3
);


endmodule
