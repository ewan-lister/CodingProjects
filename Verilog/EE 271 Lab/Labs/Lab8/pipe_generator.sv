// This module randomly generates
// pipes of a random height and opening size.
// Height never goes above the highest and lowest three pixels
// of the board. Opening size is never below 2 or above 5.
// Inputs: CLK, RST, 10 bit random number.
// Outputs: a 16 bit array representing the geometry of a pipe pair
// and opening.

module pipe_generator(pipe, number, CLK, RST);

		input logic CLK, RST;
		input logic [9:0] number;
		output logic [15:0] pipe;
		logic [15:0] layout; // used to load geometry of pipe pair into output.
		
		
		integer opening;
		integer height;
		
		// takes random 10 bit number and calculates its modulus, which should
		// also be approximately random, uses modulo 4 to establish opening,
		// and modulo 11 to establish height.
		always @(number) begin
				if (number % 5 >= 2) opening = number % 5;
				else opening = 2;
				
				height = number % 10;
		end
		
		integer i;
		
		// alway_ff block triggers on positive edge of clock, sets
		// pipe array to have a space with width "opening" and
		// position of space equal to "height".
		always_ff @(posedge CLK) begin
					for (i = 0; i < 16;i++) begin
						
							if (height >= 6) begin
								if (i <= 3 + height && i > 3 + height - opening) layout[i] = 1'b0;
								else layout[i] = 1'b1;	
							end
							else begin
								if (i >= 3 + height && i < 3 + height + opening) layout[i] = 1'b0;
								else layout[i] = 1'b1;
							end
					end
					
					if (RST)
								layout <= 16'b11111100111111;
					else
								pipe <= layout; 
		end
		
endmodule


// simulates pipe behavior through ascending sequence of 10 bit numbers.
module pipe_generator_testbench();

		logic CLK, RST;
		logic [15:0] pipe;
		logic [9:0] number;
		
		pipe_generator dut (pipe, number, CLK, RST);
		
		parameter CLOCK_PERIOD=100;
		initial begin
						CLK <= 0;
						forever #(CLOCK_PERIOD/2) CLK <= ~CLK;//toggle the clock indefinitely
		end
		
		integer i;
		initial begin 
				RST = 1; @(posedge CLK);
				RST = 0; @(posedge CLK);
				for(i = 0; i < 1024; i++) begin
						number = i; @(posedge CLK);
				end
			$stop;
		end
		
endmodule

		
		
		
		
		
		
		