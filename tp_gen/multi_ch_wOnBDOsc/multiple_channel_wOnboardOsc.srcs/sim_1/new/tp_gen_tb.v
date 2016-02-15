`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2015 11:33:29 AM
// Design Name: 
// Module Name: tp_gen_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// no ports in tp_gen_tb.v it will only create clock, reset and instantiate the simulation.
module tp_gen_tb(
//    output clk_in_p,  
//    output clk_in_n,
//    output sys_rst,
//    input [74:0] tp_out
    );
    
reg clk_in_p;
reg clk_in_n;
reg sys_rst;
wire [74:0] tp_out;
    
tdc_front_top tdc_front_top_i(
    .clk_in_p(clk_in_p),  
    .clk_in_n(clk_in_n),
    .sys_rst(sys_rst),
    .tp_out(tp_out)
);

// generate 200MHz clock, 5ns period
always
    begin
        clk_in_p <= 1'b1;
        clk_in_n <= 1'b0;
        #2.5;
        clk_in_p <= 1'b0;
        clk_in_n <= 1'b1;
        #2.5;
    end
    
// generate external reset pulse, active low
initial
    begin
        sys_rst <= 1'b1;
        #200;  // 200ns for simulation, real world will be a few miliseconds
        sys_rst <= 1'b0;
    end
        
endmodule
