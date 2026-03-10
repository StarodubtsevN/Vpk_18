library verilog;
use verilog.vl_types.all;
entity laba1_demux is
    port(
        din             : in     vl_logic;
        sel             : in     vl_logic_vector(3 downto 0);
        dout            : out    vl_logic_vector(8 downto 0)
    );
end laba1_demux;
