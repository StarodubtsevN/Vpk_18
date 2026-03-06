module laba1( input logic x1,x2,x3,x4,
output logic y);

assign y = (x1 & x2) | (x2 & x3) | (~x3 & ~x4) | (x1 & ~x4);
  
endmodule

