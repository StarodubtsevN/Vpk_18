module pract_3_tb();

/////////////////////////////////////////////////////////////////////////////
// parameters and localparams
/////////////////////////////////////////////////////////////////////////////

parameter  INFO = 1;
parameter  NUM_ITER = 10;

parameter  WIO_TB = 8;
localparam MAX_RANGE = (2 ** WIO_TB) - 1;

parameter  CLK_PERIOD = 10ns; // 100 MHz

/////////////////////////////////////////////////////////////////////////////
// signal declaration
/////////////////////////////////////////////////////////////////////////////

logic clk = 0;
logic rst = 0;

logic  [WIO_TB-1 : 0]    a = 0;
logic  [WIO_TB-1 : 0]    b = 0;
logic  [WIO_TB-1 : 0]    rezult;
logic                    overflow;

logic input_valid = 0;
logic output_valid;

logic [WIO_TB : 0]     ethalon_data = 0;
int ethalon_data_array[NUM_ITER] = '{NUM_ITER{0}};
logic [WIO_TB : 0]     ethalon_data_out = 0;
int error_counter = 0;

/////////////////////////////////////////////////////////////////////////////
// sheme install
/////////////////////////////////////////////////////////////////////////////

pract_3 #(
    .WIO(WIO_TB)
) dut (
    .i_clk      (clk),
    .i_rst      (rst),

    .i_valid    (input_valid),
    .i_a        (a), 
    .i_b        (b),

    .o_valid    (output_valid),
    .o_sum      (rezult),
    .o_overflow (overflow)
);

/////////////////////////////////////////////////////////////////////////////
// clk and reset generate
/////////////////////////////////////////////////////////////////////////////

initial begin
    forever begin
        #(CLK_PERIOD/2) clk = ~ clk;
    end
end

initial begin
    repeat (10) @ (posedge clk);
    rst <= '1;
    repeat (10) @ (posedge clk);
    rst <= '0;
end

/////////////////////////////////////////////////////////////////////////////
// send data
/////////////////////////////////////////////////////////////////////////////

initial begin

    @(negedge rst);
    repeat (10) @ (posedge clk);

    input_valid = 1; // control signal: start data transmit
    for (int i = 0; i < NUM_ITER; i ++) begin

        // generate random data and sends it to DUT
        a = $urandom & MAX_RANGE;
        b = $urandom & MAX_RANGE;

        // generate ethalon data and write it to array 
        ethalon_data = a + b;
        ethalon_data_array[i] = ethalon_data;
        if (INFO == 1) begin
            $display("INPUT: iteration = %d, a = %d, b = %d, ethalon_rezult = %d", i, a, b, ethalon_data);
        end

        @(posedge clk);
    end
    input_valid = 0; // control signal: stop data transmit

end

/////////////////////////////////////////////////////////////////////////////
// resieve data, check data and stop the test
/////////////////////////////////////////////////////////////////////////////

initial begin 
    
    @(posedge output_valid); // sinchronisation with DUT output
    @(posedge clk);

    for (int i = 0; i < NUM_ITER; i ++) begin

        ethalon_data_out = ethalon_data_array[i];

        if (rezult != ethalon_data_out) begin
            error_counter++;
            if (INFO == 1) begin
                $write ("OUTPUT: iteration %d", i);
                $write (", output_data %d", rezult);
                $write (", ethalon_data %d", ethalon_data_out);
                $write (", overflow %d", overflow);
                $write ("\n");
            end
        end
        @(posedge clk);
    end

    if (error_counter > 0) begin
        $display ("FAIL %s! NUMBER_OF_ERRORS = %d", `__FILE__, error_counter);
        $stop;
    end else begin 
        $display ("PASS %s", `__FILE__);
    end

    repeat (100) @ (posedge clk);
    $stop;

end

endmodule