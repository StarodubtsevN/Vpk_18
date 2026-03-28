//signed_add_whith_overflow_and_saturation
module pr3 #(
  parameter WIO = 4,
  parameter RANGE_N = 2 ** (WIO-1),
  parameter RANGE_P = RANGE_N - 1 
) ( 
  input           i_clk,
  input           i_valid,
  
  input [WIO-1:0] i_a,
  input [WIO-1:0] i_b,

  output            o_valid,
  output [WIO-1:0]  o_sum,
  output        o_overflow

);
  
  logic [3:0] sum_temp;
  logic overflow;
  always_ff @(posedge i_clk) 
  begin
      sum_temp <= i_a + i_b;
      o_valid <= i_valid;
  end

  
  assign o_overflow = (~i_a[WIO-1] & ~i_b[WIO-1] & sum_temp[WIO-1]) | (i_a[WIO-1] & i_b[WIO-1] & sum_temp[WIO-1]);

  assign o_sum = o_overflow ? (i_a[WIO-1] ? RANGE_N : RANGE_P) : sum_temp;

endmodule