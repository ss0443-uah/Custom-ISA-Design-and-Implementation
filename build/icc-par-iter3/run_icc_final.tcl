set_app_var link_library "* /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_max_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_max.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_typ.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_typ_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_typ.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_min.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_min_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_min.db"
set_app_var target_library " /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_typ.db /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_typ_fc.db /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_typ.db"
create_mw_lib -technology "/apps/designlib/SAED90_EDK/SAED_EDK90nm/Technology_Kit/milkyway/saed90nm_icc_1p9m.tf" -mw_reference_library "/apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/process/astro/fram/saed90nm /apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/process/astro/saed_io_fc_fr /apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/process/astro/saed_sram_fr" "my_risc_LIB"
open_mw_lib my_risc_LIB
import_designs "../dc-syn/output/my_risc.ddc" -format "ddc" -top "my_risc" -cel "my_risc"
read_sdc ../dc-syn/output/my_risc_syn.sdc
set_tlu_plus_files -max_tluplus "/apps/designlib/SAED90_EDK/SAED_EDK90nm/Technology_Kit/starrcxt/tluplus/saed90nm_1p9m_1t_Cmax.tluplus" -min_tluplus "/apps/designlib/SAED90_EDK/SAED_EDK90nm/Technology_Kit/starrcxt/tluplus/saed90nm_1p9m_1t_Cmin.tluplus" -tech2itf_map "/apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/process/astro/tech/tech2itf.map"
create_floorplan -core_utilization 0.03 -start_first_row -left_io2core "50" -bottom_io2core "50" -right_io2core "50" -top_io2core "50"
derive_pg_connection -power_net "VDD" -power_pin "VDD" -ground_net "VSS" -ground_pin "VSS" -create_ports "top"
set physopt_hard_keepout_distance 10
set placer_soft_keepout_chanel_width 25
set mw_logic0_net "VSS"
set mw_logic1_net "VDD"
create_rectangular_ring -nets {VSS} -left_offset 0.5 -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 0.5 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 0.5 -bottom_segment_layer M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 0.5 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th
create_rectangular_ring -nets {VDD} -left_offset 1.8 -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 1.8 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 1.8 -bottom_segment_layer M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 1.8 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th
create_power_strap -nets {VSS} -layer M6 -direction vertical -width 3
create_power_strap -nets {VDD} -layer M6 -direction vertical -width 3
create_fp_placement
synthesize_fp_rail -power_budget "1000" -voltage_supply "1.2" -target_voltage_drop "250" -output_dir "./output" -nets "VDD VSS" -create_virtual_rails "M1" -synthesize_power_plan -synthesize_power_pads -use_strap_ends_as_pads
commit_fp_rail
set_undoable_attribute [get_cells -all ram] origin {1200 1200}
set_dont_touch_placement [get_cells -all ram]
place_opt
clock_opt -only_cts -no_clock_route
route_group -all_clock_nets -search_repair_loop "15"
route_opt -initial_route_only
route_opt -skip_initial_route -effort medium -power
insert_stdcell_filler -cell_with_metal "SHFILL2" -connect_to_power "VDD" -connect_to_ground "VSS"
route_opt -incremental -size_only
route_search_repair -rerun_drc -loop "2"
report_placement_utilization > ./output/my_risc_route_util.rpt
report_qor > ./output/my_risc_route_qor.rpt
report_timing -delay max -max_paths 5 > ./output/my_risc_route.setup.rpt
report_timing -delay min -max_paths 5 > ./output/my_risc_route.hold.rpt
change_names -rules verilog -hierarchy
extract_rc -coupling_cap
write_parasitics -format SBPF -output ./output/my_risc.output.sbpf
write_verilog ./output/my_risc_LIB.output.v
write_sdc "./output/my_risc_par.sdc"
save_mw_cel
close_mw_cel
exit
