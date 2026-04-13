module laba2(
    input  logic [2:0] i_mosi,
    input  logic       i_sck,
    input  logic       i_ss,
    input  logic       i_arstn,
    input  logic       i_clk,
    output logic [23:0] o_data,
    output logic        o_valid,
    output logic [2:0]  o_miso
);

    logic       enable;
    logic [23:0] q;
    logic [23:0] d;
    logic [2:0]  d_o;
    logic        counter_out;

    // Тристейт-буфер для o_miso
    always_comb begin
        case (i_ss)
            1'b0: d_o = i_mosi;
            1'b1: d_o = 3'bz;
            default: d_o = i_mosi;
        endcase
    end

    // Инстансы модуля register для q[23:0]
    genvar j;
    generate
        for (j = 0; j < 24; j++) begin : q_regs
            register reg_q (
                .i_clk   (i_clk),
                .i_en    (counter_out),
                .i_arstn (i_arstn),
                .i_d     (d[j]),
                .o_d     (q[j])
            );
        end
    endgenerate

    // Инстансы для o_miso[2:0]
    genvar k;
    generate
        for (k = 0; k < 3; k++) begin : miso_regs
            register reg_miso (
                .i_clk   (i_clk),
                .i_en    (1'b1),
                .i_arstn (i_arstn),
                .i_d     (d_o[k]),
                .o_d     (o_miso[k])
            );
        end
    endgenerate

    // Регистр для o_valid
    register reg_valid (
        .i_clk   (i_clk),
        .i_en    (1'b1),
        .i_arstn (i_arstn),
        .i_d     (counter_out),
        .o_d     (o_valid)
    );

    // Подмодули
    shift_register #(.INPUT_W(3), .OUTPUT_W(24)) shift_register_inst(
        .i_from   (i_mosi),
        .i_clk    (i_clk),
        .i_arstn  (i_arstn),
        .i_enable (enable),
        .o_to     (d)
    );

    counter #(.WIDTH(8)) counter_inst(
        .i_en    (enable),
        .i_clk   (i_clk),
        .i_arstn (i_arstn),
        .o_en    (counter_out)
    );

    logic sck_reg;
    always_ff @(posedge i_clk) sck_reg <= i_sck;
    assign enable = ~i_sck & sck_reg;
    // front_detector front_detector_inst(
    //     .i_clk (i_clk),
    //     .i_sck (i_sck),
    //     .o_en  (enable)
    // );

    assign o_data = q;

endmodule