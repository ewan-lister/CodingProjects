// This module determines how victory between
// players is established and displayed on the
// board.
// This module determines the behavior of non middle leds
// which are initialized as off after a reset cycle.
module victory(l, r, move, out, reset, clk);

		input logic [1:0] move; 
		input logic l, r;
		input logic reset, clk;
		
		output logic [6:0] out;
		
		logic [3:0] movecode;
		assign movecode = {move, l, r};
		
		enum logic [6:0] {vp1 = 7'b1111001, vp2 = 7'b0100100, init = 7'b1111111} ps, ns;
		
				always_comb begin
					case (ps)
								init: if (movecode == 4'b1010) ns = vp2;
										else if (movecode == 4'b0101) ns = vp1;
										else ns = init;
								vp2: ns = vp2;
								vp1: ns = vp1;
					endcase
				end
		
		// Output logic - could also be implemented as another always_comb block
		// Output is set to bit value of present state.
		assign out = ps;
		// D Flip Flop implementation (DFFs)
		always_ff @(posedge clk) begin
					if (reset)
								ps <= init; //Returns to b101 state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state in state diagram
		end
endmodule


module victory_testbench();

		logic [1:0]move; 
		logic l, r;
		logic reset, clk;
		logic [6:0] out;
		
		victory dut (l, r, move, out, reset, clk);
		
		parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
			end 
			
		
			initial begin
																@(posedge clk);
			reset <= 1; move = 0; l = 0; r = 0;	   @(posedge clk); // Always reset FSMs at start
			
						 reset = 1; 				   	@(posedge clk); //ps = unlit
						reset = 0; 							@(posedge clk);
																@(posedge clk);
						move = 2'b01; l = 0; r = 0;	@(posedge clk);
																@(posedge clk); // ps = lit
																@(posedge clk);
						move = 2'b10; l = 1; r = 0;	@(posedge clk);
																@(posedge clk); // ps = lit
																@(posedge clk);
						l = 0; reset <= 1;							@(posedge clk);// ps = lit
						reset = 0;						   @(posedge clk);
						move = 2'b01; l = 0; r = 1;	@(posedge clk);// ps = unlit
						reset = 0; 							@(posedge clk);
																@(posedge clk);//ps = unlit
																@(posedge clk);
																@(posedge clk);// ps = unlit
																@(posedge clk);
																@(posedge clk);//ps = unlit
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
			$stop; // End the simulation.
	end
endmodule