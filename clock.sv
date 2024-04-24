module clock (

input logic clk,
input logic rst_l,
output logic my_clk

);


always_ff @(posedge clk) begin
 priority case(1'b1)
 ~rst_l: my_clk = 1'b0;
 default: my_clk = ~my_clk;
 endcase
 end
 
 endmodule
 