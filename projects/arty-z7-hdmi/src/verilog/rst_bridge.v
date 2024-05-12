module rst_bridge
  #(
    parameter P_ARST_POLARITY=1'b1,
    parameter P_SRST_POLARITY=1'b1
  ) (
    input i_arst,
    input i_sclk,
    output o_srst
);

// Local declarations
reg srst_d0_r;
reg srst_d1_r;

always @(posedge i_sclk or posedge i_arst)
  begin
    if(i_arst == P_ARST_POLARITY) begin
      srst_d0_r <= P_SRST_POLARITY;
      srst_d1_r <= P_SRST_POLARITY;
    end else begin
      srst_d0_r <= !(P_SRST_POLARITY);
      srst_d1_r <= srst_d0_r;
    end
  end

// Output assignment
assign o_srst = srst_d1_r;

endmodule


