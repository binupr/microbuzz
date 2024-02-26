module sync_dff
(
  input i_async,
  input i_sclk,
  output o_sync
);

// Local declarations
reg sync_d0_r;
reg sync_d1_r;

(* ASYNC_REG = "TRUE" *) reg sync_d0_r;
(* ASYNC_REG = "TRUE" *) reg sync_d1_r;


always@(posedge i_sclk)
  begin
    sync_d0_r <= i_async;
    sync_d1_r <= sync_d0_r;
  end

assign o_sync = sync_d1_r;

endmodule
  