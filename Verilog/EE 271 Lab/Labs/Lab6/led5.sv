// Module determines the behavior of the middle LED
// for the tug of war game.
module led5(l, r, move, out, reset, clk);

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
								ps <= lit; //Returns to b101 state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state in state diagram
		end
		
endmodule


module led5_testbench();

		logic [1:0] move; 
		logic out, reset, clk, l, r;
		
		led5 dut (l, r, move, out, reset, clk);
		
		parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
			end 
			
		
			initial begin
																@(posedge clk);
						 reset <= 1; move = 0; l = 0; r = 0;   		@(posedge clk); // Always reset FSMs at start
						 reset <= 0; 				   	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
						l = 0; r = 0; move = 2'b00;	@(posedge clk);
																@(posedge clk); //
																@(posedge clk);
						l = 0; r = 1; move = 2'b00;	@(posedge clk);
																@(posedge clk); // islit = 1
						l = 0; r = 0; move = 2;				@(posedge clk);
																@(posedge clk);// 
						l = 0; r = 0; move = 1;		      @(posedge clk);// out = 00
																@(posedge clk);
						l = 1; r = 0; move = 1;				@(posedge clk);
																@(posedge clk);
						l = 0; r = 0; move = 1;				@(posedge clk);
																@(posedge clk);
						l = 0; r = 1; move = 2;				@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
			$stop; // End the simulation.
	end
endmodule

