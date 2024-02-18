module rgb_to_dvi
(
  input i_sclk,
  input i_sclk_x5,
  input i_pixel_clk,
  input i_arst,
  input [7:0] i_red,
  input [7:0] i_green,
  input [7:0] i_blue,
  input i_hsync,
  input i_vsync,
  input i_blank,
  output o_dvi_clk_p,
  output o_dvi_clk_n,
  output o_dvi_tx0_p,
  output o_dvi_tx0_n,
  output o_dvi_tx1_p,
  output o_dvi_tx1_n,
  output o_dvi_tx2_p,
  output o_dvi_tx2_n
);

// Local declarations
wire [9:0] tmds_x[2:0];
wire [1:0] c0;
wire [1:0] c1;
wire [1:0] c2;
wire de;

// Wire assignments
assign de = ~ i_blank;
assign c0 = {i_vsync,i_hsync};
assign c1 = 2'b00;
assign c2 = 2'b00;


// Instantiate TMDS modules
tmds_encoder tmds_encoder_inst0 (.i_clk(i_pixel_clk),
                                 .i_pixel(i_blue),
                                 .i_ctrl(c0),
                                 .i_de(de),
                                 .o_tmds(tmds_x[0]));

tmds_encoder tmds_encoder_inst1 (.i_clk(i_pixel_clk),
                                 .i_pixel(i_green),
                                 .i_ctrl(c1),
                                 .i_de(de),
                                 .o_tmds(tmds_x[1]));

tmds_encoder tmds_encoder_inst2 (.i_clk(i_pixel_clk),
                                 .i_pixel(i_red),
                                 .i_ctrl(c2),
                                 .i_de(de),
                                 .o_tmds(tmds_x[2])); 

// Instantiate OSERDES modules 
oserdes_ddr_10_1 oserdex_tx_inst0 (.i_clk(i_sclk),
                                   .i_clk_x5(i_sclk_x5),
                                   .i_arst(i_arst),
                                   .i_pdata(tmds_x[0]),
                                   .o_sdata_p(o_dvi_tx0_p),
                                   .o_sdata_n(o_dvi_tx0_n));

oserdes_ddr_10_1 oserdex_tx_inst1 (.i_clk(i_sclk),
                                   .i_clk_x5(i_sclk_x5),
                                   .i_arst(i_arst),
                                   .i_pdata(tmds_x[1]),
                                   .o_sdata_p(o_dvi_tx1_p),
                                   .o_sdata_n(o_dvi_tx1_n)); 

oserdes_ddr_10_1 oserdex_tx_inst2 (.i_clk(i_sclk),
                                   .i_clk_x5(i_sclk_x5),
                                   .i_arst(i_arst),
                                   .i_pdata(tmds_x[2]),
                                   .o_sdata_p(o_dvi_tx2_p),
                                   .o_sdata_n(o_dvi_tx2_n)); 

oserdes_ddr_10_1 oserdex_clk_inst (.i_clk(i_sclk),
                                   .i_clk_x5(i_sclk_x5),
                                   .i_arst(i_arst),
                                   .i_pdata(10'b0000011111), // clock doesn't need tmds encoding, just output a pulse
                                   .o_sdata_p(o_dvi_clk_p),
                                   .o_sdata_n(o_dvi_clk_n));

endmodule                                                                                                                                      
                              