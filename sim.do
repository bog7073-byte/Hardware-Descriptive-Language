vlib work
vcom -93 -work work top.vhd
vcom -93 -work work seven_seg.vhd
vsim -voptargs=+acc seven_seg
do wave.do
run 500 ns
