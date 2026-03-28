module pr3_testbench ();
  
logic [3:0]   a;
logic [3:0]   b;
logic [3:0]   c;
logic [3:0]   result;
logic         overflow;

parameter WIO_TB = 4;
parameter MAX_RANGE = (2 ** (WIO_TB)) - 1;

parameter NUM_ITER = 100;

int ethalon_data[NUM_ITER] = '{NUM_ITER{0}};

logic clk;

logic input_valid, output_valid;

pr3 dut #(
  .WIO(WIO_TB)
) (
  .i_clk(clk),

  .i_valid(input_valid),

  .i_a(a),
  .i_b(b),
  .i_clk(clk),

  .o_valid(output_valid),
  .o_sum(result),
  .o_overflow(overflow),

);

input_valid = 0;

initial begin
  #1000ns
  for (int i=0; i<n; ++i) begin
    a = $urandom & MAX_RANGE;
    b = $urandom & MAX_RANGE;
    ethalon_data[i]=a+b;
    input_valid = 1;
    $display("++ INPUT i => %d {%d, %d}", i_a, i_b);
    @(posedge clk)
  end

end


int error_counter = 0

initial begin // resieve and check data
    
    for (int i = 0; i < n; i ++) begin
        @(posedge output_valid);
        if (result !== ethalon_data[i]) begin
            error_counter++;
            $display ("output_data %d", result);
  $display ("ethalon_data %d", ethalon_data[i]);
        end
    end

    if (error_counter > 0) begin
        $display ("FAIL %s - see log above", `__FILE__);
        $stop;
    end

    repeat (100) @ (posedge clk);
    $display ("PASS %s", `__FILE__);
    $stop;
end

initial begin // send data
    @(negedge rst);
    for (int i = 0; i < n; i ++) begin
        a = $urandom & 1'b1;         // one bit random value
        b = $urandom & 8'hff;        // one byte random value
        c = $urandom & 32'hffffffff; // 32-bit random value
        $display("++ INPUT i => %d {%d, %d, %d}", i, a, b, c);
        @(posedge clk);
    end
end



endmodule