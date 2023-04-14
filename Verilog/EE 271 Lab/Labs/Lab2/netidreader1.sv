module netidreader1(bits, leds);
	input logic [7:0] bits;
	output logic leds;
	logic andval1, andval2, andval3, andval4;
	logic andvala, andvalb, nota, notf, notg, andvalfinal;
	
	not notgate1 (nota, bits[7]);
	not notgate2 (notf, bits[2]);
	not notgate3 (notg, bits[1]);
	
	and andgate1 (andval1, nota, bits[6]);
	and andgate2 (andval2, bits[5], bits[4]);
	and andgate3 (andval3, bits[3], bits[2]);
	and andgate4 (andval4, notg, bits[0]);
	
	and andgatea (andvala, andval1, andval2);
	and andgateb (andvalb, andval3, andval4);
	
	and andgatefinal (leds, andvala, andvalb);
endmodule

