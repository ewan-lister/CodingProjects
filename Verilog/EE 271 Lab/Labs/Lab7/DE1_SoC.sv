// This module is the top level module for a design which controls a finite state machine
// ignorer to generate different LED pattern cycles. These cycles warn pilots about the
// direction of wind on an airstrip.
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
		input  logic         CLOCK_50; // 50MHz clock.
		output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		output logic  [9:0]  LEDR;
		
		// Key/Buttons are True when not pressed, False when pressed
		input  logic  [3:0]  KEY; 
		input  logic  [9:0]  SW;
		
		// Generate clk off of CLOCK_50, whichClock picks rate/frequency.
		logic p1press, p2press, p1pressn, p2pressn, computermove;
		logic [1:0] move;
		logic reset, fullreset, count, count1, clockshiftreset;
		logic [6:0] winner;
		logic [31:0] div_clk;
		logic [1:0] victory;
		logic [6:0] victor;
		logic [9:0] random;
		
		assign HEX1 = 7'b1111001;
		assign HEX2 = 7'b0001100;
		assign HEX4 = 7'b0100100;
		assign HEX5 = 7'b0001100;
		
		assign fullreset = SW[9];
		// Select 0.75 Hz clock 
		parameter whichClock = 15; 
		/*clock_divider cdiv (.clock(CLOCK_50), 
									.reset(reset),
								  .divided_clocks(div_clk));*/
								  
		// Clock selection; 
		// allows for easy switching between simulation and board clocks 
		logic clkSelect;
		
		// Uncomment ONE of the following two lines depending on intention
		assign clkSelect = CLOCK_50;          // for simulation
		//assign clkSelect = div_clk[whichClock]; // for synthesis on DE1_SoC board
		
		LFSR_10_bit lfsr (.out(random), .reset(reset), .clk(clkSelect));
		
		comp comp10 (.out(computermove), .A(random), .B({1'b0,SW[8:0]}));
		
		d_ff d1 (.q(p1press), .d(KEY[0]), .reset, .clk(clkSelect));
		
		d_ff d2 (.q(p1pressn), .d(p1press), .reset, .clk(clkSelect));
		
		d_ff d3 (.q(p2press), .d(KEY[3]), .reset, .clk(clkSelect));
		
		d_ff d4 (.q(p2pressn), .d(p2press), .reset, .clk(clkSelect));
		
		press_processor p1 (.p1press(computermove), .p2press(p1pressn), .out(move), .reset(reset), .clk(clkSelect));
		
		led_normal led9 (.l(1'b0), .r(LEDR[8]), .move, .out(LEDR[9]), .reset(reset), .clk(clkSelect));
		
		led_normal led8 (.l(LEDR[9]), .r(LEDR[7]), .move, .out(LEDR[8]), .reset(reset), .clk(clkSelect));
		
		led_normal led7 (.l(LEDR[8]), .r(LEDR[6]), .move, .out(LEDR[7]), .reset(reset), .clk(clkSelect));
		
		led_normal led6 (.l(LEDR[7]), .r(LEDR[5]), .move, .out(LEDR[6]), .reset(reset), .clk(clkSelect));
		
		led5 led5 (.l(LEDR[6]), .r(LEDR[4]), .move, .out(LEDR[5]), .reset(reset), .clk(clkSelect));
		
		led_normal led4 (.l(LEDR[5]), .r(LEDR[3]), .move, .out(LEDR[4]), .reset(reset), .clk(clkSelect));
		
		led_normal led3 (.l(LEDR[4]), .r(LEDR[2]), .move, .out(LEDR[3]), .reset(reset), .clk(clkSelect));
		
		led_normal led2 (.l(LEDR[3]), .r(LEDR[1]), .move, .out(LEDR[2]), .reset(reset), .clk(clkSelect));
		
		led_normal led1 (.l(LEDR[2]), .r(1'b0), .move, .out(LEDR[1]), .reset(reset), .clk(clkSelect));
		
		victory test2 (.l(LEDR[9]), .r(LEDR[1]), .move, .out(victor), .reset(reset), .clk(clkSelect));
		
		always @(posedge clkSelect) begin
					if (~(HEX3 == 7'b1111000 || HEX0 == 7'b1111000) && reset == 0) begin
								if (victor == 7'b1111001) victory = 2'b01;
								else if (victor == 7'b0100100) victory = 2'b10;
								else victory = 2'b00;
					end
					else victory = 2'b00;
					
					if (victor != 7'b1111111) reset = 1;
					else reset = 0;
					
					
					//if (reset == 1) clockshiftreset = 1;
					//else clockshiftreset = 0;
					
					if (fullreset == 1) reset = 1;
		end
			
		winner w1 (.victories(victory[0]), .out(HEX3), .reset(fullreset), .clk(clkSelect));
		winner w2 (.victories(victory[1]), .out(HEX0), .reset(fullreset), .clk(clkSelect));
endmodule

module DE1_SoC_testbench();
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
			  SW[9] = 1; 								 		@(posedge CLOCK_50); // Always reset FSMs at start
					SW[9] = 1; KEY[3] = 1; KEY[0] = 0; 	@(posedge CLOCK_50);
					SW[9] = 0;									@(posedge CLOCK_50); // Test case 1: input is 0
																	@(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
																	@(posedge CLOCK_50);
																	@(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
																	@(posedge CLOCK_50);
				KEY[3] = 1; KEY[0] = 1; 				 	@(posedge CLOCK_50); // Always reset FSMs at start
																	@(posedge CLOCK_50);
				KEY[3] = 0; KEY[0] = 0;	  					@(posedge CLOCK_50); // Test case 1: input is 0
																	@(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
				KEY[3] = 1;								  	  	@(posedge CLOCK_50);
				KEY[3] = 1;										@(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
				KEY[3] = 0;										@(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Always reset FSMs at start
					  @(posedge CLOCK_50);
				KEY[3] = 1;								  	  	@(posedge CLOCK_50);
				KEY[3] = 1;										@(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
				KEY[3] = 0;										@(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 1: input is 0
					  @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					  @(posedge CLOCK_50);
				KEY[3] = 1;								  	  	@(posedge CLOCK_50);
				KEY[3] = 1;										@(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
				KEY[3] = 0;										@(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Always reset FSMs at start
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 1: input is 0
					  @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
				KEY[0] = 1;								  	  	@(posedge CLOCK_50);
				KEY[0] = 1;										@(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
				KEY[0] = 0;										@(posedge CLOCK_50);
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Always reset FSMs at start
					  @(posedge CLOCK_50);
				KEY[3] = 1;								  	  	@(posedge CLOCK_50);
				KEY[3] = 1;										@(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
				KEY[3] = 0;										@(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 1: input is 0
					  @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					  @(posedge CLOCK_50);
				KEY[3] = 1;								  	  	@(posedge CLOCK_50);
				KEY[3] = 1;										@(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
				KEY[3] = 0;										@(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Always reset FSMs at start
				KEY[3] = 1; @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 1: input is 0
					  @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
					  @(posedge CLOCK_50);
				KEY[3] = 0;								  	  	@(posedge CLOCK_50);
				KEY[3] = 0;										@(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
				KEY[3] = 1;										@(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Always reset FSMs at start
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 1: input is 0
					  @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Always reset FSMs at start
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 1: input is 0
					  @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Always reset FSMs at start
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 1: input is 0
					  @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Always reset FSMs at start
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 1: input is 0
					  @(posedge CLOCK_50); // Test case 2: input 1 for 1 cycle
					  @(posedge CLOCK_50);
					  @(posedge CLOCK_50); // Test case 3: input 1 for >2 cycles
					  @(posedge CLOCK_50);
					$stop; // End the simulation.
			end 
endmodule


