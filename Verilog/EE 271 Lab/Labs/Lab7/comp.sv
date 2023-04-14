module comp(out, A, B);

		input logic [9:0] A, B;
		output logic out;
		logic determiner;
		
		always @(*) begin
			if (A > B) determiner = 1;
			else determiner = 0;
		end	
		
		assign out = determiner;
		
endmodule


module comp_testbench();

		logic [9:0] A, B;
		logic out;
		
		comp dut (out, A, B);
		
		integer i;
		initial begin
				for(i = 0; i < 1024; i++) begin
				
					A = i + 1;
					B = 1023 - i; #10;
				end
		end
		
endmodule

