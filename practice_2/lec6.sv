module lec6(
  input logic i_a,i_b,i_c,i_d,
  input logic i_clk,
  input logic i_arst,
  input logic i_arstn,
  input logic i_enable,
  output logic d);
  
  logic nor_ff;
  logic c_ff;
  logic d_ff1, d_ff2;
  logic nand_ff;

always_ff @ (posedge i_clk or negedge i_arst) begin 
  if (~(i_arstn)) begin
      nor_ff <= 0; 
      c_ff <= 0;
      d_ff1 <= 0;
      nand_ff <= 0;
      d_ff2 <= 0;
   end 
   else if (i_enable) begin    
    nor_ff <= ~(i_a | i_b); 
    c_ff <= i_c;
    d_ff1 <= i_d;
    nand_ff <= ~(nor_ff & c_ff);
    d_ff2 <= d_ff1;
  end
end

assign d = ~(d_ff2 & nand_ff);

endmodule







// // simple register
// always_ff @ (posedge clk) q <= d;
// // register with synchronous
// reset
// always_ff @ (posedge clk) begin
//   if (rst) begin
//     q <= '0;
//   end else begin
//     q <= d;
//   end
// end
// // register with synchronous
// reset
// // and enable signal
// always_ff @ (posedge clk) 
// begin
//   if (rst) begin
//     q <= '0;
//   end 
//   else if (enable) begin
//     q <= d;
//   end
// end

//     // register with asynchronous reset
// always_ff @ (posedge clk or negedge arst)
// begin
//   if ~(arst) begin
//     q <= '0;
//   end else begin
//     q <= d;
//   end
// end
// // register with asynchronous reset and
// enable signal
// always_ff @ (posedge clk or negedge arst)
// begin
//   if ~(arst) begin
//     q <= '0;
//   end else if (enable) begin
//     q <= d;
//   end
// end