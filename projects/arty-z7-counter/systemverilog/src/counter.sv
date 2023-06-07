module counter (input clk,
                input rst,
                output reg[3:0] count = 0);

  always @(posedge clk) begin
    if (rst)
      count <= 0;
    else
      count++;
  end

endmodule