module lec6_testbench();
  logic        a;
  logic        b;
  logic        c;
  logic d;
  logic        y;
  logic clk;
  logic rst;
  logic enable = 1;
  // instantiate device under

  lec6 lec6_dut(
  .i_a(a),
  .i_b(b),
  .i_c(c),
  .i_d(d),
  .i_clk(clk),
  .i_arstn(rst),
  .i_enable(enable),
  .o_y(y)
  );
  // generate clock

  initial begin
    clk = '0;
    forever
      #10ns clk = ~ clk ;
  end

  // Reset state
    initial begin
    //   repeat (2) @ (posedge clk);
    // rst <= '1;
    //   repeat (2) @ (posedge clk);
    //   rst <= '0;
// end
      #10
      rst <= '0;
      #50ns
      rst <= '1;
  end

localparam NUM_ITER = 10;
logic [3:0] example[10] = '{1,2,3,4,5,6,7,8,9,10};

  initial begin
      for (int i = 0; i <= NUM_ITER; i++) begin

          a = example[i][0];
          b = example[i][1];
          c = example[i][2];
          d = example[i][3];

      $display("++ INPUT i  => %d {%d, %d, %d}", i, a, b, c); 
      @(posedge clk);

  //       if (y !== (a ^ b)) begin
  //           $display("FAIL %s", `__FILE__);
  //           $display("++ INPUT i  => %d {%d, %d, %d}", i, a, b, c);
  //           $display("++ EXPECTED => {%d}", a^b);
  //           $display("++ ACTUAL   => {%d}", y);
  //           $finish(1);
  //       end else begin
  //     $display ("PASS %s", `__FILE__);
  // end
      end
      //$finish;
      repeat (10) @ (posedge clk);
      $stop; 
  end
endmodule