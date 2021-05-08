# Artix7 xdc
# define clock and period
create_clock -period 13.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# Create a virual clock for IO constraints
create_clock -period 13.000 -name virtual_clock

# input delay
#set_input_delay -clock clk -max 2.0 [get_ports reset]
#set_input_delay -clock clk -min 1.0 [get_ports reset]

#set_input_delay -clock virtual_clock -max 2.0 [get_ports start]
#set_input_delay -clock virtual_clock -min 1.0 [get_ports start]

#set_input_delay -clock virtual_clock -max 2.0 [get_ports sw[*]]  
#set_input_delay -clock virtual_clock -min 1.0 [get_ports sw[*]]

#set_input_delay -clock virtual_clock -max 2.0 [get_ports B[*]]
#set_input_delay -clock virtual_clock -min 1.0 [get_ports B[*]]

#output delay
set_output_delay -clock virtual_clock -2.0 [get_ports led[*]]
set_output_delay -clock virtual_clock -3.5 [get_ports seg[*]]
set_output_delay -clock virtual_clock -2.0 [get_ports an[*]]