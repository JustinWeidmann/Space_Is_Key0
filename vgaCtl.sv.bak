module vgaCtl
  #(
    parameter int pA = 10 ,
    parameter int fA = 32 
    )
   (
    output logic [pA-1:0] pix_x ,
    output logic [pA-1:0] pix_y ,
    output logic          pix_v ,
    output logic [fA-1:0] frame_id,
    output logic          hs ,
    output logic          vs ,
    input  logic          clk ,
    input  logic          rst
    );

   // TAKEN FROM BASYS 3 DEMO
   localparam int frame_width  = 640;
   localparam int frame_height = 480 ;
   localparam int frames = 275625; // number of frames     

   localparam int hpw = 96;  // hsync pulse length
   localparam int vpw =   2;  // vsync pulse length
   localparam int hbp = 48;  // end of horizontal back porch
   localparam int hfp =  16;  // beginning of horizontal front porch
   localparam int vbp =  33;  // end of vertical back porch
   localparam int vfp =  10;  // beginning of vertical front porch

   localparam int hpixels = frame_width  + hpw + hfp + hbp ; // horizontal pixels per line
   localparam int vlines =  frame_height + vpw + vfp + vbp ; // vertical lines per frame	
	
	
	
   logic [pA-1:0] 	  countX, countY ;
   logic                  rowReturn, imgReturn ;

   //Yay for counters 
   counter #(pA, hpixels) ctrX( .inc(1'b1),      .dec(1'b0), .clk, .rst, .cnt(countX) );
   counter #(pA, vlines)  ctrY( .inc(rowReturn), .dec(1'b0), .clk, .rst, .cnt(countY) );
   counter #(fA, frames)  ctrF( .inc(imgReturn), .dec(1'b0), .clk, .rst, .cnt(frame_id) );

   //Generate the increments for the outer loop counters
   assign rowReturn = countX == (hpixels-1);
   assign imgReturn = (countY == (vlines-1)) && rowReturn ;

   //Generate the sync pulses
   assign hs = !( countX >= (hfp+hbp+frame_width) ) ;
   assign vs = !( countY >= (vfp+vbp+frame_height) );

   // Translate the counts into useful numbers
   assign pix_x = countX - hbp ;
   assign pix_y = countY - vbp ;
   assign pix_v =    (countX >= hbp) 
                  && (countX < (hbp+frame_width)  )
		  && (countY >= vbp)
                  && (countY < (vbp+frame_height) ) ;

endmodule //vgaCtl