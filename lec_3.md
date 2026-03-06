
// мультиплексор
// ?
module lec_3(input  logic [3:0] d0, d1, d2, d3,
    input logic [1:0] s,
    output logic [3:0] y);
    // assign y = (s==0) ? d0 : 
    //         (s==1) ? d1 :
    //         (s==2) ? d2 : d3;
end
endmodule

//switch
module lec_3(input  logic [3:0] d0, d1, d2, d3,
    input logic [1:0] s,
    output logic [3:0] y);
always_comb begin
    case (s)
        0`d0: y = d0;
        1`d1: y = d1;
        2`d2: y = d2;
        3`d3: y = d3;
    endcase
end
endmodule

//vector
module lec_3(input  logic [3:0] d0, d1, d2, d3,
    input logic [1:0] s,
    output logic [3:0] y);

    logic [3:0] d [1:0];

assign d [0] = d0;
assign d [1] = d1;
assign d [2] = d2;
assign d [3] = d3;

assign y = d[s];

endmodule

