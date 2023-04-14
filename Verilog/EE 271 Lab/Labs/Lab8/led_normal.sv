// This module determines the behavior of non middle leds
// which are initialized as off after a reset cycle.
module led_normal(l, r, move, out, reset, clk);

		input logic [1:0] move;
		input logic l, r;
		input logic reset, clk;
		
		output logic out;
		
		logic [3:0] movecode;
		assign movecode = {move, l, r};
		
		enum {lit = 1, unlit = 0} ps, ns;
		
				always_comb begin
					case (ps)
								lit: if (!(movecode == 4'b0100 || movecode == 4'b1000)) ns = lit;
										else ns = unlit;
								unlit: if (movecode == 4'b1001 || movecode == 4'b0110) ns = lit;
											else ns = unlit;
					endcase
				end
		
		// Output logic - could also be implemented as another always_comb block
		// Output is set to bit value of present state.
		assign out = ps[0];
		// D Flip Flop implementation (DFFs)
		always_ff @(posedge clk) begin
					if (reset)
								ps <= unlit; //Returns to b101 state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state in state diagram
		end
		
endmodule


module led_normal_testbench();

		logic [1:0]move; 
		logic out, reset, clk, l, r;
		
		led_normal dut (l, r, move, out, reset, clk);
		
		parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
			end 
			
		
			initial begin
																@(posedge clk);
			reset <= 1; move = 0; l = 0; r = 0;   @(posedge clk); // Always reset FSMs at start
						 reset <= 0; 				   	@(posedge clk); //ps = unlit
																@(posedge clk);
																@(posedge clk);
						move = 2'b01; l = 1; r = 0;	@(posedge clk);
																@(posedge clk); // ps = lit
																@(posedge clk);
						move = 2'b01; l = 1; r = 0;	@(posedge clk);
																@(posedge clk); // ps = lit
																@(posedge clk);
																@(posedge clk);// ps = lit
						move = 1; l = 0; r = 0;		      @(posedge clk);
																@(posedge clk);// ps = unlit
						move = 0;							@(posedge clk);
																@(posedge clk);//ps = unlit
						move = 0; l = 0; r = 1;				@(posedge clk);
																@(posedge clk);// ps = unlit
						move = 2; l = 1; r = 0;				@(posedge clk);
																@(posedge clk);//ps = unlit
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
			$stop; // End the simulation.
	end
endmodule