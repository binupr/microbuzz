module uart_button_top (input i_clk,
                        input i_rst,
                        input i_tx_enable,
                        input i_tx_parallel_data reg[7:0],
                        output o_rx_parallel_data reg[7:0],
                        input i_rx_serial_data,
                        output o_tx_serial_data);

  // Instaniate button debouncer
  button_debounce button_debounce_inst (.i_clk(i_clk),
                                        .i_rst(i_rst),
                                        .i_button_pre_debounce(i_tx_enable),
                                        .o_button_post_debounce(button_pressed));

  // Instantiate UART top
  uart_top uart_top_inst (.i_clk(i_clk),
                          .i_rst(i_rst),
                          .i_tx_start(button_pressed),
                          .i_tx_parallel_data(i_tx_parallel_data),
                          .o_rx_parallel_data(o_rx_parallel_data),
                          .i_rx_serial_data(i_rx_serial_data),
                          .o_tx_serial_data(o_tx_serial_data));

endmodule