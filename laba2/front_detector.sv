module front_detector(
  input logic i_clk, i_sck,
  output logic o_en
);
logic q;

always_ff @(posedge i_clk) q <= i_sck;
assign o_en = i_sck & ~q;

endmodule