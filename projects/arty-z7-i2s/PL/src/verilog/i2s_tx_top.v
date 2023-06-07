/*
-- i2s_tx_top.v
-- Top level module of the i2s project
-- instantiates the below
-- 1. i2s_tx
-- 2. rom
-- 3. rom controller
-- 4. clock generator
*/
module i2s_tx_top
(
  input i_sys_clk,
  input i_sys_rst,
  // CS4344 I2S interface --begin
  output o_mclk,
  output o_lrclk,
  output o_sclk,
  output o_sd,
  output wire[3:0] led
);

//////////////////////////////////
// clock wizard instantiation
//////////////////////////////////
clk_wiz_0 i_mmcm
  (
    .reset    (i_sys_rst),
    .clk_in1  (i_sys_clk),
    .locked   (s_mmcm_locked),
    .clk_out1 (s_mclk)
  );

///////////////////////////////
// mclk to sclk instantiation
///////////////////////////////
i2s_mclk_2_sclk i_i2s_mclk_2_sclk
  (
    .i_mclk         (s_mclk),
    .i_mclk_rst     (s_mclk_rst),
    .o_sclk_ratioed (s_sclk_ratioed)
  );

//////////////////////////////////////////
// i2s transmitter block instantiation
//////////////////////////////////////////
i2s_tx i_i2s_tx
  (
    .i_sclk_ratioed (s_sclk_ratioed),
    .i_mclk_rst     (s_mclk_rst),
    .i_tx_data      (s_tx_data),
    .o_ready        (s_ready),
    .o_lrclk        (s_lrclk),
    .o_sclk         (s_sclk),
    .o_sd           (s_sd)
  );

//////////////////////////////////////////
// i2s rom controller block instantiation
//////////////////////////////////////////
i2s_rom_controller i_i2s_rom_controller
  (
    .i_mclk      (s_mclk),
    .i_mclk_rst  (s_mclk_rst),
    .i_rom_data  (s_rom_data),
    .i_ready     (s_ready),
    .o_rom_addr  (s_rom_addr),
    .o_tx_data   (s_tx_data)
  );

//////////////////////////////////////////
// i2s rom block instantiation
//////////////////////////////////////////
i2s_rom i_i2s_rom
  (
    .clka  (s_mclk),
    .ena   (1),
    .addra (s_rom_addr),
    .douta (s_rom_data)
  );

// Concurrent/output assignments
assign s_mclk_rst = !mmcm_locked;
assign o_mclk     = s_mclk;
assign o_lrclk    = s_lrclk;
assign o_sclk     = s_sclk;
assign o_sd       = s_sd;

// Debug code
assign o_led[3]   = s_lrclk;
assign o_led[2]   = s_sd;
assign o_led[1]   = s_mclk_rst;
assign o_led[0]   = s_mmcm_locked

endmodule i2s_tx_top