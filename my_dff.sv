
module my_dff
	#(parameter int size = 1 ) 
   	(
    	input logic [size-1:0]  din, 
    	input logic 	    clk, 
    	input logic 	    rst, 
    	input logic 	    en, 
    	output logic [size-1:0] q
    );

   
   	logic [511:0] 	    rst_val ; // To avoid assigning a constant of unspec length
   	logic [size-1:0] 	d ;       // Internal version of d
   	bit   [size-1:0] 	q_val;    // Internal version of q_val
   
   	assign    d[size-1:0] = din[size-1:0]; //Delay data in to prevent inf. loops    
   	assign    q           = q_val ; 
   	assign    rst_val     = 512'd0 ;
   
   	always_ff @ (posedge clk) begin 
   		priority case ( 1'b1 )
			(~rst): q_val[size-1:0]  <=  rst_val[size-1:0] ;  //Reset is active low
			( en):  q_val[size-1:0]  <=        d[size-1:0] ;  //Enable is active high
			default:q_val[size-1:0] <=  		  q[size-1:0] ;
     	endcase    
    end

endmodule //dff	
