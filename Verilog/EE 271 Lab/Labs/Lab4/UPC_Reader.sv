// UPC Reader, accepts a 3 bit UPC code and determines whether or not its
// associated item was discounted and/or stolen.
module upc_reader(discounted, stolen, u, p, c, m);
		output logic discounted, stolen;
		input logic u, p, c, m;
		
		logic andvalD, norvalS, andvalS, notM, notC;
		
		// Code programs a gate function which generates the discounted output.
		and TheAndGate0 (andvalD, u, c);
		or TheOrGate0 (discounted, andvalD, p);
		
		// Code programs a gate function which generates the stolen output.
		nor TheNorGate0 (norvalS, m, p);
		not TheNotGate0 (notC, c);
		or TheOrGate1 (andvalS, notC, u);
		and TheAndGate2 (stolen, norvalS, andvalS);
		
		
endmodule
	
// Testbench for upc_reader module.
module upc_testbench();
		logic u, p, c, m;
		logic discounted, stolen;
		
		upc_reader dut (.discounted, .stolen, .u, .p, .c, .m);
		
		integer i;
		initial begin
				for(i = 0; i < 16; i++) begin
						{u, p, c, m} = i; #10;
				end
		end
		
endmodule
	
