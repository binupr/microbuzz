module dvi_tx_tb;
    logic clk;
    logic rst;

    // Generate a 125 MHz clock (8 ns period)
    always #4 clk = ~clk;

    // DUT instantiation
    dvi_tx dut (
        .i_clk(clk),
        .i_rst(rst),
        .o_dvi_clk_p(),
        .o_dvi_clk_n(),
        .o_dvi_red_p(),
        .o_dvi_red_n(),
        .o_dvi_blue_p(),
        .o_dvi_blue_n(),
        .o_dvi_green_p(),
        .o_dvi_green_n()
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;

        // Hold reset for 20 ns, then release
        #20 rst = 0;

        // Run the simulation for 500 ns
        #50000 $finish;
    end
endmodule
