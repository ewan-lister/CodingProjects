// This module processes user key-presses
// filtered through a d ff, such that a single
// held press is not registered as multiple presses.
module press_processor(p1press, p2press, out, reset, clk);

		input logic p1press, p2press, clk, reset;
		output logic [1:0] out;
		logic [1:0] rawbits, pressbits;
		
		assign rawbits = {p1press, p2press};
		enum {init, rp1, rp2} ps, ns;
		
		
		
		// This logic describes all the possible state transitions from ps to ns
		
		// Always_comb block determines behavior of FSM
		
		always_comb begin
					case (ps)
								init: if (rawbits == 2'b10) begin
												ns = rp2;
												pressbits = 2'b10;
											end
										else if (rawbits == 2'b01) begin
										
												ns = rp1;
												pressbits = 2'b01;
										end	
										else begin
												ns = init;
												pressbits = 2'b00;// no transition is bits = 2'b11
											end
								rp1: if (rawbits == 2'b10) begin
												ns = rp2;
												pressbits = 2'b10;
											end
										else if (rawbits == 2'b00) begin
										
												ns = init; // transition if wind is right-to-left
												pressbits = 2'b00;
										end	
										else begin
												ns = rp1;
												pressbits = 2'b00;// no transition is bits = 2'b11
											end		     //		|
								rp2: if (rawbits == 2'b01) begin
												ns = rp1;
												pressbits = 2'b01;
											end
										else if (rawbits == 2'b00) begin
										
												ns = init; // transition if wind is right-to-left
												pressbits = 2'b00;
										end	
										else begin
												ns = rp2;
												pressbits = 2'b00;// no transition is bits = 2'b11
										end    //	        \/
					endcase
		end
		
		// Output logic - could also be implemented as another always_comb block
		// Output is set to bit value of present state.
		assign out = pressbits;
		// D Flip Flop implementation (DFFs)
		always_ff @(posedge clk) begin
					if (reset)
								ps <= init; //Returns to b101 state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state in state diagram
		end
		
endmodule

module press_processor_testbench();
			logic  p1press, p2press, clk, reset;
			logic  [1:0] out;
			
			press_processor dut (p1press, p2press, out, reset, clk);
			
			parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
			end 
   
			// Set up the inputs to the design.  Each line represents a clock cycle 
			// Simulation sends the state machine into all four possible states
			initial begin
																@(posedge clk);
						 reset <= 1;    					@(posedge clk); // Always reset FSMs at start
						 reset <= 0; 				   	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
						p1press = 1; p2press = 1;		@(posedge clk);
																@(posedge clk); // out = 00
																@(posedge clk);
						p1press = 0; p2press = 0;		@(posedge clk);
																@(posedge clk); // out = 00
						p2press = 1; p1press = 0;		@(posedge clk);
																@(posedge clk);// out = 10
						p2press = 1; p1press = 0;		@(posedge clk);// out = 00
																@(posedge clk);
						p2press = 1; p1press = 1;		@(posedge clk);
																@(posedge clk);
						p2press = 0; p1press = 1;		@(posedge clk);
																@(posedge clk);
						p2press = 1; p1press = 0;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
			$stop; // End the simulation.
	end
endmodule
