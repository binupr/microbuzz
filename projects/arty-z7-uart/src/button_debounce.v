module button_debounce (input i_clk,
                        input i_rst,
                        input i_button_pre_debounce,
                        output o_button_post_debounce);

  parameter COUNTER_SIZE = 10000;                     

  //  The input_flipflops process creates two serial flip-flops (flip-flop 1 and
  //  flip-flop 2). The signal from button_in passes them one by one. If flipflop_1
  //  and flipflop_2 are different, it means the button has been activated, and
  //  count_start becomes '1' for one master clock cycle.
  input_flipflops: always @(posedge i_clk) begin
    if (i_rst) begin
      flipflop_1 <= 1'b0;
      flipflop_2 <= 1'b0;
    end else begin
      flipflop_1 <= i_button_pre_debounce;
      flipflop_2 <= flipflop_1;
    end
  end

  // The count_start signal triggers the pause_counter process to start counting
  count_start <= flipflop_1 ^ flipflop_2;

  // The pause_counter process passes the button_in signal farther from flip-flop 2
  // to flip-flop 3, but after COUNTER_SIZE master clock cycles. This allows
  // the button_in signal to stabilize in a certain state before being passed to the output.
  pause_counter: always @(posedge i_clk) begin
    if (i_rst) begin
      count         <= 0;
      flipflop_3   <= 1'b0;
    end else begin
      if (count_start == 1'b1)
        count       <= 0;
      else if (count < COUNTER_SIZE)
        count       <= count + 1;
      else
        flipflop_3 <= flipflop_2;
    end
  end

  //  the purpose of the output_flipflop process is creating another flip-flop (flip-flop 4),
  //  which creates a delay between the flipflop_3 and flipflop_4 signals. The delay is
  //  one master clock cycle long.
  output_flipflop : always @(posedge i_clk) begin
    if (i_rst) 
      flipflop_4 <= 1'b0;
    else
      flipflop_4 <= flipflop_3;
  end

  // The delay is needed to create one short (one master clock cycle long) impuls
  // at the button_out output. When pause_counter has finished, the flipflop_3 signal gets
  // the button_in information. At the moment flipflop_4 hasn't changed yet.
  // This creates '1' at the button_out output for one master clock cycle, only if
  // flipflop_3 is '1' (The button has been pressed, not released).
  assign button_out <= flipflop_3 ? (flipflop_3 ^ flipflop_4) : 1'b0;

endmodule


