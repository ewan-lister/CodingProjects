// This module determines the velocity
// of the flappy bird.
// Inputs: UserInput -- 1 if flappy bird should travel up
// and 0 if flappy bird should fall down.
// Inputs: CLK, RST.
// Outputs: velocity, as a binary value between -3 and 3

module kinematics(velocity, UserInput, CLK, RST);
		
		
		output logic [2:0] velocity; // Velocity is in signed regular binary form
		input logic UserInput, CLK, RST;
		
		enum logic [2:0] {zero = 3'sb000, one = 3'sb001, two = 3'sb010, three = 3'sb011,
								none = 3'sb111, ntwo = 3'sb110, nthree = 3'sb101} ps, ns;
								
		// ps represents present velocity of flappy bird, an input of 1 to a positive
		// velocity will cause the velocity to increase (limited to 3 pixels/second).
		// an input of 0 will reset the velocity to 0 when ps = positive.
		// an input of 1 to a negative velocity will also increase its magnitude, and
		// a 1 would reset the negative velocity to 0.
		always_comb begin
					case (ps)
									zero:	if (UserInput) ns = one;
											else ns = none;
									one:	if (UserInput) ns = two;
											else ns = zero;
									two:	if (UserInput) ns = three;
											else ns = zero;
									three:if (UserInput) ns = three;
											else ns = zero;
									none:	if (UserInput) ns = zero;
											else ns = ntwo;
									ntwo: if (UserInput) ns = zero;
											else ns = nthree;
									nthree:if(UserInput) ns = zero;
											else ns = nthree;
								
					endcase
		end
		
		// Output logic - could also be implemented as another always_comb block
		// Output is set to bit value of present state.
		assign velocity = ps;
		// D Flip Flop implementation (DFFs)
		always_ff @(posedge CLK) begin
					if (RST)
								ps <= zero; //Returns to 0 pixel/s state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state
		end
		
endmodule


// Simulation testbench for kinematics module.
module kinematics_testbench();

		logic UserInput, CLK, RST;
		logic [2:0] velocity;
		
		kinematics dut (velocity, UserInput, CLK, RST);
		
		
		parameter CLOCK_PERIOD=100;
			initial begin
						CLK <= 0;
						forever #(CLOCK_PERIOD/2) CLK <= ~CLK;//toggle the clock indefinitely
			end 
   
			// Set up the inputs to the design.  Each line represents a clock cycle 
			// Simulation sends the state machine into all 7 possible states
			initial begin
							RST = 1;									@(posedge CLK);			
							UserInput = 1;									@(posedge CLK);// v = 0
							RST = 0;									@(posedge CLK);
																@(posedge CLK);// v = 1
																@(posedge CLK);// v = 2
																@(posedge CLK);// v = 3
																@(posedge CLK);// v = 3
																@(posedge CLK);// v = 3
							UserInput = 0;									@(posedge CLK);
																@(posedge CLK);// v = 0
							UserInput = 1;					@(posedge CLK);// v = -1
																@(posedge CLK);// v = 0
							UserInput = 0;					@(posedge CLK);// v = 1
																@(posedge CLK);// v = 0
																@(posedge CLK);// v = -1
																@(posedge CLK);// v = -2
																@(posedge CLK);// v = -3
																@(posedge CLK);// v = -3
																@(posedge CLK);// v = -3
							UserInput = 1;									@(posedge CLK);
																@(posedge CLK);// v = 0;
																@(posedge CLK);
																@(posedge CLK);

			$stop; // End the simulation.
	end
endmodule

		
		
		
		
		
		
		
		
		
		
		