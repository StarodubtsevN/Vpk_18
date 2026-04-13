`ifndef SYNTHESIS
module laba2_testbench();

localparam INPUT_W  = 3;
localparam OUTPUT_W = 24;
localparam SCK_DIV  = 14;
localparam DELAY    = OUTPUT_W / INPUT_W;

logic [2:0]  i_mosi;
logic        i_sck;
logic        i_ss;
logic        i_arstn;
logic        i_clk;
logic [23:0] o_data;
logic        o_valid;
logic [2:0]  o_miso;

logic [23:0] expected_data;
int error_cnt = 0;
int trans_cnt = 0;

initial begin
    i_clk = 0;
    forever #2.272727 i_clk = ~i_clk;
end

initial begin
    i_sck = 0;
    forever begin
        repeat(SCK_DIV/2) @(posedge i_clk);
        i_sck = ~i_sck;
    end
end

initial begin
    i_arstn = 0;
    #50;
    i_arstn = 1;
end

task automatic send_word(input logic [23:0] word);
    logic [2:0] nibble;
    i_ss = 0;
    @(posedge i_sck);
    for (int i = 0; i < DELAY; i++) begin
        nibble = word[23 - i*INPUT_W -: INPUT_W];
        i_mosi = nibble;
        if (i < DELAY-1) @(posedge i_sck);
    end
    @(posedge i_sck);
    i_ss = 1;
    @(posedge i_clk);
endtask

initial begin
    i_mosi = '0;
    i_ss   = 1;
    @(posedge i_arstn);
    repeat(10) @(posedge i_clk);

    expected_data = $urandom & 32'hFFFFFF;
    $display("=== Transaction 1: sending 0x%06h ===", expected_data);
    send_word(expected_data);
    @(posedge o_valid);
    if (o_data !== expected_data) begin
        $display("ERROR: got 0x%06h, expected 0x%06h", o_data, expected_data);
        error_cnt++;
    end else $display("OK: got 0x%06h", o_data);
    @(posedge i_clk);

    $display("\n=== Multiple transactions (3) ===");
    for (int t = 0; t < 3; t++) begin
        expected_data = $urandom & 32'hFFFFFF;
        $display("  Sending %0d: 0x%06h", t+1, expected_data);
        send_word(expected_data);
        @(posedge o_valid);
        if (o_data !== expected_data) begin
            $display("  ERROR: got 0x%06h", o_data);
            error_cnt++;
        end else $display("  OK");
        @(posedge i_clk);
    end

    $display("\n=== Boundary test ===");
    expected_data = 24'h000000;
    send_word(expected_data);
    @(posedge o_valid);
    if (o_data !== expected_data) error_cnt++;
    expected_data = 24'hFFFFFF;
    send_word(expected_data);
    @(posedge o_valid);
    if (o_data !== expected_data) error_cnt++;

    $display("\n======================================");
    if (error_cnt == 0)
        $display("PASS: %0d transactions OK.", trans_cnt+5);
    else
        $display("FAIL: %0d errors.", error_cnt);
    $stop;
end

always @(posedge o_valid) trans_cnt++;

laba2 dut (
    .i_mosi   (i_mosi),
    .i_sck    (i_sck),
    .i_ss     (i_ss),
    .i_arstn  (i_arstn),
    .i_clk    (i_clk),
    .o_data   (o_data),
    .o_valid  (o_valid),
    .o_miso   (o_miso)
);

endmodule
`endif