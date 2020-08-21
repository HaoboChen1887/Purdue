# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {counter.sv flex_counter.sv controller.sv sync_low.sv magnitude.sv fir_filter.sv}
elaborate fir_filter -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW
 create_clock "clk" -name "clk" -period 9

# Step 3: Compile the design
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/fir_filter.rep
report_area >> reports/fir_filter.rep
report_power -hier >> reports/fir_filter.rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/fir_filter.v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
