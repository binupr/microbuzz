module tb_counter;
  reg clk = 0;
  reg rst = 1;
  wire [3:0] count;

  // Instantiate DUT
  counter counter_inst (.clk(clk),
                        .rst(rst),
                        .count(count));

  // Generate clock with 100 MHz Frequency
  always #5 clk = ~clk;

  // Drive stimulus to DUT
  initial begin
    // Reset is initialised to 1 with declaration
    // De-assert reset for a little while, before asserting and de-asserting later
    #20 rst <= 0;
    #80 rst <= 1;
    #50 rst <= 0;
    // Finish stimulus after 200 ns
    #50 $finish;
  end

endmodule