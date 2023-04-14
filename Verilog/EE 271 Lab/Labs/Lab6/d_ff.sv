// Creates a basic D flip flop to regulate keystrokes from player 1 and prevent noise
// from interfering.
module d_ff(q, d, reset, clk);
			input logic 	d, clk;
			input logic reset;
			output logic	q; 
			
			always @(posedge clk)
				begin
					if(reset == 1'b1) q = 0;
					else q <= d;
				end
endmodule

module d_ff_testbench();


			logic  clk;
			logic 	q;
			logic  	d;
			logic reset;
			
			d_ff dut (q, d, reset, clk);
			// Set up a simulated clock to toggle (from low to high or high to low)
			// every 50 time steps
			parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
			end 
   
			// Set up the inputs to the design.  Each line represents a clock cycle 
			// simulation tests all possible states of D flip flop
			initial begin
										reset = 1;			@(posedge clk);
																@(negedge clk);
																@(posedge clk); // q should switch to 0 at this stage
										reset = 0; d = 1;	@(negedge clk);
																@(posedge clk);// q should switch to 1
																@(negedge clk);// q should hold 1 value
																@(posedge clk);// 		.
																@(negedge clk);// 		.
																@(posedge clk);//			.
										d = 0;				@(negedge clk);//			.
																@(posedge clk);// q should switch to 0
																@(negedge clk);
																@(posedge clk);
																@(negedge clk);
																@(posedge clk);
										d = 1;				@(negedge clk);
																@(posedge clk);
																@(negedge clk);
																@(posedge clk);
																@(negedge clk);
																@(posedge clk);
																@(negedge clk);
																@(posedge clk);
			$stop; // End the simulation.
			end
endmodule
