library verilog;
use verilog.vl_types.all;
entity lec6 is
    port(
        i_a             : in     vl_logic;
        i_b             : in     vl_logic;
        i_c             : in     vl_logic;
        i_d             : in     vl_logic;
        i_clk           : in     vl_logic;
        i_arst          : in     vl_logic;
        i_arstn         : in     vl_logic;
        i_enable        : in     vl_logic;
        o_y             : out    vl_logic
    );
end lec6;
