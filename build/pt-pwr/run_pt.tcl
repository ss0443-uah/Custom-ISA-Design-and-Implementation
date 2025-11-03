set target_library "/apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_max_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_max.db"
set link_path "* /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_max_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_max.db"
set power_enable_analysis "true"
read_verilog "../icc-par-iter3/output/my_risc_LIB.output.v"
current_design "my_risc"
link
read_saif "../vcs-post-par/inter.bsaif" -strip_path "test_bench3/dut"
report_switching_activity -list_not_annotated
read_parasitics -increment -format sbpf "../icc-par-iter3/output/my_risc.output.sbpf.max"
update_power 
report_power -verbose -hierarchy
report_power -verbose -hierarchy > pwr_average.rpt
set power_analysis_mode "time_based"
read_vcd "../vcs-post-par/inter.vcd" -strip_path "test_bench3/dut"
report_switching_activity -list_not_annotated
read_parasitics -increment -format sbpf "../icc-par-iter3/output/my_risc.output.sbpf.max"
report_power -verbose -hierarchy
report_power -verbose -hierarchy > power_timebased.rpt
quit

