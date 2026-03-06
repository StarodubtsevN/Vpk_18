module laba1_testbench( 
  logic x1,x2,x3,x4,y;
  laba1 laba1_inst(x1,x2,x3,x4,y)
);

initial begin

  x1=0;x2=0;x3=0;x4=0; #10;
  x4=1;         #10;
  x3=1;x4=0;     #10;
  x4=1;         #10;
  x2=1;x3=0;x4=0; #10;
  x4=1;         #10;
  x3=1;x4=0;     #10;
  x4=1;         #10;
  x1=1;x2=0;x3=0;x4=0; #10;
  x4=1;         #10;
  x3=1;x4=0;     #10;
  x4=1;         #10;
  x2=1;x3=0;x4=0; #10;
  x4=1;         #10;
  x3=1;x4=0;     #10;
  x4=1;         #10;

end
  
endmodule

