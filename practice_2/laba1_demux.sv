module laba1_demux(
  input logic       din,
  input logic [3:0] sel,
  output logic [8:0] dout);

    always_comb 
    begin
      dout = 9'b000000000;
        case (sel)
          4'b0000: dout[0] = din;
          4'b0001: dout[1] = din;
          4'b0010: dout[2] = din;
          4'b0011: dout[3] = din;
          4'b0100: dout[4] = din;
          4'b0101: dout[5] = din;
          4'b0110: dout[6] = din;
          4'b0111: dout[7] = din;
          4'b1000: dout[8] = din;
          default: dout = 9'b000000000;
        endcase
    end
  
endmodule