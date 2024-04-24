
module lab5
   (
    output logic [3:0] VGA_RED,
    output logic [3:0] VGA_BLUE,
    output logic [3:0] VGA_GREEN,
    output logic       VGA_HS,
    output logic       VGA_VS,
	 
	 output logic [6:0] hex0,
	 
	 input logic jump, restart,
	 
    input  logic       clk,
    input  logic       rst 
    );

   parameter int       pA = 12 ; // Pixel address bits
   parameter int       fA = 32 ; // Frame ID bits
   parameter int       cA = 4  ; // Color bits
   parameter int       cM = 15 ; // Max Color
   
   logic [pA-1:0]      pix_x ; // Image space pixel address
   logic [pA-1:0]      pix_y ; // Image space pixel address
   logic [fA-1:0]      frame_id ; // The Frame id 
   logic               pix_v ; // Pixel address in pixel space
	
	logic imgReturn;
	
	logic [pA-1:0] playerX;
	logic [pA-1:0] playerY;

   logic [cA-1:0]      color[2:0];
   logic hs,vs,my_clk;
   
   logic 	       rst_l ;
	
   // Level Logic
	logic LV1cp, LV2cp, LV3cp;
	logic LV1rst, LV2rst, LV3rst;
   logic [1:0] lvSW;

   logic [cA-1:0] LV1C [2:0];
   logic [cA-1:0] LV2C [2:0];
   logic [cA-1:0] LV3C [2:0];

   assign rst_l = rst ;

   // Flop Outputs
	/*
   my_dff #(4) d01(.din(color[0]),.clk(my_clk),.rst(rst_l),.en(1'b1),.q(VGA_RED));
   my_dff #(4) d02(.din(color[1]),.clk(my_clk),.rst(rst_l),.en(1'b1),.q(VGA_GREEN));
   my_dff #(4) d03(.din(color[2]),.clk(my_clk),.rst(rst_l),.en(1'b1),.q(VGA_BLUE));
   my_dff #(2) d04(.din({hs,vs}) ,.clk(my_clk),.rst(rst_l),.en(1'b1),.q({VGA_HS,VGA_VS}));
	*/
	 
   assign VGA_RED = color[0];
   assign VGA_GREEN = color[1];
   assign VGA_BLUE = color[2];
   assign {VGA_HS,VGA_VS} = {hs,vs};
   
   vgaCtl #(pA,fA) vgaDriver( 
      .pix_x(pix_x), .pix_y(pix_y), .pix_v(pix_v),
		.frame_id,
		.hs(hs), .vs(vs), 
		.clk(my_clk), .rst(rst_l),
		.imgReturn);
 
 
   LV1 #(pA, cA) LV01(
      .clk, .rst,
      .pix_y, .pix_x, .pix_v,
		.imgReturn, .jump(!jump), .restart(LV1rst),
		.LVcp(LV1cp),
      .topColor(12'h07C), .midColor(12'hDDD),
      .color(LV1C)
   );

   LV2 #(pA, cA) LV02(
      .clk, .rst,
      .pix_y, .pix_x, .pix_v,
		.imgReturn, .jump(!jump), .restart(LV2rst),
		.LVcp(LV2cp),
      .topColor(12'h033), .midColor(12'h69F),
      .color(LV2C)
   );

   LV3 #(pA, cA) LV03(
      .clk, .rst,
      .pix_y, .pix_x, .pix_v,
		.imgReturn, .jump(!jump), .restart(LV3rst),
		.LVcp(LV3cp),
      .topColor(12'hEEE), .midColor(12'hF60), // Off white and orange
      .color(LV3C)
   );

   //
   // Level Switch Logic
   //
	
	always_comb begin	// Switch the active level
      unique case(1'b1)
         (!LV1cp&&!LV2cp&&!LV3cp): begin
				color = LV1C;
				LV1rst = !restart;
				LV2rst = 1;
				LV3rst = 1;
			end
         (LV1cp&&!LV2cp&&!LV3cp): begin
				color = LV2C;
				LV1rst = 1;
				LV2rst = !restart;
				LV3rst = 1;
			end
         (LV1cp&&LV2cp&&!LV3cp): begin
				color = LV3C;
				LV1rst = 1;
				LV2rst = 1;
				LV3rst = !restart;
			end
         default: begin
				color = LV1C;
				LV1rst = 1;
				LV2rst = 1;
				LV3rst = 1;
			end
      endcase
   end
		
		
	clock clk1(.clk(clk),.rst_l(rst_l),.my_clk(my_clk));
 
endmodule


 

    
   
   

