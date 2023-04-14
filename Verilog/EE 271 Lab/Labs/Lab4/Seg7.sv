// Module takes an associated UPC code and assigns the 7 segment displays found on the
// later board to display a word associated with the item.
module seg7 (bcd, leds5, leds4, leds3, leds2, leds1, leds0);
	input  logic  [2:0] bcd;
	output logic  [6:0] leds5;
	output logic  [6:0] leds4;
	output logic  [6:0] leds3;
	output logic  [6:0] leds2;
	output logic  [6:0] leds1;
	output logic  [6:0] leds0;
	
	always @(*) begin
		case (bcd)
			
			//          Light: 6543210
			// goat.
			3'b000: begin
				leds5 = 7'b0010000;
				leds4 = 7'b1000000;
				leds3 = 7'b0001000;
				leds2 = 7'b0000111;
				leds1 = 7'b1111111; 
				leds0 = 7'b1111111;
			end
			
			// fish
			3'b001: begin
				leds5 = 7'b0001110;
				leds4 = 7'b1111011;
				leds3 = 7'b0010010;
				leds2 = 7'b0001001;
				leds1 = 7'b1111111; 
				leds0 = 7'b1111111;
			end
			/*3'b010: begin
				leds5 = 7'b0010000;
				leds4 = 7'b1000000;
				leds3 = 7'b0001000;
				leds2 = 7'b0000111;
				leds1 = 7'b1111111; 
				leds0 = 7'b1111111;
			end	// 2*/
			// potato
			3'b011: begin
				leds5 = 7'b0001100;
				leds4 = 7'b1000000;
				leds3 = 7'b0000111;
				leds2 = 7'b0001000;
				leds1 = 7'b0000111; 
				leds0 = 7'b1000000;
			end	// 3
			// gucci
			3'b100: begin
				leds5 = 7'b0010000;
				leds4 = 7'b1000001;
				leds3 = 7'b1000110;
				leds2 = 7'b1000110;
				leds1 = 7'b1111011; 
				leds0 = 7'b1111111;
			end	// 4
			// beats
			3'b101: begin
				leds5 = 7'b0000011;
				leds4 = 7'b0000110;
				leds3 = 7'b0001000;
				leds2 = 7'b0000111;
				leds1 = 7'b0010010; 
				leds0 = 7'b1111111;
			end	// 5
			// peep
			3'b110: begin
				leds5 = 7'b0001100;
				leds4 = 7'b0000110;
				leds3 = 7'b0000110;
				leds2 = 7'b0001100;
				leds1 = 7'b1111111; 
				leds0 = 7'b1111111;
			end	// 6
			/*3'b111: leds = 7'b0000111; // 7
			3'b000: leds = 7'b1111111; // 8
			3'b001: leds = 7'b1101111; // 9*/
			default: begin
				leds5 = 7'b1111111;	
				leds4 = 7'b1111111; 
				leds3 = 7'b1111111; 
				leds2 = 7'b1111111; 
				leds1 = 7'b1111111; 
				leds0 = 7'b1111111;
			end
		endcase
	end
	
	
endmodule

	

