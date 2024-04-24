

module setCounter
  #(
    parameter int b=4,  // Bits
    parameter int m=14  // Maximum
    )
   (

    input  logic         inc,
    input  logic         dec,
	 
	 input  logic [b-1:0] setValue,
   
    input  logic         clk,
    input  logic         rst,

    output logic [b-1:0] cnt 
    );
   
	logic			 onStart;
   logic [b-1:0] 	 cnt_nxt ;

   my_dff #(b) myDff( .din(cnt_nxt), .clk, .rst, .en(1'b1), .q(cnt));
	
	my_dff #(1'b1) onStartDff( .din(1'b1), .clk, .rst, .en(1'b1), .q(onStart));

   always_comb begin
      unique case (1'b1)
	&{!inc, dec}: cnt_nxt = cnt==0   ? m-1 : cnt-1 ; 
	&{ inc,!dec}: cnt_nxt = cnt==m-1 ? 0   : cnt+1 ;
	!onStart:		  cnt_nxt = setValue;
	default:      cnt_nxt = cnt ;
      endcase 
   end //always_comb
   
endmodule 