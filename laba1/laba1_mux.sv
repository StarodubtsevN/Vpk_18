module laba1_mux(input  logic [3:0] d0, d1, d2, d3,
    input logic [1:0] s,
    output logic [3:0] y);
    assign y = (s==0) ? d0 : 
      (s==1) ? d1 :
      (s==2) ? d2 : d3;
endmodule