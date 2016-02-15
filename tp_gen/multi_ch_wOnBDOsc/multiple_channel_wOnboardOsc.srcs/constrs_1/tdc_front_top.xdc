set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]

############## NET - IOSTANDARD ##################
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_w0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_w1]

set_property PACKAGE_PIN AV30 [get_ports {dip_input[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dip_input[0]}]
set_property DRIVE 12 [get_ports {dip_input[0]}]
set_property SLEW SLOW [get_ports {dip_input[0]}]

set_property PACKAGE_PIN AY33 [get_ports {dip_input[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dip_input[1]}]
set_property DRIVE 12 [get_ports {dip_input[1]}]
set_property SLEW SLOW [get_ports {dip_input[1]}]



#set_property PACKAGE_PIN AJ32 [get_ports clk_in]
#set_property IOSTANDARD LVCMOS18 [get_ports clk_in]

set_property PACKAGE_PIN E19 [get_ports clk_in_p]
set_property IOSTANDARD LVDS [get_ports clk_in_p]
set_property PACKAGE_PIN E18 [get_ports clk_in_n]
set_property IOSTANDARD LVDS [get_ports clk_in_n]

set_property PACKAGE_PIN AV40 [get_ports sys_rst]
set_property IOSTANDARD LVCMOS18 [get_ports sys_rst]

set_property PACKAGE_PIN AM39 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[0]}]
set_property DRIVE 12 [get_ports {led[0]}]
set_property SLEW FAST [get_ports {led[0]}]

set_property PACKAGE_PIN AN39 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[1]}]
set_property DRIVE 12 [get_ports {led[1]}]
set_property SLEW FAST [get_ports {led[1]}]

set_property PACKAGE_PIN AR37 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[2]}]
set_property DRIVE 12 [get_ports {led[2]}]
set_property SLEW FAST [get_ports {led[2]}]

set_property PACKAGE_PIN AT37 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[3]}]
set_property DRIVE 12 [get_ports {led[3]}]
set_property SLEW FAST [get_ports {led[3]}]

set_property PACKAGE_PIN AN31 [get_ports tdc_en_out]
set_property IOSTANDARD LVCMOS18 [get_ports tdc_en_out]
set_property DRIVE 12 [get_ports tdc_en_out]
set_property SLEW FAST [get_ports tdc_en_out]

set_property PACKAGE_PIN M33 [get_ports dummy_out]
set_property IOSTANDARD LVCMOS18 [get_ports dummy_out]
set_property DRIVE 12 [get_ports dummy_out]
set_property SLEW FAST [get_ports dummy_out]

#####################################################
set_property PACKAGE_PIN AP31 [get_ports {tp_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[0]}]
set_property DRIVE 12 [get_ports {tp_out[0]}]
set_property SLEW FAST [get_ports {tp_out[0]}]
#####################################################


set_property PACKAGE_PIN K42 [get_ports {tp_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[1]}]
set_property DRIVE 12 [get_ports {tp_out[1]}]
set_property SLEW FAST [get_ports {tp_out[1]}]

set_property PACKAGE_PIN H39 [get_ports {tp_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[2]}]
set_property DRIVE 12 [get_ports {tp_out[2]}]
set_property SLEW FAST [get_ports {tp_out[2]}]

set_property PACKAGE_PIN M41 [get_ports {tp_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[3]}]
set_property DRIVE 12 [get_ports {tp_out[3]}]
set_property SLEW FAST [get_ports {tp_out[3]}]

