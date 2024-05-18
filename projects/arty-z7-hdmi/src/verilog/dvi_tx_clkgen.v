// DVI TX clock gen module
module dvi_tx_clkgen (
                    input i_clk,                      // 125 MHz reference clock
                    input i_arst,                     // Aysnchronous board reset
                    output reg o_locked,                  // MMCM locked synchronised to reference clock
                    output o_pixel_clk,               // pixel clock
                    output o_serdes_framing_clk,      // serdes framing clock
                    output o_serdes_framing_clk_x5);  // serdes bit clock

// Signal Declarations
wire      w_srst;
wire      w_mmcm_locked;
wire      w_mmcm_locked_synced;
reg [1:0] state_mmcm_rst;
reg       r_mmcm_rst;
reg       r_bufr_rst;

wire      w_clkfb;
wire      w_pixel_clk;


parameter WAIT_LOCK = 2'b00;
parameter LOCKED    = 2'b01;
// Instantiate reset bridge module
// @TODO: check if this reset bridge is needed for synchronous 
//        de-assertion of the reset
rst_bridge rst_bridge_inst (.i_arst(i_arst),
                            .i_sclk(i_clk),
                            .o_srst(w_srst));

// Sync MMCM locked signal to the reference clock domain
sync_dff  sync_mmcm_locked_inst (.i_async(w_mmcm_locked),
                                 .i_sclk(i_clk),
                                 .o_sync(w_mmcm_locked_synced));

// @TODO: Check what is the significance of the below FSM
//        as I haven't used this before. Is it specific to DVI?
// Need to generate an MMCM reset pulse >= 5 ns (Xilinx DS191).
// We can use the reference clock to create the pulse. The fsm
// below will only work is the reference clk frequency is < 200MHz.
// The BUFR needs to be reset any time the MMCM acquires lock.      
always @(posedge i_clk or posedge w_srst) begin
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
        state_mmcm_rst <= WAIT_LOCK;
        r_mmcm_rst     <= 1'b0;
        r_bufr_rst     <= 1'b0;
      end
    endcase
  end
end

