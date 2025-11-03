set_app_var search_path "../../src_syn_no_always_comb/"
set_app_var synopsys_auto_setup "true"
set_svf "/home/student/ss0443/project/build/dc-syn/my_risc.svf"
#set verification_verify_unread_compare_points true
read_db -technology_library "/apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max.db"
read_db -technology_library "/apps/designlib/SAED90_EDK/SAED_EDK90nm_IO/IO_Standard_Cell_Library/synopsys/models/saed90nm_io_max_fc.db" 
read_db -technology_library "/apps/designlib/SAED90_EDK/SAED_EDK90nm/Memories/synopsys/models/SRAM16x128_max.db"
read_sverilog -r "my_risc_128word.sv" -work_library work
set_top r:/WORK/my_risc
read_ddc -i "./output/my_risc.ddc"
set_top i:/WORK/my_risc
match
report_unmatched_points
verify
report_status > reports/formality_report.rpt
report_failing_points > reports/formality_failing_points.rpt
report_aborted > reports/formality_aborted_points.rpt
quit

