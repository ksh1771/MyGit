module front_dFFs_v3
  (
    input sys_clk0,
    input sys_clk1,
    input sys_clk2,
    input sys_clk3,
    input sys_clk4,
    input sys_clk5,
    input sys_clk6,
    input sys_clk7,
    input sys_clk8,
    input sys_clk9,
    input sys_clk10,
    input sys_clk11,

	input sys_rst0,
	input sys_rst1,
	input sys_rst2,
	input sys_rst3,
	input sys_rst4,
	input sys_rst5,
	input sys_rst6,
	input sys_rst7,
	input sys_rst8,
	input sys_rst9,
	input sys_rst10,
	input sys_rst11,

	input i_tdc_in,
	
	output [11:0]		o_tdc_data
);

		
// signals from front-end F/Fs
wire [11:0] fe_data;


assign o_tdc_data = fe_data;


FDCE #( 
		.INIT(1'b0)
) front_dFF_inst0_0 (
		.Q(fe_data[0]),
		.C(sys_clk0),
		.CE(1'b1),
		.CLR(sys_rst0),
		.D(i_tdc_in)
);


FDCE #( 
		.INIT(1'b0)
) front_dFF_inst1_0 (
		.Q(fe_data[1]),
		.C(sys_clk1),
		.CE(1'b1),
		.CLR(sys_rst1),
		.D(i_tdc_in)
);

FDCE #( 
		.INIT(1'b0)
) front_dFF_inst2_0 (
		.Q(fe_data[2]),
		.C(sys_clk2),
		.CE(1'b1),
		.CLR(sys_rst2),
		.D(i_tdc_in)
);

FDCE #( 
		.INIT(1'b0)
) front_dFF_inst3_0 (
		.Q(fe_data[3]),
		.C(sys_clk3),
		.CE(1'b1),
		.CLR(sys_rst3),
		.D(i_tdc_in)
);

FDCE #( 
		.INIT(1'b0)
) front_dFF_inst4_0 (
		.Q(fe_data[4]),
		.C(sys_clk4),
		.CE(1'b1),
		.CLR(sys_rst4),
		.D(i_tdc_in)
);

FDCE #( 
		.INIT(1'b0)
) front_dFF_inst5_0 (
		.Q(fe_data[5]),
		.C(sys_clk5),
		.CE(1'b1),
		.CLR(sys_rst5),
		.D(i_tdc_in)
);

FDCE #( 
		.INIT(1'b0)
) front_dFF_inst6_0 (
		.Q(fe_data[6]),
		.C(sys_clk6),
		.CE(1'b1),
		.CLR(sys_rst6),
		.D(i_tdc_in)
);

FDCE #( 
		.INIT(1'b0)
) front_dFF_inst7_0 (
		.Q(fe_data[7]),
		.C(sys_clk7),
		.CE(1'b1),
		.CLR(sys_rst7),
		.D(i_tdc_in)
);


FDCE #( 
		.INIT(1'b0)
) front_dFF_inst8_0 (
		.Q(fe_data[8]),
		.C(sys_clk8),
		.CE(1'b1),
		.CLR(sys_rst8),
		.D(i_tdc_in)
);


FDCE #( 
		.INIT(1'b0)
) front_dFF_inst9_0 (
		.Q(fe_data[9]),
		.C(sys_clk9),
		.CE(1'b1),
		.CLR(sys_rst9),
		.D(i_tdc_in)
);
FDCE #( 
		.INIT(1'b0)
) front_dFF_inst10_0 (
		.Q(fe_data[10]),
		.C(sys_clk10),
		.CE(1'b1),
		.CLR(sys_rst10),
		.D(i_tdc_in)
);
FDCE #( 
		.INIT(1'b0)
) front_dFF_inst11_0 (
		.Q(fe_data[11]),
		.C(sys_clk11),
		.CE(1'b1),
		.CLR(sys_rst11),
		.D(i_tdc_in)
);


endmodule


