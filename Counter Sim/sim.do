vlib work
vcom -93 -work work top.vhd
vcom -93 -work work blink_tb.vhd
vsim -voptargs=+acc blink_tb
do wave.do
run 500 ns
