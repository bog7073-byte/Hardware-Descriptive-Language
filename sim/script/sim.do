vlib work
vcom -93 -work work ../../src/generic_adder_arch.vhd
vcom -93 -work work ../src/generic_adder_arch_tb.vhd
vsim -voptargs=+acc -msgmode both generic_adder_arch_tb
do wave.do
run 6 us