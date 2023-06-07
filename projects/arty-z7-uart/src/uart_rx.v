module uart_rx (input i_clk,
                input i_rst,
                input i_rx_serial_data,
                output o_rx_parallel_data reg[7:0]);

  parameter BAUD_x16_CLK_TICKS = 54; // (clk / baud_rate) / 16 => (100 000 000 / 115 200) / 16 = 54.25


// The baud_rate_x16_clk_generator process generates an oversampled clock.
// The baud_rate_x16_clk signal is 16 times faster than the baud rate clock.
// Oversampling is needed to put the capture point at the middle of duration of
// the receiving bit.
// The BAUD_X16_CLK_TICKS constant reflects the ratio between the master clk
// and the x16 baud rate. 
baud_rate_x16_clk_generator: always @(posedge i_clk) begin
  if (i_rst) begin
    baud_rate_x16_clk <= 1'b0;
    baud_x16_count    <= BAUD_x16_CLK_TICKS - 1;
  end else begin
    if (baud_x16_count == 0) begin
      baud_rate_x16_clk <= 1'b1;
      baud_x16_count    <= BAUD_x16_CLK_TICKS - 1; 
    end else begin
      baud_rate_x16_clk <= 1'b0;
      baud_x16_count    <= baud_x16_count - 1;
    end
  end
end

// The uart_rx_fsm process represents a Finite State Machine which has
// four states (IDLE, START, DATA, STOP). See inline comments for more details.
uart_rx_fsm: always @(posedge i_clk) begin
  if (i_rst) begin
    rx_state            <= IDLE;
    rx_stored_data      <= 0;
    o_rx_parallel_data  <= 0; 
    bit_duration_count  <= 0;
    bit_count           <= 0;
  end else begin
    if (baud_rate_x16_clk == 1'b1) begin
      case (rx_state)
        RX_IDLE: begin
          rx_stored_data      <= 0;
          bit_duration_count  <= 0;
          bit_count           <= 0;
          if (i_rx_serial_data == 1'b0)
            rx_state          <= RX_START;
        end
        RX_START: begin
          if (i_rx_serial_data == 1'b0) begin
            if (bit_duration_count == 'd7) begin
              rx_state          <= RX_DATA;
              bit_duration_count <= 0;
            end else
              bit_duration_count <= bit_duration_count + 1;
          end else
            rx_state            <= RX_IDLE;
        end
        RX_DATA: begin
          if (bit_duration_count == 'd15) begin
            rx_stored_data(bit_count) <= i_rx_serial_data;
            bit_duration_count        <= 0;
            if (bit_count == 'd7) begin
              rx_state                <= RX_STOP;
              bit_duration_count      <= 0;
            end else
              bit_count               <= bit_count + 1;
          end else
            bit_duration_count        <= bit_duration_count + 1;
        end
        RX_STOP: begin
          if (bit_duration_count == 'd15) begin
            o_rx_parallel_data        <= rx_stored_data;
            rx_state                  <= RX_IDLE;
          end else 
            bit_duration_count        <= bit_duration_count + 1;
        end
        default:
          rx_state                    <= RX_IDLE;
      endcase
    end
  end
end         


endmodule

