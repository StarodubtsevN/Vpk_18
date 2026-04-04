module laba2_testbench();

localparam INPUT_W  = 3;
localparam OUTPUT_W = 24;
localparam CLK_FREQ = 220_000_000;  // 220 MHz
localparam SCK_DIV  = 14;            // i_sck = i_clk / 14
localparam DELAY    = OUTPUT_W / INPUT_W; // 8

logic [2:0]  i_mosi;
logic        i_sck;
logic        i_ss;
logic        i_arstn;
logic        i_clk;
logic [23:0] o_data;
logic        o_valid;
logic [2:0]  o_miso;

logic        sck_en;          
logic [31:0] sck_counter;     
logic [23:0] expected_data;   
logic [23:0] rx_data;         
int          error_cnt = 0;
int          transaction_cnt = 0;

initial begin
    i_clk = 0;
    forever #(2.272727ns) i_clk = ~i_clk;  // период 4.545454... нс
end

initial begin
    sck_counter = 0;
    i_sck = 0;
    forever @(posedge i_clk) begin
        if (sck_counter == (SCK_DIV/2 - 1)) begin
            i_sck <= ~i_sck;
            sck_counter <= 0;
        end else begin
            sck_counter <= sck_counter + 1;
        end
    end
end

initial begin
    i_arstn = 1'b0;
    #50ns;
    i_arstn = 1'b1;
end


task automatic send_word(input logic [23:0] word);
    int i;
    logic [2:0] nibble;

    i_ss = 1'b0;

    @(negedge i_sck);
    for (i = 0; i < DELAY; i++) begin

        nibble = word[23 - (i*INPUT_W) -: INPUT_W];
        i_mosi = nibble;

        @(negedge i_sck);
    end

    i_ss = 1'b1;
    @(posedge i_clk); 
endtask


initial begin

    i_mosi = '0;
    i_ss   = 1'b1;

    @(posedge i_arstn);
    repeat(10) @(posedge i_clk);
    
    expected_data = $urandom() & 32'hFFFFFF;  // случайное 24-битное
    $display("=== Transaction 1: sending 0x%06h ===", expected_data);
    send_word(expected_data);


    @(posedge o_valid);
    rx_data = o_data;
    if (rx_data !== expected_data) begin
        $display("ERROR: received 0x%06h, expected 0x%06h", rx_data, expected_data);
        error_cnt++;
    end else begin
        $display("OK: received 0x%06h", rx_data);
    end
    @(posedge i_clk); // дополнительный такт

    $display("\n=== Multiple transactions (3) ===");
    for (int t = 0; t < 3; t++) begin
        expected_data = $urandom() & 32'hFFFFFF;
        $display("  Sending word %0d: 0x%06h", t+1, expected_data);
        send_word(expected_data);
        @(posedge o_valid);
        rx_data = o_data;
        if (rx_data !== expected_data) begin
            $display("  ERROR: received 0x%06h, expected 0x%06h", rx_data, expected_data);
            error_cnt++;
        end else begin
            $display("  OK: received 0x%06h", rx_data);
        end
        @(posedge i_clk);
    end
    
    $display("\n=== Boundary test ===");
    expected_data = 24'h000000;
    $display("  Sending 0x000000");
    send_word(expected_data);
    @(posedge o_valid);
    if (o_data !== expected_data) error_cnt++;
    
    expected_data = 24'hFFFFFF;
    $display("  Sending 0xFFFFFF");
    send_word(expected_data);
    @(posedge o_valid);
    if (o_data !== expected_data) error_cnt++;
    
    // Итог
    $display("\n======================================");
    if (error_cnt == 0)
        $display("PASS: No errors detected in %0d transactions.", transaction_cnt + 5);
    else
        $display("FAIL: %0d errors detected.", error_cnt);
    $stop;
end

// Подсчёт транзакций 
always @(posedge o_valid) transaction_cnt++;


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