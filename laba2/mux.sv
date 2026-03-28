module mux(input  logic [1:0] d0, d1,
    input logic [1:0] s,
    output logic [1:0] y);
    assign y = (s==0) ? d0 : d1;
endmodule