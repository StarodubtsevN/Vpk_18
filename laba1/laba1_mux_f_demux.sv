module laba1_mux_f_demux (
    input logic [3:0] d0, d1, d2, d3,
    input logic [1:0] s, 
    input logic [3:0] sel,
    output logic [8:0] dout 
);
    logic [3:0] mux_out;
    logic func_out; 

    laba1_mux laba1_mux_inst (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .s(s),
        .y(mux_out)
    );

    laba1 laba1_inst (
        .x1(mux_out[0]),
        .x2(mux_out[1]),
        .x3(mux_out[2]),
        .x4(mux_out[3]),
        .y(func_out)
    );

    laba1_demux laba1_demux_inst (
        .din(func_out),
        .sel(sel),
        .dout(dout)
    );

endmodule
