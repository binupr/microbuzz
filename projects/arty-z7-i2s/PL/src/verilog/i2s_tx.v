//////////////////////////////////
// i2s_tx.v
//////////////////////////////////

module i2s_tx
(
  input i_sclk_ratioed,
  input i_mclk_rst,
  input i_tx_data wire[((2**g_data_width) - 1):0],
  output o_ready,
  output o_lrclk,
  output o_sclk,
  output o_sd
);

//////////////////////////////////////////
// p_i2stx_fsm: process with FSM
// to send tx data serially out of the PL
//////////////////////////////////////////
always @(nedgedge i_sclk_ratioed)
  begin
    if (i_mclk_rst)
      begin
        w_i2stx_fsm = s_i2stx_idle;
        w_ready     = 0;
        w_lrdlk     = 1;
        w_enable    = 1;
        w_tx_buffer = 0;
      end
    else
      begin
        case (w_i2stx_fsm)
          s_i2stx_idle:
            w_i2stx_fsm = s_i2stx_load_buffer;
            w_ready     = 0;
            w_lrclk     = 1;
            w_enable    = 1;
            w_tx_buffer = 0;
            w_sd        = 0;
          s_i2stx_load_buffer:
            v_bit_counter := 0; // Review this line for later
            w_i2stx_fsm = s_i2stx_serialise_n_send;
            w_lrclk     = 0;
            w_tx_buffer = i_tx_data;
            w_sd        = 0;
          t_i2stx_serialise_n_send:
            v_bit_counter := v_bit_counter + 1; // Review this line for later
            if v_bit_counter > (g_data_width - 1)
              w_lrclk   = 1;
            if v_bit_counter <((2 * g_data_width) - 1)
              w_ready   = 0;
            else begin
              w_ready   = 1;
              w_i2stx_fsm = s_i2stx_load_buffer;
            end
              w_tx_buffer = {w_tx_buffer[((2**g_data_width) - 2):0], 4'b0};
              w_sd        = w_tx_buffer((2*g_data_width)-1);
        endcase
      end
  end

// Concurrent/output assignments
assign o_ready = w_ready;
assign o_lrclk = w_lrclk;
assign o_sclk  = i_sclk_ratioed & w_enable;
assign o_sd    = w_sd;




endmodule i2s_tx
