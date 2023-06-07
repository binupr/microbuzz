module uart_tx (input i_clk,
                input i_rst,
                input i_tx_start,
                input i_tx_parallel_data reg[7:0],
                output o_tx_serial_data);
  
  parameter BAUD_CLK_TICKS = 868 ; // i_clk/baud_rate (100 000 000 / 115 200 = 868.0555)
  // localparams to hold FSM states
  localparam IDLE  = 2'b00;
  localparam START = 2'b01;
  localparam DATA  = 2'b10;
  localparam STOP  = 2'b11;

  // The baud_rate_clk_generator process generates the UART baud rate clock by
  // setting the baud_rate_clk signal when the counter counts BAUD_CLK_TICKS
  // ticks of the master i_clk. The BAUD_CLK_TICKS constant is specified in
  // the package and reflects the ratio between the master i_clk and the baud rate.
  baud_rate_clk_generator: always @(posedge i_clk) begin
    if (i_rst) begin
      baud_rate_clk <= 0;
      baud_count    <= BAUD_CLK_TICKS - 1;
    end else begin
      if (baud_count == 0 ) begin
        baud_rate_clk <= 0;
        baud_count    <= BAUD_CLK_TICKS - 1;
      end else begin
        baud_rate_clk <= 1;
        baud_count    <= BAUD_CLK_TICKS - 1;
      end
    end
  end
  
  // The tx_start_detector process works on the master i_clk frequency and catches
  // short (one i_clk cycle long) impulses in the tx_start signal and keeps it for
  // the UART_tx_FSM. tx_start_detector is needed because the UART_tx_FSM works on
  // the baud rate frequency, but the button_debounce module generates one master i_clk
  // cycle long impulse per one button push. start_detected keeps the information that
  // such event has occurred.
  // The second purpose of tx_start_detector is to secure the transmitting data.
  // stored_data keeps the transmitting data saved during the transmission.
  tx_start_detector: always @(posedge i_clk) begin
    if (i_rst) || (start_rst) begin
      start_detected <= 0;
    end else begin
      if (tx_start) && (!start_detected) begin
        start_detected <= 1;
        stored_data    <= i_tx_parallel_data;
      end
    end
  end
  
  // The data_index_counter process is a simple counter from 0 to 7 working on the baud
  // rate frequency. It is used to perform transformation between the parallel
  // data (stored_data) and the serial output (tx_data_out).
  // The data_index signal is used in UART_tx_FSM to go over the stored_data vector
  // and send the bits one by one.
  data_index_counter: always @(posedge i_clk) begin
    if (i_rst) || (data_index_rst)
      data_index <= 0;
    elsif (baud_rate_clk)
      data_index <= data_index + 1;
  end
  
  // The UART_FSM_tx process represents a Finite State Machine which has
  // four states (IDLE, START, DATA, STOP). See inline comments for more details.
  uart_tx_fsm: always @(posedge i_clk) begin
    if (i_rst) begin
      tx_state         <= IDLE;
      data_index_rst   <= 1;
      start_rst        <= 1;
      o_tx_serial_data <= 1;
    end else begin
      if (baud_rate_clk == 1'b1) begin
        case (tx_state)
          IDLE: begin
            data_index_rst   <= 1'b1;
            start_rst        <= 1'b0;
            o_tx_serial_data <= 1'b1;
            if (start_detected == 1'b1)
              tx_state       <= START;
          end
          START: begin
            data_index_rst   <= 1'b0;
            o_tx_serial_data <= 1'b0;
            tx_state         <= DATA;
          end
          DATA: begin
            o_tx_serial_data <= stored_data(data_index);
            if (data_index == 'd7) begin
              data_index_rst <= 1'b1;
              tx_state       <= STOP;
            end
          end
          STOP: begin
            o_tx_serial_data <= 1'b1;
            start_rst        <= 1'b1;
            tx_state         <= IDLE;
          end
          default: 
            tx_state         <= IDLE;
        endcase
      end
    end
  end

endmodule
