#####################################################
# library work create
vlib work
#####################################################
# add libraryes

#set path C:/std_lib_10_6_viv_19_1
#vmap secureip     $path/secureip
#vmap simprims_ver $path/simprims_ver
#vmap unisims_ver  $path/unisims_ver
#vmap unimacro_ver $path/unimacro_ver
#vmap xpm          $path/xpm

# compile glbl file 

#vlog $path/glbl.v

#####################################################
# add and compile source project files

vlog ../laba1.sv
vlog ../laba1_mux.sv
vlog ../laba1_demux.sv
vlog ../laba1_mux_f_demux.sv
vlog ../laba1_testbench.sv
# vlog ../laba1_full_testbench.sv
#vlog ../dat_files/*.mem

#####################################################
# use top level testbench

# vsim -c work.laba1_full_testbench
vsim -c work.laba1_testbench


# add signals on waveform diagram
# add wave -radix decimal -group TOP sim:/testbench1/sillyfunction/*
add wave *
#####################################################
# run simulation
#run 100ns
run -a