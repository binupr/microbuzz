// Pixel Counter module
module pixel_counter (input i_clk,
                      output o_pixel_count);

always @(posedge i_clk)
begin
  o_pixel_count <= o_pixel_count + 1;
  if (o_pixel_count == max)
    o_pixel__count <= 0;
end


endmodule