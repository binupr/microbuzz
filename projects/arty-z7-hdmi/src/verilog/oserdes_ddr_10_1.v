module oserdes_ddr_10_1 (
  input i_clk,
  input i_clk_x5,
  input i_arst,
  input [9:0] i_pdata,
  output o_sdata_p,
  output o_sdata_n 
);

rst_bridge oserdes_arst_inst (.i_arst(i_arst),
                              .i_clk(i_clk),
                              .o_srst(w_srst));

OSERDESE2 oserdes_master_inst #(.DATA_RATE_OQ("DDR"),
                                .DATA_RATE_TQ("SDR"),
                                .DATA_WIDTH(10),
                                .SERDES_MODE("MASTER"),
                                .TBYTE_CTL("FALSE"),
                                .TBYTE_SRC("FALSE"),
                                .TRISTATE_WIDTH(1)
                                )
                              (.OFB       (),
                               .OQ        (w_sdout),
                               .SHIFTOUT1 (),
                               .SHIFTOUT2 (),
                               .TBYTEOUT  (),
                               .TFB       (),
                               .TQ        (),
                               .CLK       (i_clk_x5),
                               .CLKDIV    (i_clk),
                               .D1        (i_pdata[0]),
                               .D2        (i_pdata[1]),
                               .D3        (i_pdata[2]),
                               .D4        (i_pdata[3]),
                               .D5        (i_pdata[4]),
                               .D6        (i_pdata[5]),
                               .D7        (i_pdata[6]),
                               .D8        (i_pdata[7]),
                               .OCE       (1'b1),
                               .RST       (w_rst),
                               .SHIFTIN1  (w_shift1),
                               .SHIFTIN2  (w_shift2),
                               .T1        (1'b0),
                               .T2        (1'b0),
                               .T3        (1'b0),
                               .T4        (1'b0),
                               .TBYTEIN   (1'b0),
                               .TCE       (1'b0)
                               );

OSERDESE2 oserdes_slave_inst #( .DATA_RATE_OQ("DDR"),
                                .DATA_RATE_TQ("SDR"),
                                .DATA_WIDTH(10),
                                .SERDES_MODE("SLAVE"),
                                .TBYTE_CTL("FALSE"),
                                .TBYTE_SRC("FALSE"),
                                .TRISTATE_WIDTH(1)
                                )
                              (.OFB       (),
                               .OQ        (),
                               .SHIFTOUT1 (w_shift1),
                               .SHIFTOUT2 (w_shift2),
                               .TBYTEOUT  (),
                               .TFB       (),
                               .TQ        (),
                               .CLK       (i_clk_x5),
                               .CLKDIV    (i_clk),
                               .D1        (1'b0),
                               .D2        (1'b0),
                               .D3        (i_pdata[8]),
                               .D4        (i_pdata[9]),
                               .D5        (1'b0),
                               .D6        (1'b0),
                               .D7        (1'b0),
                               .D8        (1'b0),
                               .OCE       (1'b1),
                               .RST       (w_rst),
                               .SHIFTIN1  (1'b0),
                               .SHIFTIN2  (1'b0),
                               .T1        (1'b0),
                               .T2        (1'b0),
                               .T3        (1'b0),
                               .T4        (1'b0),
                               .TBYTEIN   (1'b0),
                               .TCE       (1'b0)
                               );

OBUFDS tmds_obufds_inst #(.IOSTANDARD("TMDS_33"))
                        (.O(o_sdata_p),
                         .OB(o_sdata_n),
                         .I(w_sdout)
                         );

endmodule