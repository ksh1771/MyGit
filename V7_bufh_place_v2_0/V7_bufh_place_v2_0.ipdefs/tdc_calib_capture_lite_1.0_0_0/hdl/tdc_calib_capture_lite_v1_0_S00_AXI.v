
`timescale 1 ns / 1 ps

	module tdc_calib_capture_lite_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 9
	)
	(
		// Users to add ports here
		// 12 clocks for front-end F/Fs
        input wire sys_clk0,
        input wire sys_clk1,
        input wire sys_clk2,
        input wire sys_clk3,
        input wire sys_clk4,
        input wire sys_clk5,
        input wire sys_clk6,
        input wire sys_clk7,
        input wire sys_clk8,
        input wire sys_clk9,
        input wire sys_clk10,
        input wire sys_clk11,
        // TDC inputs
        input wire [11:0]  tdc_in,
        
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 6;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 100
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg17;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg18;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg19;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg20;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg21;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg22;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg23;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg24;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg25;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg26;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg27;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg28;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg29;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg30;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg31;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg32;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg33;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg34;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg35;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg36;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg37;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg38;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg39;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg40;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg41;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg42;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg43;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg44;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg45;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg46;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg47;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg99;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	        end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID)
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 0;
	      slv_reg1 <= 0;
	      slv_reg2 <= 0;
	      slv_reg3 <= 0;
	      slv_reg4 <= 0;
	      slv_reg5 <= 0;
	      slv_reg6 <= 0;
	      slv_reg7 <= 0;
	      slv_reg8 <= 0;
	      slv_reg9 <= 0;
	      slv_reg10 <= 0;
	      slv_reg11 <= 0;
	      slv_reg12 <= 0;
	      slv_reg13 <= 0;
	      slv_reg14 <= 0;
	      slv_reg15 <= 0;
	      slv_reg16 <= 0;
	      slv_reg17 <= 0;
	      slv_reg18 <= 0;
	      slv_reg19 <= 0;
	      slv_reg20 <= 0;
	      slv_reg21 <= 0;
	      slv_reg22 <= 0;
	      slv_reg23 <= 0;
	      slv_reg24 <= 0;
	      slv_reg25 <= 0;
	      slv_reg26 <= 0;
	      slv_reg27 <= 0;
	      slv_reg28 <= 0;
	      slv_reg29 <= 0;
	      slv_reg30 <= 0;
	      slv_reg31 <= 0;
	      slv_reg32 <= 0;
	      slv_reg33 <= 0;
	      slv_reg34 <= 0;
	      slv_reg35 <= 0;
	      slv_reg36 <= 0;
	      slv_reg37 <= 0;
	      slv_reg38 <= 0;
	      slv_reg39 <= 0;
	      slv_reg40 <= 0;
	      slv_reg41 <= 0;
	      slv_reg42 <= 0;
	      slv_reg43 <= 0;
	      slv_reg44 <= 0;
	      slv_reg45 <= 0;
	      slv_reg46 <= 0;
	      slv_reg47 <= 0;
	      slv_reg99 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          7'h00:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h01:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h02:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h03:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h04:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 4
	                slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h05:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 5
	                slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h06:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 6
	                slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h07:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 7
	                slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h08:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 8
	                slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h09:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 9
	                slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 10
	                slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 11
	                slv_reg11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 12
	                slv_reg12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 13
	                slv_reg13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 14
	                slv_reg14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 15
	                slv_reg15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h10:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 16
	                slv_reg16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h11:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 17
	                slv_reg17[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h12:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 18
	                slv_reg18[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h13:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 19
	                slv_reg19[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h14:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 20
	                slv_reg20[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h15:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 21
	                slv_reg21[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h16:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 22
	                slv_reg22[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h17:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 23
	                slv_reg23[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h18:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 24
	                slv_reg24[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h19:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 25
	                slv_reg25[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 26
	                slv_reg26[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 27
	                slv_reg27[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 28
	                slv_reg28[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 29
	                slv_reg29[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 30
	                slv_reg30[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 31
	                slv_reg31[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h20:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 32
	                slv_reg32[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h21:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 33
	                slv_reg33[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h22:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 34
	                slv_reg34[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h23:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 35
	                slv_reg35[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h24:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 36
	                slv_reg36[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h25:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 37
	                slv_reg37[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h26:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 38
	                slv_reg38[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h27:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 39
	                slv_reg39[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h28:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 40
	                slv_reg40[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h29:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 41
	                slv_reg41[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 42
	                slv_reg42[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 43
	                slv_reg43[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 44
	                slv_reg44[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 45
	                slv_reg45[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 46
	                slv_reg46[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 47
	                slv_reg47[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h63:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 99
	                slv_reg99[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      slv_reg1 <= slv_reg1;
	                      slv_reg2 <= slv_reg2;
	                      slv_reg3 <= slv_reg3;
	                      slv_reg4 <= slv_reg4;
	                      slv_reg5 <= slv_reg5;
	                      slv_reg6 <= slv_reg6;
	                      slv_reg7 <= slv_reg7;
	                      slv_reg8 <= slv_reg8;
	                      slv_reg9 <= slv_reg9;
	                      slv_reg10 <= slv_reg10;
	                      slv_reg11 <= slv_reg11;
	                      slv_reg12 <= slv_reg12;
	                      slv_reg13 <= slv_reg13;
	                      slv_reg14 <= slv_reg14;
	                      slv_reg15 <= slv_reg15;
	                      slv_reg16 <= slv_reg16;
	                      slv_reg17 <= slv_reg17;
	                      slv_reg18 <= slv_reg18;
	                      slv_reg19 <= slv_reg19;
	                      slv_reg20 <= slv_reg20;
	                      slv_reg21 <= slv_reg21;
	                      slv_reg22 <= slv_reg22;
	                      slv_reg23 <= slv_reg23;
	                      slv_reg24 <= slv_reg24;
	                      slv_reg25 <= slv_reg25;
	                      slv_reg26 <= slv_reg26;
	                      slv_reg27 <= slv_reg27;
	                      slv_reg28 <= slv_reg28;
	                      slv_reg29 <= slv_reg29;
	                      slv_reg30 <= slv_reg30;
	                      slv_reg31 <= slv_reg31;
	                      slv_reg32 <= slv_reg32;
	                      slv_reg33 <= slv_reg33;
	                      slv_reg34 <= slv_reg34;
	                      slv_reg35 <= slv_reg35;
	                      slv_reg36 <= slv_reg36;
	                      slv_reg37 <= slv_reg37;
	                      slv_reg38 <= slv_reg38;
	                      slv_reg39 <= slv_reg39;
	                      slv_reg40 <= slv_reg40;
	                      slv_reg41 <= slv_reg41;
	                      slv_reg42 <= slv_reg42;
	                      slv_reg43 <= slv_reg43;
	                      slv_reg44 <= slv_reg44;
	                      slv_reg45 <= slv_reg45;
	                      slv_reg46 <= slv_reg46;
	                      slv_reg47 <= slv_reg47;
	                      slv_reg99 <= slv_reg99;
	                    end
	        endcase
	      end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        7'h00   : reg_data_out <= tdc_in0_d_r[127:96];
	        7'h01   : reg_data_out <= tdc_in0_d_r[95:64];
	        7'h02   : reg_data_out <= tdc_in0_d_r[63:32];
	        7'h03   : reg_data_out <= tdc_in0_d_r[31:0];
	        7'h04   : reg_data_out <= tdc_in1_d_r[127:96];
	        7'h05   : reg_data_out <= tdc_in1_d_r[95:64];
	        7'h06   : reg_data_out <= tdc_in1_d_r[63:32];
	        7'h07   : reg_data_out <= tdc_in1_d_r[31:0];
	        7'h08   : reg_data_out <= tdc_in2_d_r[127:96];
	        7'h09   : reg_data_out <= tdc_in2_d_r[95:64];
	        7'h0A   : reg_data_out <= tdc_in2_d_r[63:32];
	        7'h0B   : reg_data_out <= tdc_in2_d_r[31:0];
	        7'h0C   : reg_data_out <= tdc_in3_d_r[127:96];
	        7'h0D   : reg_data_out <= tdc_in3_d_r[95:64];
	        7'h0E   : reg_data_out <= tdc_in3_d_r[63:32];
	        7'h0F   : reg_data_out <= tdc_in3_d_r[31:0];
	        7'h10   : reg_data_out <= tdc_in4_d_r[127:96];
	        7'h11   : reg_data_out <= tdc_in4_d_r[95:64];
	        7'h12   : reg_data_out <= tdc_in4_d_r[63:32];
	        7'h13   : reg_data_out <= tdc_in4_d_r[31:0];
	        7'h14   : reg_data_out <= tdc_in5_d_r[127:96];
	        7'h15   : reg_data_out <= tdc_in5_d_r[95:64];
	        7'h16   : reg_data_out <= tdc_in5_d_r[63:32];
	        7'h17   : reg_data_out <= tdc_in5_d_r[31:0];
	        7'h18   : reg_data_out <= tdc_in6_d_r[127:96];
	        7'h19   : reg_data_out <= tdc_in6_d_r[95:64];
	        7'h1A   : reg_data_out <= tdc_in6_d_r[63:32];
	        7'h1B   : reg_data_out <= tdc_in6_d_r[31:0];
	        7'h1C   : reg_data_out <= tdc_in7_d_r[127:96];
	        7'h1D   : reg_data_out <= tdc_in7_d_r[95:64];
	        7'h1E   : reg_data_out <= tdc_in7_d_r[63:32];
	        7'h1F   : reg_data_out <= tdc_in7_d_r[31:0];
	        7'h20   : reg_data_out <= tdc_in8_d_r[127:96];
	        7'h21   : reg_data_out <= tdc_in8_d_r[95:64];
	        7'h22   : reg_data_out <= tdc_in8_d_r[63:32];
	        7'h23   : reg_data_out <= tdc_in8_d_r[31:0];
	        7'h24   : reg_data_out <= tdc_in9_d_r[127:96];
	        7'h25   : reg_data_out <= tdc_in9_d_r[95:64];
	        7'h26   : reg_data_out <= tdc_in9_d_r[63:32];
	        7'h27   : reg_data_out <= tdc_in9_d_r[31:0];
	        7'h28   : reg_data_out <= tdc_in10_d_r[127:96];
	        7'h29   : reg_data_out <= tdc_in10_d_r[95:64];
	        7'h2A   : reg_data_out <= tdc_in10_d_r[63:32];
	        7'h2B   : reg_data_out <= tdc_in10_d_r[31:0];
	        7'h2C   : reg_data_out <= tdc_in11_d_r[127:96];
	        7'h2D   : reg_data_out <= tdc_in11_d_r[95:64];
	        7'h2E   : reg_data_out <= tdc_in11_d_r[63:32];
	        7'h2F   : reg_data_out <= tdc_in11_d_r[31:0];
	        7'h63   : reg_data_out <= slv_reg99;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here
    assign pulse_on = slv_reg99[0];	
	
    reg [127:0] tdc_in0_d;
    reg [127:0] tdc_in1_d;
    reg [127:0] tdc_in2_d;
    reg [127:0] tdc_in3_d;
    reg [127:0] tdc_in4_d;
    reg [127:0] tdc_in5_d;
    reg [127:0] tdc_in6_d;
    reg [127:0] tdc_in7_d;
    reg [127:0] tdc_in8_d;
    reg [127:0] tdc_in9_d;
    reg [127:0] tdc_in10_d;
    reg [127:0] tdc_in11_d;
    
    reg [127:0] tdc_in0_d_r;
    reg [127:0] tdc_in1_d_r;
    reg [127:0] tdc_in2_d_r;
    reg [127:0] tdc_in3_d_r;
    reg [127:0] tdc_in4_d_r;
    reg [127:0] tdc_in5_d_r;
    reg [127:0] tdc_in6_d_r;
    reg [127:0] tdc_in7_d_r;
    reg [127:0] tdc_in8_d_r;
    reg [127:0] tdc_in9_d_r;
    reg [127:0] tdc_in10_d_r;
    reg [127:0] tdc_in11_d_r;
        
    reg rst_sync0;
    reg rst_sync1;
    reg rst_sync2;
    reg rst_sync3;
    reg rst_sync4;
    reg rst_sync5;
    reg rst_sync6;
    reg rst_sync7;
    reg rst_sync8;
    reg rst_sync9;
    reg rst_sync10;
    reg rst_sync11;
    
    reg rst_sync0_r;
    reg rst_sync1_r;
    reg rst_sync2_r;
    reg rst_sync3_r;
    reg rst_sync4_r;
    reg rst_sync5_r;
    reg rst_sync6_r;
    reg rst_sync7_r;
    reg rst_sync8_r;
    reg rst_sync9_r;
    reg rst_sync10_r;
    reg rst_sync11_r;  
    
    reg capture_en0_mux_r;
    reg capture_en1_mux_r;
    reg capture_en2_mux_r;
    reg capture_en3_mux_r;
    reg capture_en4_mux_r;
    reg capture_en5_mux_r;
    reg capture_en6_mux_r;
    reg capture_en7_mux_r;
    reg capture_en8_mux_r;
    reg capture_en9_mux_r;
    reg capture_en10_mux_r;
    reg capture_en11_mux_r; 
    
    wire capture_en0_mux;
    wire capture_en1_mux;
    wire capture_en2_mux;
    wire capture_en3_mux;
    wire capture_en4_mux;
    wire capture_en5_mux;
    wire capture_en6_mux;
    wire capture_en7_mux;
    wire capture_en8_mux;
    wire capture_en9_mux;
    wire capture_en10_mux;
    wire capture_en11_mux;         
    // User logic ends

  always @(posedge sys_clk0 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync0_r <= 0; 
      end
      else  begin
            rst_sync0_r <= pulse_on;       
      end


  always @(posedge sys_clk0 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync0 <= 0; 
      end
      else  begin
            rst_sync0 <= rst_sync0_r; 
     end

  always @(posedge sys_clk0 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            capture_en0_mux_r <= 0; 
      end
      else begin
            capture_en0_mux_r <= rst_sync0; 
      end

        
  always @(posedge sys_clk1 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync1_r <= 0; 
      end
      else  begin
            rst_sync1_r <= pulse_on;       
      end
        
   always @(posedge sys_clk1 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync1 <= 0; 
      end
      else  begin
            rst_sync1 <= rst_sync1_r; 
     end        

      
   always @(posedge sys_clk1 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0)begin
            capture_en1_mux_r <= 0; 
      end
      else begin
            capture_en1_mux_r <= rst_sync1; 
     end

      
   always @(posedge sys_clk2 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync2_r <= 0; 
      end
      else  begin
            rst_sync2_r <= pulse_on;       
      end

    
       always @(posedge sys_clk2 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync2 <= 0; 
      end
      else  begin
            rst_sync2 <= rst_sync2_r; 
     end    

      
   always @(posedge sys_clk2 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0)begin
            capture_en2_mux_r <= 0; 
      end
      else begin
            capture_en2_mux_r <= rst_sync2; 
     end

        
   always @(posedge sys_clk3 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync3_r <= 0; 
      end
      else  begin
            rst_sync3_r <= pulse_on;       
      end
        
    always @(posedge sys_clk3 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync3 <= 0; 
      end
      else  begin
            rst_sync3 <= rst_sync3_r; 
     end    
      
   always @(posedge sys_clk3 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en3_mux_r <= 0; 
      end
      else begin
            capture_en3_mux_r <= rst_sync3; 
      end

        
   always @(posedge sys_clk4 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync4_r <= 0; 
      end
      else  begin
            rst_sync4_r <= pulse_on;       
      end
        
    always @(posedge sys_clk4 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync4 <= 0; 
      end
      else  begin
            rst_sync4 <= rst_sync4_r; 
     end    
        
   always @(posedge sys_clk4 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en4_mux_r <= 0; 
      end
      else begin
            capture_en4_mux_r <= rst_sync4; 
      end

        
   always @(posedge sys_clk5 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync5_r <= 0; 
      end
      else  begin
            rst_sync5_r <= pulse_on;       
      end
                
    always @(posedge sys_clk5 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync5 <= 0; 
      end
      else  begin
            rst_sync5 <= rst_sync5_r; 
     end        

      
   always @(posedge sys_clk5 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en5_mux_r <= 0; 
      end
      else begin
            capture_en5_mux_r <= rst_sync5; 
      end

        
   always @(posedge sys_clk6 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync6_r <= 0; 
      end
      else  begin
            rst_sync6_r <= pulse_on;       
      end

    always @(posedge sys_clk6 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync6 <= 0; 
      end
      else  begin
            rst_sync6 <= rst_sync6_r; 
     end    

      
   always @(posedge sys_clk6 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en6_mux_r <= 0; 
      end
      else begin
            capture_en6_mux_r <= rst_sync6; 
      end


   always @(posedge sys_clk7 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync7_r <= 0; 
      end
      else  begin
            rst_sync7_r <= pulse_on;       
      end

    always @(posedge sys_clk7 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync7 <= 0; 
      end
      else  begin
            rst_sync7 <= rst_sync7_r; 
     end    

        
   always @(posedge sys_clk7 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en7_mux_r <= 0; 
      end
      else begin
            capture_en7_mux_r <= rst_sync7; 
      end


   always @(posedge sys_clk8 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync8_r <= 0; 
      end
      else  begin
            rst_sync8_r <= pulse_on;       
      end

    always @(posedge sys_clk8 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync8 <= 0; 
      end
      else  begin
            rst_sync8 <= rst_sync8_r; 
     end    

                
   always @(posedge sys_clk8 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en8_mux_r <= 0; 
      end
      else begin
            capture_en8_mux_r <= rst_sync8; 
      end


   always @(posedge sys_clk9 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync9_r <= 0; 
      end
      else  begin
            rst_sync9_r <= pulse_on;       
      end
        
    always @(posedge sys_clk9 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync9 <= 0; 
      end
      else  begin
            rst_sync9 <= rst_sync9_r; 
     end
      
   always @(posedge sys_clk9 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en9_mux_r = 0; 
      end
      else begin
            capture_en9_mux_r <= rst_sync9; 
      end

        
   always @(posedge sys_clk10 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync10_r <= 0; 
      end
      else  begin
            rst_sync10_r <= pulse_on;       
      end

        
    always @(posedge sys_clk10 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync10 <= 0; 
      end
      else  begin
            rst_sync10 <= rst_sync10_r; 
     end        

      
   always @(posedge sys_clk10 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en10_mux_r <= 0; 
      end
      else begin
            capture_en10_mux_r <= rst_sync10; 
      end
        

   always @(posedge sys_clk11 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync11_r <= 0; 
      end
      else  begin
            rst_sync11_r <= pulse_on;       
      end
                
    always @(posedge sys_clk11 or negedge S_AXI_ARESETN)
     if (S_AXI_ARESETN == 0) begin
            rst_sync11 <= 0; 
      end
      else  begin
            rst_sync11 <= rst_sync11_r; 
     end    
      
   always @(posedge sys_clk11 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
            capture_en11_mux_r <= 0; 
      end
      else begin
            capture_en11_mux_r <= rst_sync11; 
      end
    


assign capture_en0_mux  = capture_en0_mux_r;
assign capture_en1_mux  = capture_en1_mux_r;
assign capture_en2_mux  = capture_en2_mux_r;
assign capture_en3_mux  = capture_en3_mux_r;
assign capture_en4_mux  = capture_en4_mux_r;
assign capture_en5_mux  = capture_en5_mux_r;
assign capture_en6_mux  = capture_en6_mux_r;
assign capture_en7_mux  = capture_en7_mux_r;
assign capture_en8_mux  = capture_en8_mux_r;
assign capture_en9_mux  = capture_en9_mux_r;
assign capture_en10_mux = capture_en10_mux_r;
assign capture_en11_mux = capture_en11_mux_r;

// channel 0
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in0_shreg
                always @(posedge sys_clk0 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in0_d[var_i+1] <= 1'b0;
                    else if (capture_en0_mux) 
                        tdc_in0_d[var_i+1] <= tdc_in0_d[var_i];
                end
            end
    endgenerate
    
   always @(posedge sys_clk0 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in0_d[0] <= 1'b0;
      end 
      else if (capture_en0_mux) begin
              tdc_in0_d[0] <= tdc_in[0];
      end

   always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in0_d_r <= 128'd0;
             tdc_in1_d_r <= 128'd0;
             tdc_in2_d_r <= 128'd0;
             tdc_in3_d_r <= 128'd0;
             tdc_in4_d_r <= 128'd0;
             tdc_in5_d_r <= 128'd0;
             tdc_in6_d_r <= 128'd0;
             tdc_in7_d_r <= 128'd0;
             tdc_in8_d_r <= 128'd0;
             tdc_in9_d_r <= 128'd0;
             tdc_in10_d_r <= 128'd0;
             tdc_in11_d_r <= 128'd0;
             
      end 
      else begin
              tdc_in0_d_r <=tdc_in0_d;
              tdc_in1_d_r <=tdc_in1_d;
              tdc_in2_d_r <=tdc_in2_d;
              tdc_in3_d_r <=tdc_in3_d;
              tdc_in4_d_r <=tdc_in4_d;
              tdc_in5_d_r <=tdc_in5_d;
              tdc_in6_d_r <=tdc_in6_d;
              tdc_in7_d_r <=tdc_in7_d;
              tdc_in8_d_r <=tdc_in8_d;
              tdc_in9_d_r <=tdc_in9_d;
              tdc_in10_d_r <=tdc_in10_d;
              tdc_in11_d_r <=tdc_in11_d;
      end        
              

// channel 1
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in1_shreg
                always @(posedge sys_clk1 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in1_d[var_i+1] <= 1'b0;
                    else if (capture_en1_mux) 
                        tdc_in1_d[var_i+1] <= tdc_in1_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk1 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in1_d[0] <= 1'b0;
      end 
      else if (capture_en1_mux) begin
              tdc_in1_d[0] <= tdc_in[1];
      end        

// channel 2
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in2_shreg
                always @(posedge sys_clk2 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in2_d[var_i+1] <= 1'b0;
                    else if (capture_en2_mux) 
                        tdc_in2_d[var_i+1] <= tdc_in2_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk2 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in2_d[0] <= 1'b0;
      end 
      else if (capture_en2_mux) begin
              tdc_in2_d[0] <= tdc_in[2];
      end    

// channel 3    
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in3_shreg
                always @(posedge sys_clk3 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in3_d[var_i+1] <= 1'b0;
                    else if (capture_en3_mux) 
                        tdc_in3_d[var_i+1] <= tdc_in3_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk3 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in3_d[0] <= 1'b0;
      end 
      else if (capture_en3_mux) begin
              tdc_in3_d[0] <= tdc_in[3];
      end    

// channel 4
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in4_shreg
                always @(posedge sys_clk4 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in4_d[var_i+1] <= 1'b0;
                    else if (capture_en4_mux) 
                        tdc_in4_d[var_i+1] <= tdc_in4_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk4 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in4_d[0] <= 1'b0;
      end 
      else if (capture_en4_mux) begin
              tdc_in4_d[0] <= tdc_in[4];
      end            

// channel 5
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in5_shreg
                always @(posedge sys_clk5 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in5_d[var_i+1] <= 1'b0;
                    else if (capture_en5_mux) 
                        tdc_in5_d[var_i+1] <= tdc_in5_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk5 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in5_d[0] <= 1'b0;
      end 
      else if (capture_en5_mux) begin
              tdc_in5_d[0] <= tdc_in[5];
      end    


// channel 6
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in6_shreg
                always @(posedge sys_clk6 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in6_d[var_i+1] <= 1'b0;
                    else if (capture_en6_mux) 
                        tdc_in6_d[var_i+1] <= tdc_in6_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk6 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in6_d[0] <= 1'b0;
      end 
      else if (capture_en6_mux) begin
              tdc_in6_d[0] <= tdc_in[6];
      end    

// channel 7
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in7_shreg
                always @(posedge sys_clk7 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in7_d[var_i+1] <= 1'b0;
                    else if (capture_en7_mux) 
                        tdc_in7_d[var_i+1] <= tdc_in7_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk7 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in7_d[0] <= 1'b0;
      end 
      else if (capture_en7_mux) begin
              tdc_in7_d[0] <= tdc_in[7];
      end    

// channel 8
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in8_shreg
                always @(posedge sys_clk8 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in8_d[var_i+1] <= 1'b0;
                    else if (capture_en8_mux) 
                        tdc_in8_d[var_i+1] <= tdc_in8_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk8 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in8_d[0] <= 1'b0;
      end 
      else if (capture_en8_mux) begin
              tdc_in8_d[0] <= tdc_in[8];
      end    

// channel 9
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in9_shreg
                always @(posedge sys_clk9 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in9_d[var_i+1] <= 1'b0;
                    else if (capture_en9_mux) 
                        tdc_in9_d[var_i+1] <= tdc_in9_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk9 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in9_d[0] <= 1'b0;
      end 
      else if (capture_en9_mux) begin
              tdc_in9_d[0] <= tdc_in[9];
      end    

// channel 10
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in10_shreg
                always @(posedge sys_clk10 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in10_d[var_i+1] <= 1'b0;
                    else if (capture_en10_mux) 
                        tdc_in10_d[var_i+1] <= tdc_in10_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk10 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in10_d[0] <= 1'b0;
      end 
      else if (capture_en10_mux) begin
              tdc_in10_d[0] <= tdc_in[10];
      end    

// channel 11
    generate
        for (genvar var_i=0; var_i < 127; var_i=var_i+1) 
            begin: tdc_in11_shreg
                always @(posedge sys_clk11 or negedge S_AXI_ARESETN) begin
                    if (S_AXI_ARESETN == 0)
                        tdc_in11_d[var_i+1] <= 1'b0;
                    else if (capture_en11_mux) 
                        tdc_in11_d[var_i+1] <= tdc_in11_d[var_i];
                end
            end
    endgenerate
        
   always @(posedge sys_clk11 or negedge S_AXI_ARESETN)
      if (S_AXI_ARESETN == 0)begin
             tdc_in11_d[0] <= 1'b0;
      end 
      else if (capture_en11_mux) begin
              tdc_in11_d[0] <= tdc_in[11];
      end    

	// User logic ends

	endmodule
