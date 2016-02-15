proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7vx485tffg1761-2
  set_property board_part xilinx.com:vc707:part0:1.0 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.cache/wt [current_project]
  set_property parent.project_path /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.xpr [current_project]
  set_property ip_repo_paths {
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.cache/ip
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/axi4lite_gp_1.0_0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/gen_test_pulse_lite_1.0_0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/regfiles_lite_1.0_0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/tdc_calib_capture_lite_1.0_0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/fifo2ddr_v1_0_project_0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/axi4lite_gp_1.0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/gen_test_pulse_lite_1.0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/regfiles_lite_1.0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/tdc_calib_capture_lite_1.0_0
  /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.ipdefs/fifo2ddr_v1_0_project_0
} [current_project]
  set_property ip_output_repo /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.cache/ip [current_project]
  add_files -quiet /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.runs/synth_2/tdc_front_top.dcp
  add_files -quiet /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.runs/ch_fifo_synth_1/ch_fifo.dcp
  set_property netlist_only true [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.runs/ch_fifo_synth_1/ch_fifo.dcp]
  add_files -quiet /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.runs/system_big_fifo_synth_1/system_big_fifo.dcp
  set_property netlist_only true [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.runs/system_big_fifo_synth_1/system_big_fifo.dcp]
  read_xdc -ref axi_system_axi_chip2chip_0_0 -cells inst /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_axi_chip2chip_0_0/axi_system_axi_chip2chip_0_0.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_axi_chip2chip_0_0/axi_system_axi_chip2chip_0_0.xdc]
  read_xdc -prop_thru_buffers -ref axi_system_proc_sys_reset_0_0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_proc_sys_reset_0_0/axi_system_proc_sys_reset_0_0_board.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_proc_sys_reset_0_0/axi_system_proc_sys_reset_0_0_board.xdc]
  read_xdc -ref axi_system_proc_sys_reset_0_0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_proc_sys_reset_0_0/axi_system_proc_sys_reset_0_0.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_proc_sys_reset_0_0/axi_system_proc_sys_reset_0_0.xdc]
  read_xdc -ref axi_system_mig_7series_0_0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_mig_7series_0_0/axi_system_mig_7series_0_0/user_design/constraints/axi_system_mig_7series_0_0.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_mig_7series_0_0/axi_system_mig_7series_0_0/user_design/constraints/axi_system_mig_7series_0_0.xdc]
  read_xdc -ref axi_system_axi_dma_0_0 -cells U0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_axi_dma_0_0/axi_system_axi_dma_0_0.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_axi_dma_0_0/axi_system_axi_dma_0_0.xdc]
  read_xdc -prop_thru_buffers -ref axi_system_proc_sys_reset_1_0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_proc_sys_reset_1_0/axi_system_proc_sys_reset_1_0_board.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_proc_sys_reset_1_0/axi_system_proc_sys_reset_1_0_board.xdc]
  read_xdc -ref axi_system_proc_sys_reset_1_0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_proc_sys_reset_1_0/axi_system_proc_sys_reset_1_0.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_proc_sys_reset_1_0/axi_system_proc_sys_reset_1_0.xdc]
  read_xdc -mode out_of_context -ref ch_fifo -cells U0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/ch_fifo/ch_fifo_ooc.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/ch_fifo/ch_fifo_ooc.xdc]
  read_xdc -ref ch_fifo -cells U0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/ch_fifo/ch_fifo/ch_fifo.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/ch_fifo/ch_fifo/ch_fifo.xdc]
  read_xdc -mode out_of_context -ref system_big_fifo -cells U0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo_ooc.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo_ooc.xdc]
  read_xdc -ref system_big_fifo -cells U0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo/system_big_fifo.xdc
  set_property processing_order EARLY [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo/system_big_fifo.xdc]
  read_xdc /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/constrs_1/tdc_front_top.xdc
  read_xdc -ref axi_system_axi_chip2chip_0_0 -cells inst /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_axi_chip2chip_0_0/axi_system_axi_chip2chip_0_0_clocks.xdc
  set_property processing_order LATE [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_axi_chip2chip_0_0/axi_system_axi_chip2chip_0_0_clocks.xdc]
  read_xdc -ref axi_system_axi_dma_0_0 -cells U0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_axi_dma_0_0/axi_system_axi_dma_0_0_clocks.xdc
  set_property processing_order LATE [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_axi_dma_0_0/axi_system_axi_dma_0_0_clocks.xdc]
  read_xdc -ref axi_system_auto_cc_0 -cells inst /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_auto_cc_0/axi_system_auto_cc_0_clocks.xdc
  set_property processing_order LATE [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/bd/axi_system/ip/axi_system_auto_cc_0/axi_system_auto_cc_0_clocks.xdc]
  read_xdc -ref ch_fifo -cells U0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/ch_fifo/ch_fifo/ch_fifo_clocks.xdc
  set_property processing_order LATE [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/ch_fifo/ch_fifo/ch_fifo_clocks.xdc]
  read_xdc -ref system_big_fifo -cells U0 /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo/system_big_fifo_clocks.xdc
  set_property processing_order LATE [get_files /mnt/share/V7_bufh_place_v2_0/V7_bufh_place_v2_0.srcs/sources_1/ip/fifo_generator_v9_3_0/system_big_fifo/system_big_fifo_clocks.xdc]
  link_design -top tdc_front_top -part xc7vx485tffg1761-2
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force tdc_front_top_opt.dcp
  catch {report_drc -file tdc_front_top_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file tdc_front_top.hwdef}
  place_design 
  write_checkpoint -force tdc_front_top_placed.dcp
  catch { report_io -file tdc_front_top_io_placed.rpt }
  catch { report_utilization -file tdc_front_top_utilization_placed.rpt -pb tdc_front_top_utilization_placed.pb }
  catch { report_control_sets -verbose -file tdc_front_top_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force tdc_front_top_routed.dcp
  catch { report_drc -file tdc_front_top_drc_routed.rpt -pb tdc_front_top_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file tdc_front_top_timing_summary_routed.rpt -rpx tdc_front_top_timing_summary_routed.rpx }
  catch { report_power -file tdc_front_top_power_routed.rpt -pb tdc_front_top_power_summary_routed.pb }
  catch { report_route_status -file tdc_front_top_route_status.rpt -pb tdc_front_top_route_status.pb }
  catch { report_clock_utilization -file tdc_front_top_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set src_rc [catch { 
    puts "source /../../../../../home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.runs/impl_2/pre.tcl"
    source /../../../../../home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.runs/impl_2/pre.tcl
  } _RESULT] 
  if {$src_rc} { 
    send_msg_id runtcl-1 error "$_RESULT"
    send_msg_id runtcl-2 error "sourcing script /../../../../../home/skim/tdc_64ch_v2/V7_v2/V7_20151114_hixfer_3/V7_20151114_hixfer_3.runs/impl_2/pre.tcl failed"
    return -code error
  }
  write_bitstream -force tdc_front_top.bit 
  catch { write_sysdef -hwdef tdc_front_top.hwdef -bitfile tdc_front_top.bit -meminfo tdc_front_top.mmi -ltxfile debug_nets.ltx -file tdc_front_top.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

