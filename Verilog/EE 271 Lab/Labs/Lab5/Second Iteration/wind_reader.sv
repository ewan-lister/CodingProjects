//This module describes the states and transitions associated with the state machine
//State machine has three inputs (clock, reset, bits), one output, and four states.
module wind_reader (clk, reset, bits, out); 
      input  logic  clk, reset;
		input  logic [1:0] bits;
		output logic  [2:0] out;
		//Present (ps) and Next (ns) states can be one of four options
		enum logic [2:0] { b101 = 3'b101, b010 = 3'b010, b100 = 3'b100, b001 = 3'b001 } ps, ns; 
		// This logic describes all the possible state transitions from ps to ns
		
		// State machine moves through different cycles of states depending on input bits.
		// e.g "bits = 2'b00" --> 101-010-101-010
		always_comb begin
					case (ps)
								b101: if (bits == 2) ns = b100; // transition if wind is left-to-right
										else if (bits == 1) ns = b001; // transition if wind is right-to-left
										else if (bits == 0) ns = b010; // transition if wind is calm 
										else ns = b101;					 // no transition is bits = 2'b11
								b010: if (bits == 2) ns = b001;				// Conditional cycle repeated in each branch.
										else if (bits == 1) ns = b100; //		|
										else if (bits == 0) ns = b101; //		|
										else ns = b010;		     //		|
								b100: if (bits == 2) ns = b010;		     //		|
										else if (bits == 1) ns = b001;//		|
										else if (bits == 0) ns = b101;//		|
										else ns = b100;		     //	        \/
								b001: if (bits == 2) ns = b100;
										else if (bits == 1) ns = b010;
										else if (bits == 0) ns = b101;
										else ns = b001;
					endcase
		end
		
		// Output logic - could also be implemented as another always_comb block
		// Output is set to bit value of present state.
		assign out = ps;
		// D Flip Flop implementation (DFFs)
		always_ff @(posedge clk) begin
					if (reset)
								ps <= b101; //Returns to b101 state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state in state diagram
		end
endmodule


//Test/Simulate the State Machine
module wind_reader_testbench();
			logic  clk, reset;
			logic [1:0] bits;
			logic  [2:0] out;
			wind_reader dut (clk, reset, bits, out);
			// Set up a simulated clock to toggle (from low to high or high to low)
			// every 50 time steps
			parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
			end 
   
			// Set up the inputs to the design.  Each line represents a clock cycle 
			// Simulation sends the state machine into all four possible states
			initial begin
																@(posedge clk);
						 reset <= 1;    					@(posedge clk); // Always reset FSMs at start
						reset <= 0; bits <= 2'b00;  	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
										bits <= 2'b01; 	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
										bits <= 2'b10;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
										bits <= 2'b11;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
										bits <= 2'b00;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
			$stop; // End the simulation.
	end
endmodule

