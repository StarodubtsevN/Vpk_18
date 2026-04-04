library verilog;
use verilog.vl_types.all;
entity laba1_mux_f_demux is
    port(
        d0              : in     vl_logic_vector(3 downto 0);
        d1              : in     vl_logic_vector(3 downto 0);
        d2              : in     vl_logic_vector(3 downto 0);
        d3              : in     vl_logic_vector(3 downto 0);
        s               : in     vl_logic_vector(1 downto 0);
        sel             : in     vl_logic_vector(3 downto 0);
        dout            : out    vl_logic_vector(8 downto 0)
    );
end laba1_mux_f_demux;