// MMCM instantiation below
MMCME2_ADV #(
      .BANDWIDTH("OPTIMIZED"),        // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(12.0),          // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000).
      // CLKIN_PERIOD: Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      .CLKIN1_PERIOD(8.0),
      .CLKIN2_PERIOD(0.0),
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for CLKOUT (1-128)
      .CLKOUT1_DIVIDE(30),
      .CLKOUT2_DIVIDE(1),
      .CLKOUT3_DIVIDE(1),
      .CLKOUT4_DIVIDE(1),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT0_DIVIDE_F(6.0),         // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for CLKOUT outputs (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for CLKOUT outputs (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(0.0),
      .CLKOUT2_PHASE(0.0),
      .CLKOUT3_PHASE(0.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      .CLKOUT4_CASCADE("FALSE"),      // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .COMPENSATION("ZHOLD"),         // ZHOLD, BUF_IN, EXTERNAL, INTERNAL
      .DIVCLK_DIVIDE(2),              // Master division value (1-106)
      // REF_JITTER: Reference input jitter in UI (0.000-0.999).
      .REF_JITTER1(0.0),
      .REF_JITTER2(0.0),
      .STARTUP_WAIT("FALSE"),         // Delays DONE until MMCM is locked (FALSE, TRUE)
      // Spread Spectrum: Spread Spectrum Attributes
      .SS_EN("FALSE"),                // Enables spread spectrum (FALSE, TRUE)
      .SS_MODE("CENTER_HIGH"),        // CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
      .SS_MOD_PERIOD(10000),          // Spread spectrum modulation period (ns) (VALUES)
      // USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
      .CLKFBOUT_USE_FINE_PS("FALSE"),
      .CLKOUT0_USE_FINE_PS("FALSE"),
      .CLKOUT1_USE_FINE_PS("FALSE"),
      .CLKOUT2_USE_FINE_PS("FALSE"),
      .CLKOUT3_USE_FINE_PS("FALSE"),
      .CLKOUT4_USE_FINE_PS("FALSE"),
      .CLKOUT5_USE_FINE_PS("FALSE"),
      .CLKOUT6_USE_FINE_PS("FALSE")
   )
   MMCME2_ADV_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(w_serdes_framing_clk_x5),           // 1-bit output: CLKOUT0
      .CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
      .CLKOUT1(w_pixel_clk),           // 1-bit output: CLKOUT1
      .CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
      .CLKOUT2(),           // 1-bit output: CLKOUT2
      .CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
      .CLKOUT3(),           // 1-bit output: CLKOUT3
      .CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
      .CLKOUT4(),           // 1-bit output: CLKOUT4
      .CLKOUT5(),           // 1-bit output: CLKOUT5
      .CLKOUT6(),           // 1-bit output: CLKOUT6
      // DRP Ports: 16-bit (each) output: Dynamic reconfiguration ports
      .DO(),                     // 16-bit output: DRP data
      .DRDY(),                 // 1-bit output: DRP ready
      // Dynamic Phase Shift Ports: 1-bit (each) output: Ports used for dynamic phase shifting of the outputs
      .PSDONE(),             // 1-bit output: Phase shift done
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(w_clkfb),         // 1-bit output: Feedback clock
      .CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
      // Status Ports: 1-bit (each) output: MMCM status ports
      .CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
      .CLKINSTOPPED(), // 1-bit output: Input clock stopped
      .LOCKED(w_mmcm_locked),             // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock inputs
      .CLKIN1(i_clk),             // 1-bit input: Primary clock
      .CLKIN2(1'b0),             // 1-bit input: Secondary clock
      // Control Ports: 1-bit (each) input: MMCM control ports
      .CLKINSEL(1'b1),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
      .PWRDWN(1'b0),             // 1-bit input: Power-down
      .RST(r_mmcm_rst),                   // 1-bit input: Reset
      // DRP Ports: 7-bit (each) input: Dynamic reconfiguration ports
      .DADDR(7'b0),               // 7-bit input: DRP address
      .DCLK(1'b0),                 // 1-bit input: DRP clock
      .DEN(1'b0),                   // 1-bit input: DRP enable
      .DI(16'b0),                     // 16-bit input: DRP data
      .DWE(1'b0),                   // 1-bit input: DRP write enable
      // Dynamic Phase Shift Ports: 1-bit (each) input: Ports used for dynamic phase shifting of the outputs
      .PSCLK(1'b0),               // 1-bit input: Phase shift clock
      .PSEN(1'b0),                 // 1-bit input: Phase shift enable
      .PSINCDEC(1'b0),         // 1-bit input: Phase shift increment/decrement
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(w_clkfb)            // 1-bit input: Feedback clock
   );

  BUFIO BUFIO_inst (
      .O(o_serdes_framing_clk_x5), // 1-bit output: Clock output (connect to I/O clock loads).
      .I(w_serdes_framing_clk_x5)  // 1-bit input: Clock input (connect to an IBUF or BUFMR).
   );

  // If the clock to the BUFR is stopped, then a reset (CLR) 
  // must be applied after the clock returns (see Xilinx UG472)
  BUFR #(
     .BUFR_DIVIDE("5"),   // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8" 
     .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES" 
  )
  BUFR_inst (
     .O(o_serdes_framing_clk),     // 1-bit output: Clock output port
     .CE(1'b1),   // 1-bit input: Active high, clock enable (Divided modes only)
     .CLR(r_bufr_rst), // 1-bit input: Active high, asynchronous clear (Divided modes only)
     .I(w_serdes_framing_clk_x5)      // 1-bit input: Clock buffer input driven by an IBUF, MMCM or local interconnect
  );

  // The tools will issue a warning that pixel clock is not 
  // phase aligned to sclk_x, w_serdes_framing_clk_x5. We can safely
  // ignore it as we don't care about the phase relationship
  // of the pixel clock to the sampling clocks.
  BUFG BUFG_inst (
     .O(o_pixel_clk), // 1-bit output: Clock output
     .I(w_pixel_clk)  // 1-bit input: Clock input
  );

  always @(posedge i_clk or negedge w_mmcm_locked) begin
    if (~w_mmcm_locked) begin
      o_locked <= 1'b0;
    end
    else begin
      // Raise locked only after BUFR has been reset
      if (r_bufr_rst) 
        o_locked <= 1'b1;
    end
  end 

endmodule