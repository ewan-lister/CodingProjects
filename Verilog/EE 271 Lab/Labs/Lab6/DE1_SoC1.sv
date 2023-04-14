module DE1_SoC1 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
		input  logic         CLOCK_50; // 50MHz clock.
		output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		output logic  [9:0]  LEDR;
		
		// Key/Buttons are True when not pressed, False when pressed
		input  logic  [3:0]  KEY; 
		input  logic  [9:0]  SW;
  
		// Generate clk off of CLOCK_50, whichClock picks rate/frequency.
   
		logic reset;
		logic [31:0] div_clk;
		assign reset = SW[9];
		// Select 0.75 Hz clock 
		parameter whichClock = 25; 
		clock_divider cdiv (.clock(CLOCK_50), 
									.reset(reset),
                          .divided_clocks(div_clk)); 
		// Clock selection; 
		// allows for easy switching between simulation and board clocks 
		logic clkSelect;
		// Uncomment ONE of the following two lines depending on intention
		//assign clkSelect = CLOCK_50;          // for simulation
		assign clkSelect = div_clk[whichClock]; // for synthesis on DE1_SoC board
				 
		// Set up FSM inputs and outputs.
		logic w, out;
		assign w = SW[0];   // input is SW[0]
		simple s (.clk(clkSelect), .reset, .w, .out);
			 
		// Show signals on LEDRs to observe how the FSM is behaving
			 assign LEDR[9] = clkSelect;
			 assign LEDR[8] = reset;
			 assign LEDR[0] = out;
endmodule

module DE1_SoC1_testbench();
     logic         CLOCK_50;
     logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
     logic  [9:0]  LEDR;
     logic  [3:0]  KEY;
     logic  [9:0]  SW;
    
		DE1_SoC dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
		// Set up a simulated clock.
		parameter CLOCK_PERIOD=100;
		
		initial begin
			CLOCK_50 <= 0;
			// Forever toggle the clock
			forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
		end
		
		// Test the design.
		initial begin
		repeat(1) @(posedge CLOCK_50);
					 SW[9] <= 1; repeat(1) @(posedge CLOCK_50); // Always reset FSMs at start
					 SW[9] <= 0; repeat(1) @(posedge CLOCK_50);
					 SW[0] <= 0; repeat(4) @(posedge CLOCK_50); // Test case 1: input is 0
					 SW[0] <= 1; repeat(1) @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
					 SW[0] <= 0; repeat(1) @(posedge CLOCK_50);
					 SW[0] <= 1; repeat(4) @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					 SW[0] <= 0; repeat(2) @(posedge CLOCK_50);
					 $stop; // End the simulation.
		end 
endmodule 