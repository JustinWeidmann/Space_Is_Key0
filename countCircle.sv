module countCircle
  #(
    parameter int b=4,  // Bits
    parameter int m=14  // Maximum
    )
   (

    input  logic         inc,
   
    input  logic         clk,
    input  logic         rst,

    output logic [b-1:0] cnt 
    );
   
   logic [b-1:0] 	 cnt_nxt ;
   logic t;

   my_dff #(b) myDff( .din(cnt_nxt), .clk, .rst, .en(1'b1), .q(cnt));

   tripSW tripswitch(.clk, .rst, .tpOn(cnt==m-1), .tpOff(cnt==0), .trip(t));

   always_comb begin
      unique case (1'b1)
	&{ inc, t}: cnt_nxt = cnt==0   ? 0 : cnt-1 ;  // dec
	&{ inc,!t}: cnt_nxt = cnt+1 ;    // inc
	default:      cnt_nxt = cnt ;    // stay
      endcase 
   end //always_comb
   
endmodule 