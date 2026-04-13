module pract_3 #(
    parameter WIO = 4
) (
    input  logic             i_clk,
    input  logic             i_rst,

    input  logic             i_valid,
    input  logic [WIO-1:0]   i_a,
    input  logic [WIO-1:0]   i_b,

    output logic             o_valid,
    output logic [WIO-1:0]   o_sum,
    output logic             o_overflow
);

/////////////////////////////////////////////////////////////////////////////
// parameters and localparams
/////////////////////////////////////////////////////////////////////////////

// for signed data
// localparam RANGE_N = 1'b1 << (WIO-1); // 'b1000 = -8    'b10000000
// localparam RANGE_P = 2 ** (WIO-1) -1; // 'b0111 = 7

// for unsigned data
localparam RANGE_P = (2 ** WIO)-1; // 'b1111 = 15

/////////////////////////////////////////////////////////////////////////////
// signal declaration
/////////////////////////////////////////////////////////////////////////////

logic [WIO-1:0] a_rg;
logic [WIO-1:0] b_rg;

logic           valid_rg;

logic [WIO:0]   sum; // +1 to fix overflow
logic           overflow;
logic [WIO-1:0] sum_clip;

/////////////////////////////////////////////////////////////////////////////
// control ligic
/////////////////////////////////////////////////////////////////////////////

always_ff @(posedge i_clk) begin // what the reset type is? 
    if (i_rst) begin 
        valid_rg <= '0;
        o_valid  <= '0;
    end else begin
        valid_rg <= i_valid;
        o_valid  <= valid_rg;
    end
end

/////////////////////////////////////////////////////////////////////////////
// main sheme
/////////////////////////////////////////////////////////////////////////////

always_ff @(posedge i_clk) begin // 1 reg stage
    a_rg <= i_a;
    b_rg <= i_b;
end

assign sum = a_rg + b_rg;

always_comb begin
    overflow = sum[WIO];
    sum_clip = overflow ? RANGE_P : sum;
end

always_ff @(posedge i_clk) begin // 2 reg stage
    o_sum = sum_clip;
    o_overflow = overflow;
end

endmodule
