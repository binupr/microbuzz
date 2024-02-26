module tmds_encoder (
  input i_clk,          // pixel clock
  input i_pixel[7:0],        // pixel data
  input i_ctrl[1:0],         // control data
  input i_de,           // pixel data enable (not blanking)
  output o_tmds[9:0]
);

// Local declarations
wire qm_xor[8:0];
wire qm_xnor[8:0];
wire ones_pixel[3:0];
wire qm[8:0];

reg de_r;
reg ctrl_r[1:0];
reg qm_r[8:0];
wire ones_qm_x[3:0];
wire bias_r;
wire diff;
reg tmds_r[9:0];

// First stage: transition minimised encoding

assign qm_xor[0] = i_pixel[0];
assign qm_xor[8] = 1'b1;
encode_xor: generate 
  for(n=1; n <8 ; n++) begin
    qm_xor[n] <= qm_xor[n-1] ^ i_pixel[n];
  end
endgenerate

assign qm_xnor[0] = i_pixel[0];
assign qm_xnor[8] = 1'b1;
encode_xnor: generate 
  for(n=1; n <8 ; n++) begin
    qm_xnor[n] <= qm_xnor[n-1] ~^ i_pixel[n];
  end
endgenerate

// count the number of ones in the symbol
(for n=1; n <8; n++) begin
  sum = sum + i_pixel[n];
end
assign ones_pixel = sum;

// select encoding based on number of ones
assign qm = ((ones_pixel >4) || ((ones_pixel == 4) && (pixel_i[0] == 1'b0))) ? qm_xnor: qm_xor;

// Second stage: Fix DC bias
always@(posedge i_clk)
begin
  de_r   <= i_de;
  ctrl_r <= i_ctrl;
  qm_r   <= qm;
end

// count the number of ones in the encoded symbol
(for n=1; n <8; n++) begin
  sum = sum + qm_r[n];
end
assign ones_qm_x = sum;

// Calculate the difference between the number of ones (n1) and number of zeros (n0) in the encoded symbol
assign diff = {ones_qm_x, 1'b0} - 8; // n1 - n0 = 2 * n1 -8

always@(posedge i_clk)
begin
  if (de_r == 1'b0)
    begin
      case(ctrl_r)
        2'b00:   tmds_r <= 10'b1101010100;
        2'b01:   tmds_r <= 10'b0010101011;
        2'b10:   tmds_r <= 10'b0101010100;
        default: tmds_r <= 10'b1010101011;
      endcase
    end
  else
    begin
      if ((bias_r == 1'b0) || (diff == 4))
      begin
        if (qm_r[8] == 1'b0)
        begin
          tmds_r <= {2'b10, !(qm_r[7:0])};
          bias_r <= bias_r - diff;
        end
        else
        begin
          tmds_r <= {2'b01, qm_r[7:0]};
          bias_r <= bias_r + diff;
        end
      end
      else
      begin
        if (((bias_r > 1'b0) && (diff > 4)) || ((bias_r < 1'b0) && (diff <4)))
        begin
          tmds_r <= {1'b1, qm_r[8], !(qm_r[7:0])};
          if (qm_r[8] == 1'b0)
            bias_r <= bias_r - diff;
          else
            bias_r <= bias_r - diff + 2;
        end
        else
        begin
          tmds_r <= {1'b0, qm_r};
          if (qm_r[8] == 1'b0)
            bias_r <= bias_r + diff;
          else
            bias_r <= bias_r + diff - 2;
        end
      end 
end

// Output assignments
assign o_tmds = tmds_r;

endmodule
