module laba2(
	input logic [2:0] i_mosi,
	input logic i_sck,
	input logic i_ss,
	input logic i_arstn,
	input logic i_clk, // системный такт 220 МГц

	output logic [23:0] o_data,
	output logic o_valid,
	output logic [2:0] o_miso
);

	logic enable;
	logic [23:0] q;
	logic [23:0] d;
	logic [2:0] d_o;
	logic counter_out;

	always_ff @(posedge i_clk or negedge i_arstn) begin
		if (~i_arstn) begin
			q <= '0;
		end else if (counter_out) begin
			q <= d;
		end
	end

	always_comb begin
		case (i_ss)
		1'b0: d_o = i_mosi;
		1'b1: d_o = 3'bz;
		default: d_o = i_mosi;
		endcase
	end

	always_ff @(posedge i_clk) o_miso <= d_o;
	always_ff @(posedge i_clk) o_valid <= counter_out;

	shift_register #(.INPUT_W(3), .OUTPUT_W(24)) shift_register_inst(
		.i_from (i_mosi),
		.i_clk (i_sck),
		.i_arstn (i_arstn),
		.i_enable (enable),
		.o_to (d)
	);

	counter #(.WIDTH(8)) counter_inst(
		.i_en (enable),
		.i_clk (i_clk),
		.i_arstn (i_arstn),
		.o_en (counter_out)
	);

	front_detector front_detector_inst(
		.i_clk (i_clk),
		.i_sck (i_sck),
		.o_en (enable)
	);

	assign o_data = q;

endmodule