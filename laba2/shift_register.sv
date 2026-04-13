module shift_register #(parameter INPUT_W=3, parameter OUTPUT_W=24) (
    input  logic [INPUT_W-1:0] i_from,
    input  logic i_clk,
    input  logic i_arstn,
    input  logic i_enable,
    output logic [OUTPUT_W-1:0] o_to
);
    localparam DELAY = OUTPUT_W / INPUT_W;  // = 8
    logic [DELAY-1:0] [INPUT_W-1:0] q;     // массив из 8 элементов по 3 бита

    always_ff @(posedge i_clk or negedge i_arstn) begin
        if (~i_arstn)
            q <= '{default: '0};
        else if (i_enable)
            q <= {q[DELAY-2:0], i_from};   // сдвиг: старые данные влево, новый — в конец
    end

    // Преобразование массива в плоскую шину (MSB first)
    always_comb begin
        for (int i = 0; i < DELAY; i++) begin
            o_to[OUTPUT_W - 1 - i*INPUT_W -: INPUT_W] = q[i];
        end
    end
endmodule