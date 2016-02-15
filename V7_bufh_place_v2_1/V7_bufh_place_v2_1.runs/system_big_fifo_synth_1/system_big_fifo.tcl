# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7vx485tffg1761-2

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.cache/wt [current_project]
set_property parent.project_path /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part xilinx.com:vc707:part0:1.0 [current_project]
set_property ip_repo_paths {
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/axi4lite_gp_1.0_0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/gen_test_pulse_lite_1.0_0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/regfiles_lite_1.0_0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/tdc_calib_capture_lite_1.0_0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/fifo2ddr_v1_0_project_0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/axi4lite_gp_1.0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/gen_test_pulse_lite_1.0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/regfiles_lite_1.0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/tdc_calib_capture_lite_1.0
  /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.ipdefs/fifo2ddr_v1_0_project
} [current_project]
read_ip /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo.xci
set_property used_in_implementation false [get_files -all /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo.dcp]
set_property is_locked true [get_files /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo.xci]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top system_big_fifo -part xc7vx485tffg1761-2 -mode out_of_context
rename_ref -prefix_all system_big_fifo_
write_checkpoint -noxdef system_big_fifo.dcp
catch { report_utilization -file system_big_fifo_utilization_synth.rpt -pb system_big_fifo_utilization_synth.pb }
if { [catch {
  file copy -force /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.runs/system_big_fifo_synth_1/system_big_fifo.dcp /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo.dcp
} _RESULT ] } { 
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}
if { [catch {
  write_verilog -force -mode synth_stub /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode synth_stub /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_verilog -force -mode funcsim /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo_funcsim.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode funcsim /home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo_funcsim.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
