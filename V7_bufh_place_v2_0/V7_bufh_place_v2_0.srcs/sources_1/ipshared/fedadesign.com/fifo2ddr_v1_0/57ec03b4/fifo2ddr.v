//----------------------------------------------------------------------------
// fifo2ddr - module
//----------------------------------------------------------------------------
// IMPORTANT:
// DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
//
// SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
//
// TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
// PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
// OF THE USER_LOGIC ENTITY.
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** Xilinx, Inc.                                                          **
// ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
// ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
// ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
// ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
// ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
// ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
// ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
// ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
// ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
// ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
// ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
// ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
// ** FOR A PARTICULAR PURPOSE.                                             **
// **                                                                       **
// ***************************************************************************
//
//----------------------------------------------------------------------------
// Filename:          fifo2ddr
// Version:           1.00.a
// Description:       Example Axi Streaming core (Verilog).
// Date:              Tue Jun 10 18:33:37 2014 (by Create and Import Peripheral Wizard)
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
//
//
// Definition of Ports
// M_AXIS_TVALID  :  Data out is valid
// M_AXIS_TDATA   : Data Out
// M_AXIS_TLAST   : Optional data out qualifier
// M_AXIS_TREADY  : Connected slave device is ready to accept data out
//
////////////////////////////////////////////////////////////////////////////////

//----------------------------------------
// Module Section
//----------------------------------------
module fifo2ddr 
	(
		// ADD USER PORTS BELOW THIS LINE 
		// -- USER ports added here 
		// ADD USER PORTS ABOVE THIS LINE 
		sys_clk,
		resetn,
    	rd_en, 
    	dout,  
    	empty, 	
		start,
		num_of_write,
		M_AXIS_TVALID_TEST,
		M_AXIS_TDATA_TEST,
		M_AXIS_TREADY_TEST,
		M_AXIS_TLAST_TEST,
		STATE_TEST,
		nr_of_writes_TEST,
		// DO NOT EDIT BELOW THIS LINE ////////////////////
		// Bus protocol ports, do not add or delete. 
//		S_AXIS_TREADY,
//		S_AXIS_TDATA,
//		S_AXIS_TLAST,
//		S_AXIS_TVALID,
		M_AXIS_TVALID,
		M_AXIS_TDATA,
		M_AXIS_TLAST,
		M_AXIS_TREADY
		// DO NOT EDIT ABOVE THIS LINE ////////////////////
	);

// ADD USER PORTS BELOW THIS LINE 
// -- USER ports added here 
input			sys_clk;
input			resetn;
output			rd_en;
input [63:0]	dout;
input			empty;
input			start;
input [31:0]	num_of_write;
output                                    M_AXIS_TVALID_TEST;
output     [31 : 0]                       M_AXIS_TDATA_TEST;
output                                    M_AXIS_TREADY_TEST;
output                                    M_AXIS_TLAST_TEST;
output [3:0]                              STATE_TEST;
output [31:0]							  nr_of_writes_TEST;
// ADD USER PORTS ABOVE THIS LINE 


//output                                    S_AXIS_TREADY;
//input      [31 : 0]                       S_AXIS_TDATA;
//input                                     S_AXIS_TLAST;
//input                                     S_AXIS_TVALID;
output                                    M_AXIS_TVALID;
output     [31 : 0]                       M_AXIS_TDATA;
output                                    M_AXIS_TLAST;
input                                     M_AXIS_TREADY;

// ADD USER PARAMETERS BELOW THIS LINE 
// --USER parameters added here 
// ADD USER PARAMETERS ABOVE THIS LINE


