

module counter
  #(
    parameter int b=4,  // Bits
    parameter int m=14  // Maximum
    )
   (

    input  logic         inc,
    input  logic         dec,
   
    input  logic         clk,
    input  logic         rst,

    output logic [b-1:0] cnt 
    );
   
   logic [b-1:0] 	 cnt_nxt ;

   my_dff #(b) myDff( .din(cnt_nxt), .clk, .rst, .en(1'b1), .q(cnt));

   always_comb begin
      unique case (1'b1)
	&{!inc, dec}: cnt_nxt = cnt==0   ? m-1 : cnt-1 ; 
	&{ inc,!dec}: cnt_nxt = cnt==m-1 ? 0   : cnt+1 ;
	default:      cnt_nxt = cnt ;
      endcase 
   end //always_comb
   
endmodule 