set_property PACKAGE_PIN N38 [get_ports {tp_out[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[4]}]
set_property DRIVE 12 [get_ports {tp_out[4]}]
set_property SLEW FAST [get_ports {tp_out[4]}]

set_property PACKAGE_PIN R42 [get_ports {tp_out[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[5]}]
set_property DRIVE 12 [get_ports {tp_out[5]}]
set_property SLEW FAST [get_ports {tp_out[5]}]

set_property PACKAGE_PIN K37 [get_ports {tp_out[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[6]}]
set_property DRIVE 12 [get_ports {tp_out[6]}]
set_property SLEW FAST [get_ports {tp_out[6]}]

set_property PACKAGE_PIN N39 [get_ports {tp_out[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[7]}]
set_property DRIVE 12 [get_ports {tp_out[7]}]
set_property SLEW FAST [get_ports {tp_out[7]}]

set_property PACKAGE_PIN F40 [get_ports {tp_out[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[8]}]
set_property DRIVE 12 [get_ports {tp_out[8]}]
set_property SLEW FAST [get_ports {tp_out[8]}]

set_property PACKAGE_PIN K39 [get_ports {tp_out[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[9]}]
set_property DRIVE 12 [get_ports {tp_out[9]}]
set_property SLEW FAST [get_ports {tp_out[9]}]

#####################################################
set_property PACKAGE_PIN P41 [get_ports {tp_out[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[10]}]
set_property DRIVE 12 [get_ports {tp_out[10]}]
set_property SLEW FAST [get_ports {tp_out[10]}]
#####################################################

set_property PACKAGE_PIN H40 [get_ports {tp_out[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[11]}]
set_property DRIVE 12 [get_ports {tp_out[11]}]
set_property SLEW FAST [get_ports {tp_out[11]}]

set_property PACKAGE_PIN M37 [get_ports {tp_out[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[12]}]
set_property DRIVE 12 [get_ports {tp_out[12]}]
set_property SLEW FAST [get_ports {tp_out[12]}]

set_property PACKAGE_PIN G41 [get_ports {tp_out[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[13]}]
set_property DRIVE 12 [get_ports {tp_out[13]}]
set_property SLEW FAST [get_ports {tp_out[13]}]

set_property PACKAGE_PIN R40 [get_ports {tp_out[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[14]}]
set_property DRIVE 12 [get_ports {tp_out[14]}]
set_property SLEW FAST [get_ports {tp_out[14]}]

set_property PACKAGE_PIN F34 [get_ports {tp_out[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[15]}]
set_property DRIVE 12 [get_ports {tp_out[15]}]
set_property SLEW FAST [get_ports {tp_out[15]}]

set_property PACKAGE_PIN E32 [get_ports {tp_out[16]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[16]}]
set_property DRIVE 12 [get_ports {tp_out[16]}]
set_property SLEW FAST [get_ports {tp_out[16]}]

set_property PACKAGE_PIN G32 [get_ports {tp_out[17]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[17]}]
set_property DRIVE 12 [get_ports {tp_out[17]}]
set_property SLEW FAST [get_ports {tp_out[17]}]

set_property PACKAGE_PIN B36 [get_ports {tp_out[18]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[18]}]
set_property DRIVE 12 [get_ports {tp_out[18]}]
set_property SLEW FAST [get_ports {tp_out[18]}]

set_property PACKAGE_PIN C38 [get_ports {tp_out[19]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[19]}]
set_property DRIVE 12 [get_ports {tp_out[19]}]
set_property SLEW FAST [get_ports {tp_out[19]}]

set_property PACKAGE_PIN B34 [get_ports {tp_out[20]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[20]}]
set_property DRIVE 12 [get_ports {tp_out[20]}]
set_property SLEW FAST [get_ports {tp_out[20]}]

set_property PACKAGE_PIN B39 [get_ports {tp_out[21]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[21]}]
set_property DRIVE 12 [get_ports {tp_out[21]}]
set_property SLEW FAST [get_ports {tp_out[21]}]

set_property PACKAGE_PIN B37 [get_ports {tp_out[22]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[22]}]
set_property DRIVE 12 [get_ports {tp_out[22]}]
set_property SLEW FAST [get_ports {tp_out[22]}]

set_property PACKAGE_PIN B32 [get_ports {tp_out[23]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[23]}]
set_property DRIVE 12 [get_ports {tp_out[23]}]
set_property SLEW FAST [get_ports {tp_out[23]}]

set_property PACKAGE_PIN D35 [get_ports {tp_out[24]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[24]}]
set_property DRIVE 12 [get_ports {tp_out[24]}]
set_property SLEW FAST [get_ports {tp_out[24]}]

set_property PACKAGE_PIN E34 [get_ports {tp_out[25]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[25]}]
set_property DRIVE 12 [get_ports {tp_out[25]}]
set_property SLEW FAST [get_ports {tp_out[25]}]

set_property PACKAGE_PIN D37 [get_ports {tp_out[26]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[26]}]
set_property DRIVE 12 [get_ports {tp_out[26]}]
set_property SLEW FAST [get_ports {tp_out[26]}]

set_property PACKAGE_PIN C33 [get_ports {tp_out[27]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[27]}]
set_property DRIVE 12 [get_ports {tp_out[27]}]
set_property SLEW FAST [get_ports {tp_out[27]}]

set_property PACKAGE_PIN A35 [get_ports {tp_out[28]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[28]}]
set_property DRIVE 12 [get_ports {tp_out[28]}]
set_property SLEW FAST [get_ports {tp_out[28]}]

set_property PACKAGE_PIN F36 [get_ports {tp_out[29]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[29]}]
set_property DRIVE 12 [get_ports {tp_out[29]}]
set_property SLEW FAST [get_ports {tp_out[29]}]

set_property PACKAGE_PIN G36 [get_ports {tp_out[30]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[30]}]
set_property DRIVE 12 [get_ports {tp_out[30]}]
set_property SLEW FAST [get_ports {tp_out[30]}]

set_property PACKAGE_PIN H33 [get_ports {tp_out[31]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[31]}]
set_property DRIVE 12 [get_ports {tp_out[31]}]
set_property SLEW FAST [get_ports {tp_out[31]}]

set_property PACKAGE_PIN H38 [get_ports {tp_out[32]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[32]}]
set_property DRIVE 12 [get_ports {tp_out[32]}]
set_property SLEW FAST [get_ports {tp_out[32]}]

set_property PACKAGE_PIN E33 [get_ports {tp_out[33]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[33]}]
set_property DRIVE 12 [get_ports {tp_out[33]}]
set_property SLEW FAST [get_ports {tp_out[33]}]

set_property PACKAGE_PIN F39 [get_ports {tp_out[34]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[34]}]
set_property DRIVE 12 [get_ports {tp_out[34]}]
set_property SLEW FAST [get_ports {tp_out[34]}]

set_property PACKAGE_PIN J37 [get_ports {tp_out[35]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[35]}]
set_property DRIVE 12 [get_ports {tp_out[35]}]
set_property SLEW FAST [get_ports {tp_out[35]}]

set_property PACKAGE_PIN K27 [get_ports {tp_out[36]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[36]}]
set_property DRIVE 12 [get_ports {tp_out[36]}]
set_property SLEW FAST [get_ports {tp_out[36]}]

set_property PACKAGE_PIN L25 [get_ports {tp_out[37]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[37]}]
set_property DRIVE 12 [get_ports {tp_out[37]}]
set_property SLEW FAST [get_ports {tp_out[37]}]

set_property PACKAGE_PIN H24 [get_ports {tp_out[38]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[38]}]
set_property DRIVE 12 [get_ports {tp_out[38]}]
set_property SLEW FAST [get_ports {tp_out[38]}]

set_property PACKAGE_PIN P22 [get_ports {tp_out[39]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[39]}]
set_property DRIVE 12 [get_ports {tp_out[39]}]
set_property SLEW FAST [get_ports {tp_out[39]}]

set_property PACKAGE_PIN P21 [get_ports {tp_out[40]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[40]}]
set_property DRIVE 12 [get_ports {tp_out[40]}]
set_property SLEW FAST [get_ports {tp_out[40]}]

set_property PACKAGE_PIN M21 [get_ports {tp_out[41]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[41]}]
set_property DRIVE 12 [get_ports {tp_out[41]}]
set_property SLEW FAST [get_ports {tp_out[41]}]

set_property PACKAGE_PIN P25 [get_ports {tp_out[42]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[42]}]
set_property DRIVE 12 [get_ports {tp_out[42]}]
set_property SLEW FAST [get_ports {tp_out[42]}]

set_property PACKAGE_PIN N25 [get_ports {tp_out[43]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[43]}]
set_property DRIVE 12 [get_ports {tp_out[43]}]
set_property SLEW FAST [get_ports {tp_out[43]}]

set_property PACKAGE_PIN M24 [get_ports {tp_out[44]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[44]}]
set_property DRIVE 12 [get_ports {tp_out[44]}]
set_property SLEW FAST [get_ports {tp_out[44]}]

set_property PACKAGE_PIN J25 [get_ports {tp_out[45]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[45]}]
set_property DRIVE 12 [get_ports {tp_out[45]}]
set_property SLEW FAST [get_ports {tp_out[45]}]

set_property PACKAGE_PIN K23 [get_ports {tp_out[46]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[46]}]
set_property DRIVE 12 [get_ports {tp_out[46]}]
set_property SLEW FAST [get_ports {tp_out[46]}]

set_property PACKAGE_PIN H25 [get_ports {tp_out[47]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[47]}]
set_property DRIVE 12 [get_ports {tp_out[47]}]
set_property SLEW FAST [get_ports {tp_out[47]}]

set_property PACKAGE_PIN K28 [get_ports {tp_out[48]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[48]}]
set_property DRIVE 12 [get_ports {tp_out[48]}]
set_property SLEW FAST [get_ports {tp_out[48]}]

set_property PACKAGE_PIN H23 [get_ports {tp_out[49]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[49]}]
set_property DRIVE 12 [get_ports {tp_out[49]}]
set_property SLEW FAST [get_ports {tp_out[49]}]

set_property PACKAGE_PIN G28 [get_ports {tp_out[50]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[50]}]
set_property DRIVE 12 [get_ports {tp_out[50]}]
set_property SLEW FAST [get_ports {tp_out[50]}]

set_property PACKAGE_PIN M22 [get_ports {tp_out[51]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[51]}]
set_property DRIVE 12 [get_ports {tp_out[51]}]
set_property SLEW FAST [get_ports {tp_out[51]}]

set_property PACKAGE_PIN H28 [get_ports {tp_out[52]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[52]}]
set_property DRIVE 12 [get_ports {tp_out[52]}]
set_property SLEW FAST [get_ports {tp_out[52]}]

set_property PACKAGE_PIN J21 [get_ports {tp_out[53]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[53]}]
set_property DRIVE 12 [get_ports {tp_out[53]}]
set_property SLEW FAST [get_ports {tp_out[53]}]

set_property PACKAGE_PIN G26 [get_ports {tp_out[54]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[54]}]
set_property DRIVE 12 [get_ports {tp_out[54]}]
set_property SLEW FAST [get_ports {tp_out[54]}]

set_property PACKAGE_PIN G21 [get_ports {tp_out[55]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[55]}]
set_property DRIVE 12 [get_ports {tp_out[55]}]
set_property SLEW FAST [get_ports {tp_out[55]}]

set_property PACKAGE_PIN K22 [get_ports {tp_out[56]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[56]}]
set_property DRIVE 12 [get_ports {tp_out[56]}]
set_property SLEW FAST [get_ports {tp_out[56]}]

set_property PACKAGE_PIN J31 [get_ports {tp_out[57]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[57]}]
set_property DRIVE 12 [get_ports {tp_out[57]}]
set_property SLEW FAST [get_ports {tp_out[57]}]

set_property PACKAGE_PIN P30 [get_ports {tp_out[58]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[58]}]
set_property DRIVE 12 [get_ports {tp_out[58]}]
set_property SLEW FAST [get_ports {tp_out[58]}]

set_property PACKAGE_PIN J30 [get_ports {tp_out[59]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[59]}]
set_property DRIVE 12 [get_ports {tp_out[59]}]
set_property SLEW FAST [get_ports {tp_out[59]}]

set_property PACKAGE_PIN N28 [get_ports {tp_out[60]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[60]}]
set_property DRIVE 12 [get_ports {tp_out[60]}]
set_property SLEW FAST [get_ports {tp_out[60]}]

set_property PACKAGE_PIN R28 [get_ports {tp_out[61]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[61]}]
set_property DRIVE 12 [get_ports {tp_out[61]}]
set_property SLEW FAST [get_ports {tp_out[61]}]

set_property PACKAGE_PIN Y29 [get_ports {tp_out[62]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[62]}]
set_property DRIVE 12 [get_ports {tp_out[62]}]
set_property SLEW FAST [get_ports {tp_out[62]}]

set_property PACKAGE_PIN W30 [get_ports {tp_out[63]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[63]}]
set_property DRIVE 12 [get_ports {tp_out[63]}]
set_property SLEW FAST [get_ports {tp_out[63]}]

set_property PACKAGE_PIN M36 [get_ports {tp_out[64]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[64]}]
set_property DRIVE 12 [get_ports {tp_out[64]}]
set_property SLEW FAST [get_ports {tp_out[64]}]

set_property PACKAGE_PIN J40 [get_ports {tp_out[65]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[65]}]
set_property DRIVE 12 [get_ports {tp_out[65]}]
set_property SLEW FAST [get_ports {tp_out[65]}]

set_property PACKAGE_PIN L31 [get_ports {tp_out[66]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[66]}]
set_property DRIVE 12 [get_ports {tp_out[66]}]
set_property SLEW FAST [get_ports {tp_out[66]}]

set_property PACKAGE_PIN M32 [get_ports {tp_out[67]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[67]}]
set_property DRIVE 12 [get_ports {tp_out[67]}]
set_property SLEW FAST [get_ports {tp_out[67]}]

set_property PACKAGE_PIN T29 [get_ports {tp_out[68]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[68]}]
set_property DRIVE 12 [get_ports {tp_out[68]}]
set_property SLEW FAST [get_ports {tp_out[68]}]

set_property PACKAGE_PIN V29 [get_ports {tp_out[69]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[69]}]
set_property DRIVE 12 [get_ports {tp_out[69]}]
set_property SLEW FAST [get_ports {tp_out[69]}]

set_property PACKAGE_PIN R30 [get_ports {tp_out[70]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[70]}]
set_property DRIVE 12 [get_ports {tp_out[70]}]
set_property SLEW FAST [get_ports {tp_out[70]}]

set_property PACKAGE_PIN V30 [get_ports {tp_out[71]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[71]}]
set_property DRIVE 12 [get_ports {tp_out[71]}]
set_property SLEW FAST [get_ports {tp_out[71]}]

set_property PACKAGE_PIN M28 [get_ports {tp_out[72]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[72]}]
set_property DRIVE 12 [get_ports {tp_out[72]}]
set_property SLEW FAST [get_ports {tp_out[72]}]

set_property PACKAGE_PIN K29 [get_ports {tp_out[73]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[73]}]
set_property DRIVE 12 [get_ports {tp_out[73]}]
set_property SLEW FAST [get_ports {tp_out[73]}]

set_property PACKAGE_PIN U31 [get_ports {tp_out[74]}]
set_property IOSTANDARD LVCMOS18 [get_ports {tp_out[74]}]
set_property DRIVE 12 [get_ports {tp_out[74]}]
set_property SLEW FAST [get_ports {tp_out[74]}]




