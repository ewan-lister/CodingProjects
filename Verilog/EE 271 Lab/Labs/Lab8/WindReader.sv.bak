//This module describes the states and transitions associated with the state machine
//State machine has three inputs (clock, reset, w), one output, and three states
module simple (clk, reset, w, out); 
      input  logic  clk, reset, w; 
		output logic  out;
		//Present (ps) and Next (ns) states can be one of three options
		enum {none, got_one, got_two} ps, ns; 
		// This logic describes all the possible state transitions from ps to ns
		always_comb begin
					case (ps)
								none: if (w) ns = got_one;
										else ns = none;
								got_one: if (w) ns = got_two;
										else ns = none;
								got_two: if (w) ns = got_two;
											else ns = none;
					endcase
		end
		// Output logic - could also be implemented as another always_comb block
		// Output is high whenever the present state is got_two and 0 otherwise
		assign out = (ps == got_two);
		// D Flip Flop implementation (DFFs)
		always_ff @(posedge clk) begin
					if (reset)
								ps <= none; //Returns to none state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state in state diagram
		end
endmodule


//Test/Simulate the State Machine
module simple_testbench();
			logic  clk, reset, w;
			logic  out;
			simple dut (clk, reset, w, out);
			// Set up a simulated clock to toggle (from low to high or high to low)
			// every 50 time steps
			parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
			end 
   
			// Set up the inputs to the design.  Each line represents a clock cycle 
			// Simulation sends the state machine into all three possible states
			initial begin
													@(posedge clk);
						 reset <= 1;    		@(posedge clk); // Always reset FSMs at start
						reset <= 0; w <= 0;  @(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
										w <= 1; 	@(posedge clk);
										w <= 0; 	@(posedge clk);
										w <= 1; 	@(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
										w <= 0;  @(posedge clk);
													@(posedge clk);
			$stop; // End the simulation.
	end
endmodule

