module laba1_testbench();  
    logic [4:0] d0, d1, d2, d3;
    logic [1:0] s;
    logic [3:0] sel;
    logic [8:0] dout;

  laba1_mux_f_demux laba1_mux_f_demux_inst(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .s(s),
    .sel(sel),
    .dout(dout)
  ); 

initial begin

  d0=0;d1=0;d2=0;d3=0;s=0;sel=0; #10;
  d3=1; sel=1;                #10;
  d2=1;d3=0; s=1; sel=0;           #10;
  d3=1; sel=1;                #10;
  d0=1;d2=0;d3=0; s=0; sel=0;      #10;
  d3=1; sel=1;                #10;
  d2=1;d3=0; s=1;sel=0;    #10;
  d3=1; sel=1;        #10;
  d0=1;d1=0;d2=0;d3=0; #10;
  d3=1;  s=0; sel=0;       #10;
  d2=1;d3=0; sel=1;    #10;
  d3=1; s=1;sel=0;        #10;
  d1=1;d2=0;d3=0; sel=1; #10;
  d3=1;  s=0;sel=0;       #10;
  d2=1;d3=0; sel=1;    #10;
  d3=1; s=1;sel=0;        #10;

end
  
endmodule

