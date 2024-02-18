// DVI TX clock gen module
module dvi_tx_clkgen (
                    input i_clk,                      // 125 MHz reference clock
                    input i_arst,                     // Aysnchronous board reset
                    output o_slocked,                  // MMCM locked synchronised to reference clock
                    output o_pixel_clk,               // pixel clock
                    output o_serdes_framing_clk,      // serdes framing clock
                    output o_serdes_framing_clk_x5);  // serdes bit clock

// Instantiate reset bridge module
// @TODO: check if this reset bridge is needed for synchronous 
//        de-assertion of the reset
rst_bridge rst_bridge_inst (.i_arst(i_arst),
                            .i_clk(i_clk),
                            .o_srst(w_srst));

// Sync MMCM locked signal to the reference clock domain
sync_dff  sync_mmcm_locked_inst (.i_async(w_mmcm_locked),
                                 .i_clk(i_clk),
                                 .o_sync(w_mmcm_locked_synced));

// @TODO: Check what is the significance of the below FSM
//        as I haven't used this before. Is it specific to DVI?
// Need to generate an MMCM reset pulse >= 5 ns (Xilinx DS191).
// We can use the reference clock to create the pulse. The fsm
// below will only work is the reference clk frequency is < 200MHz.
// The BUFR needs to be reset any time the MMCM acquires lock.      
always @(posedge i_clk, posedge w_srst) begin
  if (w_srst) begin
    state_mmcm_rst <= WAIT_LOCK;
    r_mmcm_rst     <= 1'b1;
    r_bufr_rst     <= 1'b0;
  end
  else begin
    r_mmcm_rst    <= 1'b0;
    r_bufr_rst    <= 1'b0;
    case (state_mmcm_rst)
      WAIT_LOCK: begin
        if (w_mmcm_locked_synced == 1'b1) begin
          r_bufr_rst  <= 1'b1;
          state_mmcm_rst <= LOCKED;
        end
      end
      LOCKED: begin
        if (w_mmcm_locked_synced == 1'b0) begin
          r_mmcm_rst      <= 1'b1;
          state_mmcm_rst  <= WAIT_LOCK;
        end
      end
      default: begin
        r_mmcm_rst  <= 1'b0;
        r_bufr_rst  <= 1'b0;
      end
    endcase
  end
end

// MMCM instantiation below




endmodule