// Top module of the HDMI/DVI design
module dvi_tx (input i_clk,
               input i_rst,
               output o_dvi_clk_p,
               output o_dvi_clk_n,
               output o_dvi_red_p,
               output o_dvi_red_n,
               output o_dvi_blue_p,
               output o_dvi_blue_n,
               output o_dvi_green_p,
               output o_dvi_green_n);

// Instantiate clock generator module
dvi_tx_clkgen dvi_tx_clk_gen_inst (.i_clk(i_clk),
                                   .i_arst(i_rst),
                                   .o_rst_no_mmcm_lock(w_rst_no_mmcm_lock),
                                   .o_pixel_clk(w_pixel_clk),
                                   .o_sclk(w_sclk),
                                   .o_sclk_x5(w_sclk_x5));

// Instantiate RGB timing module
rgb_timing rgb_timing_inst (.i_clk(w_pixel_clk),
                            .o_hsync(w_hsync),
                            .o_vsync(w_vsync),
                            .o_blank(w_blank));

// Instantiate pixel counter module
pixel_counter pixel_counter_inst (.i_clk(w_pixel_clk),
                                  .o_pixel_count(w_pixel_count));

// Instantiate RGB pattern module
rgb_pattern rgb_pattern_inst (.i_clk(w_pixel_clk),
                              .i_hsync(w_hsync),
                              .i_vsync(w_vsync),
                              .i_blank(w_blank),
                              .i_pixel_pos(w_pixel_count),
                              .o_hsync(w_hsync_r0),
                              .o_vsync(w_vsync_r0),
                              .o_blank(w_blank_r0),
                              .o_red(w_red),
                              .o_blue(w_blue),
                              .o_green(w_green));

// Instantiate RGB to DVI module
rgb_to_dvi rgb_to_dvi_inst (.i_sclk(w_sclk),
                            .i_sclk_x5(w_sclk_X5),
                            .i_pixel_clk(w_pixel_clk),
                            .i_arst(w_rst_no_mmcm_lock),
                            .i_red(w_red),
                            .i_blue(w_blue),
                            .i_green(w_green),
                            .i_hsync(w_hsync_r0),
                            .i_vsync(w_vsync_r0),
                            .i_blank(w_blank_r0),
                            .o_dvi_clk_p(o_dvi_clk_p),
                            .o_dvi_clk_n(o_dvi_clk_n),
                            .o_dvi_red_p(o_dvi_red_p),
                            .o_dvi_red_n(o_dvi_red_n),
                            .o_dvi_blue_p(o_dvi_blue_p),
                            .o_dvi_blue_n(o_dvi_blue_n),
                            .o_dvi_green_p(o_dvi_green_p),
                            .o_dvi_green_n(o_dvi_green_n));


endmodule