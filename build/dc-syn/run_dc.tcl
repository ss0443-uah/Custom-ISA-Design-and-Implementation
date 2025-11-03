lappend search_path ../../src_syn_no_always_comb/
define_design_lib WORK -path work
set link_library [list /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_max_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_max.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_typ.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_typ_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_typ.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_min.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_min_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_min.db]
set target_library [list /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_max_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_max.db]
source /home/student/ss0443/project/build/dc-syn/dc_tech-saed90nm.tcl
set_svf "my_risc.svf"
analyze -library WORK -format sverilog "my_risc_128word.sv"
elaborate -architecture verilog -library WORK "my_risc"
link
create_clock Iclk -name ideal_clock1 -period 200
set_input_delay 2.0 [ remove_from_collection [all_inputs] Iclk]
set_output_delay 2.0 [all_outputs]
set_clock_uncertainty -setup 2 Iclk
compile -map_effort medium -area_effort medium
check_design
set_svf "my_risc.svf"
report_timing -transition_time -nets -attributes -nosplit > reports/my_risc_timing.rpt
report_power -nosplit -hier > reports/my_risc_power.rpt
report_timing_requirements -ignored > reports/my_risc_timing_req.rpt
report_qor  > reports/my_risc_qor.rpt
report_constraints > reports/my_risc_constraints.rpt
report_hierarchy > reports/my_risc_hierarchy.rpt
report_resources > reports/my_risc_resources.rpt
report_reference > reports/my_risc_reference.rpt
change_names -rules verilog -hierarchy
write -format ddc -hierarchy -output output/my_risc.ddc
write -f verilog -hierarchy -output output/my_risc_syn.sv
write_sdc -version 2.1 -nosplit output/my_risc_syn.sdc
write_sdf output/my_risc_syn.sdf
quit
