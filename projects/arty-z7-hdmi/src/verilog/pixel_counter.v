// Pixel Counter module
module pixel_counter
  #(
    parameter MAX = 1000
  )
  (input i_clk,
   output reg[20:0] o_pixel_count);

always @(posedge i_clk)
begin
  o_pixel_count <= o_pixel_count + 1;
  if (o_pixel_count == MAX)
    o_pixel_count <= 0;
end


endmodule