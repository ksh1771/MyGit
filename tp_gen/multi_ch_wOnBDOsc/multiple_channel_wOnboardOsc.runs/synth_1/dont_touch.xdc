# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: tdc_front_top.xdc

# IP: ip/ila_0_0/ila_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==ila_0 || ORIG_REF_NAME==ila_0}]

# XDC: ip/ila_0_0/constraints/ila.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==ila_0 || ORIG_REF_NAME==ila_0}] {/inst }]/inst ]]

# XDC: ip/ila_0_0/ila_0_ooc.xdc
