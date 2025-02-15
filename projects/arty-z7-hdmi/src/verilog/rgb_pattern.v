module rgb_pattern 
(
  input i_clk,
  input i_hsync,
  input i_vsync,
  input i_blank,
  input wire [20:0] i_pixel_pos,
  output reg o_hsync,
  output reg o_vsync,
  output reg o_blank,
  output reg [7:0] o_red,
  output reg [7:0] o_green,
  output reg [7:0] o_blue
);


// Local wires
wire [9:0] pos_x; // range is 0 to 800
wire [9:0] pos_y; // range is 0 to 525
wire [23:0] rainbow [0:7]; // Unpacked array of 8 elements, each 24-bit wide
wire [23:0] funct_colors;

assign pos_x = i_pixel_pos % 800;
assign pos_y = i_pixel_pos/800;
assign funct_colors = rainbow[0];

assign rainbow[0] = 24'hFF0000; // Red
assign rainbow[1] = 24'hFF7F00; // Orange
assign rainbow[2] = 24'hFFFF00; // Yellow
assign rainbow[3] = 24'h00FF00; // Green
assign rainbow[4] = 24'h0000FF; // Blue
assign rainbow[5] = 24'h4B0082; // Indigo
assign rainbow[6] = 24'h9400D3; // Violet
assign rainbow[7] = 24'h000000; // Black

always @(posedge i_clk) begin
  o_hsync   <= i_hsync;
  o_vsync   <= i_vsync;
  if (i_blank == 1'b0) begin
    o_red   <= funct_colors[23:16];
    o_green <= funct_colors[15:8];
    o_blue  <= funct_colors[7:0];
    o_blank <= 1'b0;
  end else begin
    o_red   <= 0;
    o_green <= 0;
    o_blue  <= 0;
    o_blank <= 1'b1;
  end
end

endmodule