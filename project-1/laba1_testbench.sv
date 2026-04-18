module laba1_testbench();

logic a, b, c, d, y;
laba1 dut(a, b, c, d, y);

initial begin
  a=0;b=0;c=0;d=0; #10;
  d=1;         #10;
  c=1;d=0;     #10;
  d=1;         #10;
  b=1;c=0;d=0; #10;
  d=1;         #10;
  c=1;d=0;     #10;
  d=1;         #10;
  a=1;b=0;c=0;d=0; #10;
  d=1;         #10;
  c=1;d=0;     #10;
  d=1;         #10;
  b=1;c=0;d=0; #10;
  d=1;         #10;
  c=1;d=0;     #10;
  d=1;         #10;

end

endmodule