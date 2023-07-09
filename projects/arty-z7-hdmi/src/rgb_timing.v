// RGB timing module
module rgb_timing (input i_clk,
                   output o_hsync,
                   output o_vsync,
                   output o_blank);

// Parameter definitions for the different Pixel resolutions
// 1920x1080 (1080p)
// parameter P_RES_X  = 1920;
// parameter P_RES_Y  = 1080;
// parameter P_HFRONT = 88;
// parameter P_HSYNC  = 44;
// parameter P_HBACK  = 148;
// parameter P_VFRONT = 4;
// parameter P_VSYNC  = 5;
// parameter P_VBACK  = 36;

// 1280x720 (720p)
// parameter P_RES_X  = 1280;
// parameter P_RES_Y  = 720;
// parameter P_HFRONT = 110;
// parameter P_HSYNC  = 40;
// parameter P_HBACK  = 220;
// parameter P_VFRONT = 5;
// parameter P_VSYNC  = 5;
// parameter P_VBACK  = 20;

// 640x480 (480p)
parameter P_RES_X  = 640;
parameter P_RES_Y  = 480;
parameter P_HFRONT = 16;
parameter P_HSYNC  = 96;
parameter P_HBACK  = 48;
parameter P_VFRONT = 10;
parameter P_VSYNC  = 2;
parameter P_VBACK  = 33;

parameter P_HBLANK  = P_HFRONT + P_HSYNC + P_HBACK;
parameter P_VBLANK  = P_VFRONT + P_VSYNC + P_VBACK;
parameter P_TOTAL_X = P_RES_X + P_HBLANK;
parameter P_TOTAL_Y = P_RES_Y + P_VBLANK;

always @(posedge i_clk)
begin 
  if (x == P_RES_X - 1)
    o_blank <= 1'b1;
  else if ((x == P_TOTAL_X - 1) && (( y < P_RES_Y - 1) || (y == P_TOTAL_Y -1)))
    o_blannk <= 1'b0;

  if (x == P_RES_X + P_HFRONT - 1)
    o_hsync <= 1'b1;
  else if (x == P_RES_X + P_HFRONT + P_HSYNC - 1)
    o_hsync <= 1'b0;

  if (x == P_TOTAL_X - 1)
    x <= 12'b0;
    if (y == P_RES_Y + P_VFRONT - 1)
      o_vsync <= 1'b1;
    else if (y == P_RES_Y + P_VFRONT + P_VSYNC - 1)
      o_vsync <= 1'b0;
    
    if (y == P_TOTAL_Y - 1)
      y <= 12'b0;
    else
      y <= y + 1;
  else
    x <= x + 1;
  
end


endmodule

