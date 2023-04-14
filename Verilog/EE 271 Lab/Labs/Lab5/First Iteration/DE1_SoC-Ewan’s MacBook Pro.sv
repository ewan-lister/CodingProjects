// Top-level module that defines the I/Os for the DE-1 SoC board.
// In this lab 
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	output logic  [6:0]    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	output logic  [9:0]    LEDR; 
	input  logic  [3:0]    KEY; 
	input  logic  [9:0] 		SW; 
	
	// Default values, turns off the HEX displays
	/*assign HEX0 = 7'b1111111; 
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111; */
	
	// Logic to check if SW[3]..SW[0] match your bottom digit,
	// and SW[7]..SW[4] match the next.
	// Result should drive LEDR[0].
	
	// This assignment sets the LED to only light up when the switches SW_7 -
	// SW_4 and SW_3 - SW_0 display the values 7 and 9 respectively
	// In other words, 0111 and 1001.
	
	// Accepts switches as UPC M inputs and determines whether an item was discounted
	// and or stolen.
	upc_reader r(.discounted(LEDR[9]), .stolen(LEDR[8]), .u(SW[9]), .p(SW[8]), .c(SW[7]), .m(SW[0]));
	
	seg7 display1(.bcd(SW[9:7]), .leds5(HEX5), .leds4(HEX4), .leds3(HEX3), .leds2(HEX2), .leds1(HEX1), .leds0(HEX0));
	
endmodule

// Testbench for upcs_reader module.
module DE1_SoC_testbench();
		logic [9:0] SW;
		logic LEDR9, LEDR8;
		
		upc_reader dut (.discounted(LEDR9), .stolen(LEDR8), .u(SW[9]), .p(SW[8]), .c(SW[7]), .m(SW[0])
		
		integer i;
		initial begin
				for(i = 0; i < 16; i++) begin
						{SW[9], SW[8], SW[7], SW[0]} = i; #10;
				end
		end
		
endmodule


// Testbench for upcs_reader module.
module DE1_SoC_testbench();
		logic [9:0] SW;
		logic [6:0]    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
		
		seg7 dut (.bits(SW[9:7]), .leds5(HEX5), .leds4(HEX4), .leds3(HEX3), .leds2(HEX2), .leds1(HEX1), .leds0(HEX0));
		
		integer i;
		initial begin
				for(i = 0; i < 16; i++) begin
						{SW[9], SW[8], SW[7], SW[0]} = i; #10;
				end
		end
		
endmodule

	
	
	
	
	
	
	
	
	
	
