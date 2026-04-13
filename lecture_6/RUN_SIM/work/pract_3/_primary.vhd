library verilog;
use verilog.vl_types.all;
entity pract_3 is
    generic(
        WIO             : integer := 4
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        i_valid         : in     vl_logic;
        i_a             : in     vl_logic_vector;
        i_b             : in     vl_logic_vector;
        o_valid         : out    vl_logic;
        o_sum           : out    vl_logic_vector;
        o_overflow      : out    vl_logic
    );
end pract_3;
