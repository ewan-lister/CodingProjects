// This module checks whether the flappy
// bird has passed through a pipe pair safely
// is between pipes, or has collided with one.
// Inputs: pos (flappy bird position), GrnPixels, CLK, RST.
// Outputs: result, 2 bit value, first bit signifies
// whether or not flappy bird has hit a pipe (0) or is flying freely (1)
// second bit signifies whether flappy bird is in an open vertical space (1)
// or in column occupied by pipes (0).
module collision_checker(result, pos, GrnPixels, CLK, RST);


			input logic [4:0] pos;
			input logic CLK, RST;
			input logic [15:0][15:0] GrnPixels;
			output logic [1:0] result;

			// At every positive clock edge, checks if a collision has happened,
			// flappy bird has crossd through a gate successfully, or is moving throu
			// open air.
			always_ff @(posedge CLK) begin
					
					if (GrnPixels[15][6] == 1'b0) result[0] = 1;
					else result[0] = 0;
					
					if (GrnPixels[pos][6] == 0) result[1] = 1;
					else result[1] = 0;
			end
endmodule

module collision_checker_testbench();

		logic CLK, RST;
		logic [15:0][15:0] GrnPixels;
		logic [4:0] pos;
		logic [1:0] result;
		
		collision_checker dut (result, pos, GrnPixels, CLK, RST);
		
		parameter CLOCK_PERIOD=100;
			initial begin
						CLK <= 0;
						forever #(CLOCK_PERIOD/2) CLK <= ~CLK;//toggle the clock indefinitely
			end 
   
			// Set up the inputs to the design.  Each line represents a clock cycle 
			// Simulation sends the state machine into all 7 possible states
		initial begin
							RST = 1;									@(posedge CLK);			
							pos = 6;	GrnPixels = 0;								@(posedge CLK);// pos = 7
							RST = 1;									@(posedge CLK);
							RST = 0;									@(posedge CLK);// pos = 7
																@(posedge CLK);//pos= 7
							GrnPixels[15] = 16'b1111111111111111;
							GrnPixels[9] = 16'b1111111111111111;									@(posedge CLK);//pos= 8
																@(posedge CLK);//pos= 9
																@(posedge CLK);//pos= 10
																@(posedge CLK);// pos = 11
							GrnPixels[15][6] = 0;									@(posedge CLK);//pos=12
																@(posedge CLK);//pos= 13
																@(posedge CLK);//pos= 14
							GrnPixels[15][6] = 1;									@(posedge CLK);//pos= 15
																@(posedge CLK);
																@(posedge CLK);
																@(posedge CLK);//pos= 0
																@(posedge CLK);//pos= 7
																@(posedge CLK);//pos= 6
																@(posedge CLK);//pos= 5
																@(posedge CLK);//pos= 4
							pos = 7;									@(posedge CLK);//pos= 2
							pos = 8;									@(posedge CLK);// pos = 1
							pos = 9;									@(posedge CLK);//pos= 0;
																@(posedge CLK);
																@(posedge CLK);
																@(posedge CLK);// pos = 2
																@(posedge CLK);// pos = 4
																@(posedge CLK);// pos = 6
																@(posedge CLK);// pos = 8
																@(posedge CLK);// pos = 10
																@(posedge CLK);// pos = 12
																@(posedge CLK);// pos = 14
																@(posedge CLK);// pos = 15
																@(posedge CLK);
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

			