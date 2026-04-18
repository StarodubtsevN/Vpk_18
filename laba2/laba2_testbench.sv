module laba2_testbench ();

parameter  INFO = 1;
parameter  NUM_ITER = 10;

parameter  WIO_TB = 8;
localparam MAX_RANGE = (2 ** WIO_TB) - 1;

parameter  CLK_PERIOD = 4.545ns; // 220 MHz

logic        clk = 0;
logic        arstn = 0;
logic        ss = 1;
logic        sck = 0;

logic [2:0]  mosi = 0;

logic [23:0] out_data;
logic        out_valid;
logic [2:0]  out_miso;

logic [WIO_TB : 0]     ethalon_data = 0;
int ethalon_data_array[NUM_ITER] = '{NUM_ITER{0}};
logic [WIO_TB : 0]     ethalon_data_out = 0;
int error_counter = 0;

localparam DELAY = OUTPUT_W / INPUT_W; // 8

laba2 laba2_inst(
  .i_mosi(mosi),
  .i_sck(sck),
  .i_ss(ss),
  .i_artsn(arstn),
  .i_clk(clk),

  .o_data(out_data),
  .o_valid(out_valid),
  .o_miso(out_miso),

);


initial begin
    forever begin
        #(CLK_PERIOD/2) clk = ~ clk;
    end
end

initial begin
    #10  arstn <= '0;
   #500 arstn <= '1;
end


initial begin
    @(negedge arstn);
    for (int i = 0; i < NUM_ITER; i ++) begin
        a = $urandom & 24'hffffff;     
        $display("++ INPUT i => %d {%d, %d, %d}", i, c);

		 ethalon_data[i] = {c};

        @(posedge clk);
    end
end


  
endmodule