create_clock -name main_clk -period 4.545 [get_ports i_clk]
create_clock -name spi_clk -period 63.636 [get_ports i_sck]
