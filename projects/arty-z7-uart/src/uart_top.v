module uart_top (input i_clk,
                 input i_rst,
                 input i_tx_start,
                 input i_tx_parallel_data reg[7:0],
                 output o_rx_parallel_data reg[7:0],
                 input i_rx_serial_data,
                 output o_tx_serial_data);

  // Instaniate UART Tx
  uart_tx uart_tx_inst (.i_clk(i_clk),
                        .i_rst(i_rst),
                        .i_tx_start(i_tx_start),
                        .i_tx_parallel_data(i_tx_parallel_data),
                        .o_tx_serial_data(o_tx_serial_data));

  // Instantiate UART Rx
  uart_tx uart_rx_inst (.i_clk(i_clk),
                        .i_rst(i_rst),
                        .i_rx_serial_data(i_rx_serial_data),
                        .o_rx_parallel_data(o_rx_parallel_data));

endmodule