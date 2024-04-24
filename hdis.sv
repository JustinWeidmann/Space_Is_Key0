module hdis(
	input logic [3:0] sw,
	output logic [6:0] dis
);

	always_comb begin
		unique case(sw)
			4'b0000: dis = 7'b1000000;
			4'b0001: dis = 7'b1111001;
			4'b0010: dis = 7'b0100100;
			4'b0011: dis = 7'b0110000;
			4'b0100: dis = 7'b0011001;
			4'b0101: dis = 7'b0010010;
			4'b0110: dis = 7'b0000010;
			4'b0111: dis = 7'b1111000; //7
			4'b1000: dis = 7'b0000000;
			4'b1001: dis = 7'b0010000;
			4'b1010: dis = 7'b0001000;
			4'b1011: dis = 7'b0000011;
			4'b1100: dis = 7'b1000110;	//C
			4'b1101: dis = 7'b0100001;
			4'b1110: dis = 7'b0000110;	//E
			4'b1111: dis = 7'b0001110;	//F
		endcase
	end

endmodule