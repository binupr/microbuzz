module rgb_pattern 
(
  input i_clk,
  input i_hsync,
  input i_vsync,
  input i_blank,
  input i_pixel_pos,
  output o_hsync,
  output o_vsync,
  output o_blank,
  output [7:0] o_red,
  output [7:0] o_green,
  output [7:0] o_blue
);


// Local wires
integer pos_x;
integer ps_y;
colors [0:7] rainbow = [24'hFF0000, 24'hFF7F00, 24'hFFFF00, 24'h00FF00, 24'h0000FF, 24'h4B0082, 24'h9400D3, 24'h000000];
wire funct_colors[23:0];

assign pos_x = i_pixel_pos % 800;
assign pos_y = i_pixel_pos/800;
assign funct_colors = rainbow[0];

always @(posedge i_clk) begin
  o_hsync   <= i_hsync;
  o_vsync   <= i_vsync;
  if (i_blank == 1'b0) begin
    o_red   <= funct_colors[23:16];
    o_green <= funct_colors[15:8];
    o_blue  <= funct_colors[7:0];
    o_blank <= 1'b0;
  end else begin
    o_red   <= '0;
    o_green <= '0;
    o_blue  <= '0;
  end
end

endmodule