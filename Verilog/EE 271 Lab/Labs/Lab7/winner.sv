module winner(victories, out, reset, clk);

		input logic victories, reset, clk;
		output logic [6:0] out;
		
		enum logic [6:0] {count0 = 7'b1000000, count1 = 7'b1111001,
						count2 = 7'b0100100, count3 = 7'b0110000,
						count4 = 7'b0011001, count5 = 7'b0010010,
						count6 = 7'b0000010, count7 = 7'b1111000} ps, ns;
		
		always_comb begin
					case (ps)
								count0:	if(victories == 1) ns = count1;
											else ns = count0;
											
								count1:	if(victories == 1) ns = count2;
											else ns = count1;
											
								count2:	if(victories == 1) ns = count3;
											else ns = count2;
											
								count3:	if(victories == 1) ns = count4;
											else ns = count3;
											
								count4:	if(victories == 1) ns = count5;
											else ns = count4;
											
								count5:	if(victories == 1) ns = count6;
											else ns = count5;
											
								count6:	if(victories == 1) ns = count7;
											else ns = count6;
											
								count7:	ns = count7;
					endcase
		end
		
		// Output logic - could also be implemented as another always_comb block
		// Output is set to bit value of present state.
		assign out = ps;
		// D Flip Flop implementation (DFFs)
		always_ff @(posedge clk) begin
					if (reset)
								ps <= count0; //Returns to b101 state when reset is active
					else
								ps <= ns; //Otherwise, advances to next state in state diagram
		end
		
endmodule


module winner_testbench();

	logic victories, reset, clk;
	logic [6:0] out;
	
	winner dut (victories, out, reset, clk);
	
	parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
			end 

			initial begin
					reset = 1;victories = 0;	@(posedge clk);
					reset = 0;	@(posedge clk);
										@(posedge clk);
					victories = 0;	@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
					victories = 1;	@(posedge clk);
					victories = 0;	@(posedge clk);
										@(posedge clk);
					victories = 1;	@(posedge clk);
					victories = 0;	@(posedge clk);
										@(posedge clk);
					victories = 1;	@(posedge clk);
					victories = 0;	@(posedge clk);
										@(posedge clk);
					victories = 1;	@(posedge clk);
					victories = 0;	@(posedge clk);
										@(posedge clk);
					victories = 1;	@(posedge clk);
					victories = 0;	@(posedge clk);
						@(posedge clk);
					victories = 1;	@(posedge clk);
					victories = 0;	@(posedge clk);
						@(posedge clk);
					victories = 1;	@(posedge clk);
					victories = 0;	@(posedge clk);
						@(posedge clk);
					victories = 1;	@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
					victories = 0;	@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						
				$stop;		
			end

endmodule


			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			