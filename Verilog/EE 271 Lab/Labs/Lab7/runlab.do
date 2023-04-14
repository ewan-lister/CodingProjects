# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DE1_SoC.sv"
vlog "./d_ff.sv"
vlog "./press_processor.sv"
vlog "./led_normal.sv"
vlog "./led_5.sv"
vlog "./victory.sv"
vlog "./clock_divider.sv"
vlog "./LFSR_10_bit.sv"
vlog "./comp.sv"
vlog "./winner.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work LFSR_10_bit_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do LFSR_10_bit_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
