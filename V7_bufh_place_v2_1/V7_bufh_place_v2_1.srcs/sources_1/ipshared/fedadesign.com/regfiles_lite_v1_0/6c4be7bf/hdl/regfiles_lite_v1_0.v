
`timescale 1 ns / 1 ps

	module regfiles_lite_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here
		output wire  fifo_rst,
        // start bit of ps_con module (phase shift controller)
        output wire  ps_start,
        // data bits of ps_con module (phase shift controller): the amount of phase shifts        
        output wire [15:0]  ps_data,
        // selection of phase shift channel of ps_con module (0 - 11)        
        output wire [3:0]  ps_sel,
        // direction bit of phase shift (1: increase, 0: decrease)         
        output wire  ps_incdec,
        // stop signal of the TDC operation        
        output wire  stop_oper,
        // start bit of FIFO2STREAM module        
        output wire  fifo2stream_start,
        // number of writes of FIFO2STREAM module        
        output wire [31:0]  fifo2stream_numofwrite,
        output wire  sel_fifo2ddr,
        // software-controlled TDC enable bit 
        output wire  soft_tdc_en,
        // pulse duration of internally generated TDC enable 
        output wire [31:0] rg_dur,
        // start bit of internal TDC enable generating module
        output wire  tdc_en_p_start,
        // 
        output wire [15:0] tdc_en_p_dur,
        
        output wire [11:0]  calib_bit,
        
        output wire tdc_en_bypass_on,    
        
        output wire dac_spi_start,
        output wire [15:0] dac_spi_data, 
        
        output wire clk_spi_start,
        output wire [31:0] clk_spi_data, 
                   
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	regfiles_lite_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) regfiles_lite_v1_0_S00_AXI_inst (
        .fifo_rst(fifo_rst),        
        .ps_start(ps_start),                
        .ps_data(ps_data),       
        .ps_sel(ps_sel),                 
        .ps_incdec(ps_incdec),                
        .stop_oper(stop_oper),                
        .fifo2stream_start(fifo2stream_start),                
        .fifo2stream_numofwrite(fifo2stream_numofwrite),
        .sel_fifo2ddr(sel_fifo2ddr),         
        .soft_tdc_en(soft_tdc_en),         
        .rg_dur(rg_dur),        
        .tdc_en_p_start(tdc_en_p_start),        
        .tdc_en_p_dur(tdc_en_p_dur),  
        .calib_bit(calib_bit),	
        .tdc_en_bypass_on(tdc_en_bypass_on),
        .dac_spi_start(dac_spi_start),
        .dac_spi_data(dac_spi_data),   
        .clk_spi_start(clk_spi_start),
        .clk_spi_data(clk_spi_data),
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