//----------------------------------------

   // Total number of input data.
   localparam NUMBER_OF_INPUT_WORDS  = 2;

   // Total number of output data
   localparam NUMBER_OF_OUTPUT_WORDS = 32;

   // Define the states of state machine
   localparam Idle      = 4'b1000;
   localparam Read_Only = 4'b0100;
   localparam Read_Write = 4'b0010;
   localparam Write_Only = 4'b0001;

   reg [3:0] state;

   // Counters to store the number inputs read & outputs written
   reg [NUMBER_OF_OUTPUT_WORDS - 1:0] nr_of_writes;

   reg rd_en_r;
   reg wr_en_r;

   wire start_triger;
	reg start_d1;
	reg start_d2;

	reg tlast;

   assign rd_en = rd_en_r;

   assign nr_of_writes_TEST = nr_of_writes;
   assign M_AXIS_TVALID_TEST = wr_en_r;
   assign M_AXIS_TDATA_TEST = (state == Write_Only) ? dout[63:32] : dout[31:0] ;
   assign M_AXIS_TREADY_TEST = M_AXIS_TREADY;
	assign M_AXIS_TLAST_TEST = tlast;
   assign STATE_TEST = state;

   assign M_AXIS_TVALID = wr_en_r;
   assign M_AXIS_TDATA = (state == Write_Only) ? dout[63:32] : dout[31:0] ;
   assign M_AXIS_TLAST = tlast;

   always @(posedge sys_clk) 
   begin 
      if (!resetn) begin
		  start_d1 <= 1'b0;
		  start_d2 <= 1'b0;
	  end
	  else begin
		  start_d1 <= start;
		  start_d2 <= start_d1;
	  end
   end
   assign start_triger = start_d1&~start_d2 ? 1 : 0;
   
   always @(posedge sys_clk) begin  
      if (!resetn) begin
           state        <= Idle;
           nr_of_writes <= 0;
      end
      else begin
        case (state)
          Idle: 
            if (start_triger == 1) begin
              state <= Read_Only;
			  nr_of_writes <= num_of_write;
            end
			else begin
			end
          Read_Only: 
            if (empty == 0) begin
              if (nr_of_writes == 0) begin
                 state <= Idle;
			  end
              else begin
                 nr_of_writes <= nr_of_writes - 1;
				 state <= Write_Only;
			  end
            end
			else begin
			   state <= state;
			end
		  Write_Only:
            if (M_AXIS_TREADY == 1) begin
			   state <= Read_Write;
			end
			else begin
			   state <= Write_Only;
			end

          Read_Write: 
            if (M_AXIS_TREADY == 1 && empty == 0) begin
              if (nr_of_writes == 0) begin
                 state <= Idle;
			  end
              else begin
                 nr_of_writes <= nr_of_writes - 1;
				 state <= Write_Only;
			  end
            end
            else if (M_AXIS_TREADY == 1 && empty == 1) begin
              if (nr_of_writes == 0) begin
                 state <= Idle;
			  end
              else begin
                 state <= Read_Only;
			  end
            end
            else if (M_AXIS_TREADY == 0) begin
              state <= Read_Write;
            end
        endcase
	 end
  end

   always @(*) begin  
        case (state)
          Idle: 
            if (start_triger == 1) begin
		      rd_en_r <= 0;
		   	  wr_en_r <= 0;
			  tlast <= 0;
            end
			else begin
		      rd_en_r <= 0;
		   	  wr_en_r <= 0;
			  tlast <= 0;
			end
          Read_Only: 
            if (empty == 0) begin
		      rd_en_r <= 1;
		   	  wr_en_r <= 0;
			  tlast <= 0;
            end
			else begin
			   rd_en_r <= 0;
		   	   wr_en_r <= 0;
			  tlast <= 0;
			end
		  Write_Only:
            if (M_AXIS_TREADY == 1) begin
			   rd_en_r <= 0;
		   	   wr_en_r <= 1;
			  tlast <= 0;
			end
			else begin
			   rd_en_r <= 0;
		   	   wr_en_r <= 0;
			  tlast <= 0;
		    end
          Read_Write: 
            if (M_AXIS_TREADY == 1 && empty == 0) begin
              if (nr_of_writes == 0) begin
		         rd_en_r <= 0;
		   	     wr_en_r <= 1;
				 tlast <= 1;
			  end
              else begin
		         rd_en_r <= 1;
		   	     wr_en_r <= 1;
			     tlast <= 0;
			  end
            end
            else if (M_AXIS_TREADY == 1 && empty == 1) begin
              if (nr_of_writes == 0) begin
		         rd_en_r <= 0;
		   	     wr_en_r <= 1;
				 tlast <= 1;
			  end
              else begin
		         rd_en_r <= 0;
		   	     wr_en_r <= 1;
			     tlast <= 0;
		  	  end
            end
            else if (M_AXIS_TREADY == 0) begin
		      rd_en_r <= 0;
		   	  wr_en_r <= 0;
			  tlast <= 0;
            end
// Sang modification to avoid latch inferring				
				else begin
				rd_en_r <= 0;
		   	  wr_en_r <= 0;
			  tlast <= 0;				
				end
			default: begin
				rd_en_r <= 0;
		   	  wr_en_r <= 0;
			  tlast <= 0;				
				end 
// Sang modification to avoid latch inferring								
        endcase
  end

endmodule
