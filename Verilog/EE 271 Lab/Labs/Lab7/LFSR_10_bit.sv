module LFSR_10_bit(out, reset, clk);

		input logic reset, clk;
		logic [9:0] qin, qout;
		output logic [9:0] out;
				
		logic xnor10and7;
		xnor TheXNORGate (xnor10and7, qin[9], qin[6]);
		
		assign qout[0] = xnor10and7;
		assign qout[9:1] = qin[8:0];
		
		always @(posedge clk) begin
				if (reset) qin <= 10'b0000000000;
				else qin <= qout;
		end
				
		assign out = qout;
		
endmodule

module LFSR_10_bit_testbench();

		logic [9:0] qin, out;
		logic reset, clk;
		
		LFSR_10_bit dut (out, reset, clk);
		
		parameter CLOCK_PERIOD=100;
			initial begin
						clk <= 0;
						forever #(CLOCK_PERIOD/2) clk <= ~clk;//toggle the clock indefinitely
		end
		
		integer i;
		initial begin 
				reset = 1; @(posedge clk);
				reset = 0; @(posedge clk);
				for(i = 0; i < 1024; i++) begin
						qin = i; @(posedge clk);
				end
			$stop;
		end
		
					/*@(posedge clk);
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
					@(posedge clk);*/
					
endmodule


					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					