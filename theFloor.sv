module theFloor
  #(
    parameter int pA = 12,
    parameter int cA = 4 
    )
    (
     input  logic [pA-1:0] pix_x,
     input  logic [pA-1:0] pix_y,
     input  logic          pix_v,

     input logic [11:0] topColor, midColor,
     
     output logic [cA-1:0] color[2:0]
     );

  logic [cA-1:0] floor1 [2:0];
  logic [cA-1:0] floor2 [2:0];
  logic [cA-1:0] floor3 [2:0];

  assign color[2] = floor1[2] + floor2[2] + floor3[2];
  assign color[1] = floor1[1] + floor2[1] + floor3[1];
  assign color[0] = floor1[0] + floor2[0] + floor3[0];

  box #(pA, cA) topFloor(
		.pix_y, .pix_x, .pix_v,
		.width(12'd640), .hight(12'd159),
		.Xcord('0), .Ycord('0),
		.boxColor(topColor),   // Blue
		.color(floor1));

  box #(pA, cA) midFloor(
		.pix_y, .pix_x, .pix_v,
		.width(12'd640), .hight(12'd160),
		.Xcord('0), .Ycord(12'd160),
		.boxColor(midColor),   // Grey
		.color(floor2));

  box #(pA, cA) bottomFloor(
		.pix_y, .pix_x, .pix_v,
		.width(12'd640), .hight(12'd160),
		.Xcord('0), .Ycord(12'd321),
		.boxColor(topColor),
		.color(floor3));

	  
endmodule