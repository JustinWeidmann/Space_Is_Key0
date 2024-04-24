module player
#(
    parameter int pA = 10 ,
    parameter int cA = 4 
    )
    (
     input  logic [pA-1:0] pix_x ,
     input  logic [pA-1:0] pix_y ,
     input  logic          pix_v ,
     output logic [cA-1:0] color [2:0],
	  
	  input logic up, down, left, right, imgReturn,
	  
     input logic [11:0] boxColor,
	  input logic [pA-1:0] width,
	  input logic [pA-1:0] hight,
	  
     input  logic clk,
     input  logic rst
     );
	  
	  logic [pA-1:0] Xcord;
	  logic [pA-1:0] Ycord;
	  
	  assign Xcord = playerX;
	  assign Ycord = playerY;
	  
	setCounter #(12, 640) moveX(.clk, .rst, .inc(!right && imgReturn), .dec(!left && imgReturn), .cnt(playerX), .setValue(12'd300));	//(300,220) is center for 20x20 cube
	setCounter #(12, 480) moveY(.clk, .rst, .inc(up && imgReturn), .dec(down && imgReturn), .cnt(playerY), .setValue(12'd220));
	  
	assign color[2] = pix_v?((((pix_x >=(Xcord)) && (pix_x <= (width + Xcord))) && ((pix_y >=(Ycord)) && (pix_y <= (hight + Ycord))))? boxColor[11:8]: 4'h0):4'h0;   //blue
   assign color[1] = pix_v?((((pix_x >=(Xcord)) && (pix_x <= (width + Xcord))) && ((pix_y >=(Ycord)) && (pix_y <= (hight + Ycord))))? boxColor[7:4]: 4'h0):4'h0; //green
   assign color[0] = pix_v?((((pix_x >=(Xcord)) && (pix_x <= (width + Xcord))) && ((pix_y >=(Ycord)) && (pix_y <= (hight + Ycord))))? boxColor[3:0]: 4'h0):4'h0;	//red
	
	
endmodule