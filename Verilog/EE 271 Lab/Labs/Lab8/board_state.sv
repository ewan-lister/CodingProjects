// Module determines the present board
// state of the flappy bird game,
// both to be displayed via the LED array
// as well as checked by a collision checker.
// Inputs: CLK, RST, pos (postion of flappy bird),
// pipe (new randomly generated pipe).
// Outputs: RedPixels (full 256 bit array of red pixels), GrnPixels (full 256 array of green pixels).

module board_state(RedPixels, GrnPixels, pos, pipe, CLK, RST);

			input logic CLK, RST;
			input logic [3:0] pos;
			input logic [15:0] pipe;
			
			output logic [15:0][15:0] RedPixels, GrnPixels;
		
			logic [15:0][15:0] pRPs, nRPs;
			logic [15:0][15:0] pGPs, nGPs; 
			
			integer i;
			integer j;
			
			integer x;
			integer y;
			
			integer counter;
			assign RedPixels = pRPs;
			assign GrnPixels = pGPs;
			
			always_comb begin
			
						// This block loads new pipe geometries into the 16th column of the green
						// every four clock cycles, and shifts ns one column to the right.
						for (x = 0; x < 16; x++) begin
								for (y = 0; y < 16; y++) begin
									if (y == 15 && x < 16 && y < 16) begin
										if (counter % 4 == 0) nGPs[x][15] = pipe[x];
										else nGPs[x][y] = 0;
									end
									else nGPs[x][y] <= pGPs[x][y + 1];
								end
						end
			
						// This block initializes a single red pixel as lit to whatever the flappy
						// birds vertical position is. In addition, it lights a green pixel in the
						// same spot.			
						for (x = 0; x < 16; x++) begin
								for (y = 0; y < 16; y++) begin
										if (x == pos && y == 8) begin
											nRPs[x][y] <= 1;
										end
										else nRPs[x][y] <= 0;
								end
						end
					
			end
			
			always_ff @(posedge CLK) begin
					if (RST) begin
							counter = 0;
							for (i = 0; i < 16; i++) begin
								for (j = 0; j < 16; j++)
									if (i < 16 && j < 16) begin
									pGPs[i][j] <= 0;
									pRPs[i][j] <= 0;
									end
						end
					end
					
					else

						for (i = 0; i < 16; i++) begin
								for (j = 0; j < 16; j++)
									if (i < 16 && j < 16) begin
									pGPs[i][j] <= nGPs[i][j];
									pRPs[i][j] <= nRPs[i][j];
									end
						end
						
						counter <= counter + 1;
		end
endmodule

module board_state_testbench();

		logic CLK, RST;
		logic [15:0][15:0] RedPixels, GrnPixels;
		logic [3:0] pos;
		logic [15:0] pipe;
		
		board_state dut (RedPixels, GrnPixels, pos, pipe, CLK, RST);
		
		parameter CLOCK_PERIOD=100;
			initial begin
						CLK <= 0;
						forever #(CLOCK_PERIOD/2) CLK <= ~CLK;//toggle the clock indefinitely
			end 
   
			// Set up the inputs to the design.  Each line represents a clock cycle 
			// Simulation sends the state machine into all 7 possible states
		initial begin
							RST = 1;									@(posedge CLK);			
							pos = 6; pipe = 16'b1111110011111111;									@(posedge CLK);// pos = 7
							RST = 1;									@(posedge CLK);
							RST = 0;									@(posedge CLK);// pos = 7
																@(posedge CLK);//pos= 7
																@(posedge CLK);//pos= 8
																@(posedge CLK);//pos= 9
																@(posedge CLK);//pos= 10
																@(posedge CLK);// pos = 11
																@(posedge CLK);//pos=12
																@(posedge CLK);//pos= 13
																@(posedge CLK);//pos= 14
																@(posedge CLK);//pos= 15
							pipe = 16'b1111000011111111;									@(posedge CLK);
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
		
		
		
		
		
