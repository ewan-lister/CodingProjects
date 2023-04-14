onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipe_generator_testbench/CLK
add wave -noupdate /pipe_generator_testbench/RST
add wave -noupdate /pipe_generator_testbench/pipe
add wave -noupdate /pipe_generator_testbench/number
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {101600 ps} {102027 ps}
