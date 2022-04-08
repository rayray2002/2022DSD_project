read_verilog GSIM.v
current_design [get_designs GSIM]

check_design

# operating conditions and boundary conditions #

set cycle  4         ;#clock period defined by designer

create_clock -period $cycle [get_ports  clk]
set_dont_touch_network      [get_clocks clk]
set_clock_uncertainty  0.1  [get_clocks clk]
set_clock_latency      0.5  [get_clocks clk]

set_input_delay  1      -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 0.5    -clock clk [all_outputs] 
set_load         1     [all_outputs]
set_drive        1     [all_inputs]

set_operating_conditions -min_library fast -min fast  -max_library slow -max slow
set_wire_load_model -name tsmc13_wl10 -library slow                        

set_max_fanout 20 [all_inputs]

#Compile and save files
#You may modified setting of compile 
#####################################################
compile
write_sdf -version 2.1 GSIM_syn.sdf
write -format verilog -hier -output GSIM_syn.v
write -format ddc     -hier -output GSIM_syn.ddc  
#####################################################  

report_timing
report_area -hierarchy   

quit
