module tripSW(
	input logic tpOn,
	input logic tpOff,
	
	input logic clk, rst,
	
	output logic trip
);
	logic d;

 	my_dff #(1) tripSwitch(.clk, .rst, .din(d), .q(trip), .en(tpOn || tpOff));

	always_comb begin
	  unique case(1'b1)
		tpOn||(trip && !tpOff): d = 1;
		(tpOff && !tpOn): d = 0;		// tpOn Trumps
	  endcase
	end	

endmodule