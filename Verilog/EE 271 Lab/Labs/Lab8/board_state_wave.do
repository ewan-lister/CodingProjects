onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /board_state_testbench/pos
add wave -noupdate /board_state_testbench/pipe
add wave -noupdate /board_state_testbench/CLK
add wave -noupdate /board_state_testbench/RST
add wave -noupdate /board_state_testbench/RedPixels
add wave -noupdate /board_state_testbench/GrnPixels
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3507 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {3100 ps} {3744 ps}
