module EndScreen
  #(
    parameter int pA = 12,
    parameter int cA = 4 
    )
    (
     input  logic [pA-1:0] pix_x,
     input  logic [pA-1:0] pix_y,
     input  logic          pix_v,

     input logic imgReturn,
	 input logic jump, restart,

     input logic [11:0] topColor, midColor,

     input  logic clk,
     input  logic rst,

     output logic LVcp,
     output logic [cA-1:0] color [2:0],
	  output logic [6:0] hex0
     );
    
    // Scroll Logic
    logic [pA-1:0] playerX, playerY;
    logic right, left, incSLV;
    logic [1:0] subLV;
    logic [pA-1:0] setStartX; 
	 
    // Jump Logic
	logic [6:0] jumpOst;
	logic jumping;

    // Death Logic
    logic death;
    logic playerHitBox, obstHitBox;

    // Color Logic
    logic [cA-1:0] levelBlocks [2:0];
    logic [cA-1:0] theFloorC [2:0];
	  logic [cA-1:0] playerC [2:0];

    logic [11:0] playerFloorC;

    assign color[0] = theFloorC[0] + playerC[0];
    assign color[1] = theFloorC[1] + playerC[1];
    assign color[2] = theFloorC[2] + playerC[2];
	 
	 //
	 // Scroll Logic
    //
	 /*
	assign left = !right;
	assign incSLV = ((playerX==12'd620)&&(subLV==2'd0))||((playerX==12'd1)&&(subLV==2'd1))||((playerX==12'd620)&&(subLV==2'd2));	// inc when we hit the respective walls

   setCounter #(12, 640) moveX(.clk, .rst(death), .inc(right && imgReturn), .dec(left && imgReturn), .cnt(playerX), .setValue(setStartX));
	
	counter #(2, 4) subLevleCnt(.clk, .rst, .inc(incSLV), .dec(1'b0), .cnt(subLV)); // inc when we move up in sub level

    always_comb begin
        unique case(subLV)
            2'd0: begin
                right = 1;
                setStartX = '0;
					 playerY = 12'd139 - jumpOst;
					 playerFloorC = midColor-topColor;
                LVcp = 0;
            end
            2'd1: begin
                right = 0;
                setStartX = 12'd620;
					 playerY = 12'd300 - jumpOst;
					 playerFloorC = topColor-midColor-midColor;
                LVcp = 0;
            end
            2'd2: begin
                right = 1;
                setStartX = '0;
					 playerY = 12'd459 - jumpOst;
					 playerFloorC = midColor-topColor;
                LVcp = 0;
            end
            2'd3: begin
                right = 1;
                setStartX = '0;
					 playerY = 12'd480 - jumpOst;
					 playerFloorC = '0;
                LVcp = 1;
            end
        endcase
    end
	 
	 hdis hex0DIS(.sw({2'd0, subLV}), .dis(hex0));


    //
    // Jump Logic
    //
	
	tripSW tripswitch(.clk, .rst, .tpOn(jump), .tpOff(jumpOst=='0), .trip(jumping));
	countCircle #(7, 70) jumpOffset(.clk, .rst, .inc(jumping && imgReturn), .cnt(jumpOst));
	
	//countJump #(7, 70) jumpOffset(.clk, .rst, .jump(jumping && imgReturn), .cnt(jumpOst));


    //
    // Death Logic
    //

    assign playerHitBox = (playerC[0]!='0)||(playerC[1]!='0)||(playerC[2]!='0);
    assign obstHitBox = (levelBlocks[0]!='0)||(levelBlocks[1]!='0)||(levelBlocks[2]!='0);

    assign death = !((playerHitBox && obstHitBox)||!rst||restart); // When player and obst are on same pixle
*/

    //
    // Level Design
    //

    box #(pA, cA) player(
		.pix_y, .pix_x, .pix_v,
		.width(12'd20), .hight(12'd20),
		.Xcord(playerX), .Ycord(playerY),
    .boxColor(playerFloorC),
		.color(playerC));

    theFloor #(pA, cA) theFloor0(
        .pix_y, .pix_x, .pix_v,
        .topColor, .midColor,
        .color(theFloorC)
    );



endmodule