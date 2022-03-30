read_verilog JAM.v
current_design [get_designs JAM]

check_design

# operating conditions and boundary conditions #

set cycle 7
create_clock -name CLK  -period $cycle   [get_ports  CLK] 

set_dont_touch_network      [all_clocks]
set_fix_hold                [all_clocks]
set_clock_uncertainty  0.1  [all_clocks]
set_clock_latency      0.5  [all_clocks]
set_ideal_network           [get_ports CLK]


#Don't touch the basic env setting as below
set_input_delay  0   -clock CLK [remove_from_collection [all_inputs] [get_ports CLK]] -clock_fall
set_output_delay 0    -clock CLK [all_outputs]  -clock_fall

set_load         1   [all_outputs]
set_drive        0.1   [all_inputs]

set_operating_conditions -max_library slow -max slow
set_wire_load_model -name tsmc13_wl10 -library slow                        
set_max_fanout 20 [all_inputs]
                     

#Compile and save files
#You may modified setting of compile 
#####################################################
compile
write_sdf -version 2.1 JAM_syn.sdf
write -format verilog -hier -output JAM_syn.v
write -format ddc     -hier -output JAM_syn.ddc  
#####################################################  

report_timing
report_area -hierarchy   

quit