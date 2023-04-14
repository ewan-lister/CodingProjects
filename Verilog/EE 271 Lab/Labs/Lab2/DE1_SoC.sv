// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	output logic  [6:0]    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	output logic  [9:0]    LEDR; 
	input  logic  [3:0]    KEY; 
	input  logic  [9:0] 		SW; 
	
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111; 
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	// Logic to check if SW[3]..SW[0] match your bottom digit,
	// and SW[7]..SW[4] match the next.
	// Result should drive LEDR[0].
	
	// This assignment sets the LED to only light up when the switches SW_7 -
	// SW_4 and SW_3 - SW_0 display the values 7 and 9 respectively
	// In other words, 0111 and 1001.

	netidreader1 netid(.bits(SW[7:0]), .leds(LEDR[0]));
endmodule


module upc_testbench();
	logic [7:0] SWS;
	logic LEDR0;
	
	netidreader1 dut (.bits(SW), .leds(LEDR0));
	integer i;
	initial begin
			for(i = 0; i < 256; i++) begin
					{SWS[7], SWS[6], SWS[5], SWS[4], SWS[3], SWS[2], SWS[1], SWS[0]} = i; #10;
			end
	end
endmodule
