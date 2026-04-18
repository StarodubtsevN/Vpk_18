module laba1(input logic a, b, c, d,
                    output logic y);
  assign y = a & ~b | ~a & ~b & ~c | ~c & ~d | a & c;
endmodule