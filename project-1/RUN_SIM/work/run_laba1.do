vlog ../laba1.sv
vlog ../laba1_testbench.sv

vsim -c work.laba1_testbench

add wave *

#run 100ns

run -a