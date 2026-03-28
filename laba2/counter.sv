module counter(
  input logic i_en, i_clk, i_arstn,
  output logic o_en
);

parameter WIDTH = 24;
logic [WIDTH-1 : 0] count;
logic               local_reset;

always @(posedge i_clk or negedge i_arstn) begin
    if (!i_arstn) begin
        count <= '0;
    end else begin
   if (local_reset) begin
           count <= '0;
        end else if (i_en) begin
           count <= count + 1;
        end
    end
end


assign o_en = (count == (WIDTH-1));

endmodule