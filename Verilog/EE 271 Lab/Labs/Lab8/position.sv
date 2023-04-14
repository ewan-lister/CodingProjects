// This module calculates the position
// of the flappy bird using an FSM.
// Inputs: CLK, RST, velocity of flappy bird three bit
// signed integer.
// Outputs: Flappy Bird's present position, as a 4 bit
// value

module position(pos, velocity, CLK, RST);

		input logic CLK, RST;
		input logic [2:0] velocity;
		output logic [3:0] pos;
		
		integer vel; // signed integer form of velocity
		
		// performs conversion from two's complement to signed integer.
		always @(velocity)
			if (velocity[2] == 1) vel = -(4 - velocity[1:0]);
			else vel = velocity;
		
		logic [3:0] ns, ps;
		
		// ps represents present position of flappy bird within a 16 pixel column, 
		// if the flappy birds velocity is negative, then within one clock cycle
		// flappy bird will travel down by the magnitude of the velocity.
		// If positive, flappy bird will travel up by it's velocity's magnitude in
		// pixels. e.g velocity = 010 = 2 -- flappy bird travels up two pixels per
		// clock cycle.
		always_comb begin
					if (ps + vel > 15) ns = 4'b1111;
					else if (ps + vel < 0) ns = 0;
					else ns = ps + vel;
					/*case (velocity[2])
									
									1'b0: if (ps + velocity[1:0] < 16) ns = (integer)ps + (integer)velocity[1:0];
											else ns = fifteen;
									
									1'b1: if (ps - velocity[1:0] > -1) ns = ps - velocity[1:0];
											else ns = 0;
								
					endcase */
		end
		
		// Output logic - could also be implemented as another always_comb block
		// Output is set to bit value of present state.
		assign pos = ps;
		// D Flip Flop implementation (DFFs)
		always_ff @(posedge CLK) begin
					if (RST)
								ps <= 4'b0111; //Returns to 0 pixel/s state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state
		end
		
endmodule

module position_testbench();


		logic CLK, RST;
		logic [2:0] velocity;
		logic [3:0] pos;
		
		position dut (pos, velocity, CLK, RST);
		
		
		parameter CLOCK_PERIOD=100;
			initial begin
						CLK <= 0;
						forever #(CLOCK_PERIOD/2) CLK <= ~CLK;//toggle the clock indefinitely
			end 
   
			// Set up the inputs to the design.  Each line represents a clock cycle 
			// Simulation sends the state machine into all 7 possible states
			initial begin
							RST = 1;									@(posedge CLK);			
							velocity = 3'b000;									@(posedge CLK);// pos = 7
							RST = 0;									@(posedge CLK);
																@(posedge CLK);// pos = 7
							velocity = 3'b001;			@(posedge CLK);//pos= 7
																@(posedge CLK);//pos= 8
																@(posedge CLK);//pos= 9
																@(posedge CLK);//pos= 10
																@(posedge CLK);// pos = 11
																@(posedge CLK);//pos=12
																@(posedge CLK);//pos= 13
																@(posedge CLK);//pos= 14
																@(posedge CLK);//pos= 15
																@(posedge CLK);
																@(posedge CLK);
							velocity = 3'b111;	@(posedge CLK);//pos= 0
							RST = 0;									@(posedge CLK);//pos= 7
																@(posedge CLK);//pos= 6
																@(posedge CLK);//pos= 5
																@(posedge CLK);//pos= 4
																@(posedge CLK);//pos= 2
																@(posedge CLK);// pos = 1
																@(posedge CLK);//pos= 0;
																@(posedge CLK);
							velocity = 3'b010;			@(posedge CLK);
																@(posedge CLK);// pos = 2
																@(posedge CLK);// pos = 4
																@(posedge CLK);// pos = 6
																@(posedge CLK);// pos = 8
																@(posedge CLK);// pos = 10
																@(posedge CLK);// pos = 12
																@(posedge CLK);// pos = 14
																@(posedge CLK);// pos = 15
							velocity = 3'b101;				@(posedge CLK);
																@(posedge CLK);// pos = 12
																@(posedge CLK);// pos = 9
																@(posedge CLK);// pos = 6
																@(posedge CLK);// pos = 3
																@(posedge CLK);// pos = 0
																@(posedge CLK);
																@(posedge CLK);


																

			$stop; // End the simulation.
	end
endmodule


