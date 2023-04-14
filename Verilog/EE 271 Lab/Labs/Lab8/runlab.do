# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DE1_SoC.sv"
vlog "./kinematics.sv"
vlog "./position.sv"
vlog "./pipe_generator.sv"
vlog "./board_state.sv"
vlog "./LFSR_10_bit.sv"
vlog "./collision_checker.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work collision_checker_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do collision_checker_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
