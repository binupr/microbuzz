module tmds_encoder (
  input i_clk,          // pixel clock
  input wire [7:0] i_pixel,        // pixel data
  input wire [1:0] i_ctrl,         // control data
  input i_de,           // pixel data enable (not blanking)
  output wire [9:0] o_tmds
);

// Local declarations
wire [8:0] qm_xor;
wire [8:0] qm_xnor;
wire [3:0] ones_pixel;
wire [8:0] qm;

reg de_r;
reg [1:0] ctrl_r;
reg [8:0] qm_r;
wire [3:0] ones_qm_x;
reg bias_r;
wire diff;
reg [9:0] tmds_r;

wire [3:0] sum;

// First stage: transition minimised encoding

assign qm_xor[0] = i_pixel[0];
assign qm_xor[8] = 1'b1;
genvar n;
generate 
  for(n=1; n <8 ; n=n+1) begin: gen_encode_xor
    assign qm_xor[n] = qm_xor[n-1] ^ i_pixel[n];
  end
endgenerate

assign qm_xnor[0] = i_pixel[0];
assign qm_xnor[8] = 1'b1;
generate 
  for(n=1; n <8 ; n= n+1) begin: gen_encode_xnor
    assign qm_xnor[n] = qm_xnor[n-1] ~^ i_pixel[n];
  end
endgenerate

// count the number of ones in the symbol
for (n=1; n <8; n= n+1) begin: gen_ones_pixel
  assign sum = sum + i_pixel[n];
end
assign ones_pixel = sum;

// select encoding based on number of ones
assign qm = ((ones_pixel >4) || ((ones_pixel == 4) && (i_pixel[0] == 1'b0))) ? qm_xnor: qm_xor;

// Second stage: Fix DC bias
always@(posedge i_clk)
begin
  de_r   <= i_de;
  ctrl_r <= i_ctrl;
  qm_r   <= qm;
end

// count the number of ones in the encoded symbol
for (n=1; n <8; n=n+1) begin: gen_ones_qm
  assign sum = sum + qm_r[n];
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
end

// Output assignments
assign o_tmds = tmds_r;

endmodule
