# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "add_sub"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY top
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../add_sub.vhd
set_global_assignment -name VHDL_FILE ../../synchronizer_3bit.vhd
set_global_assignment -name VHDL_FILE ../../top.vhd

#control inputs
set_location_assignment PIN_AB12 -to reset
set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_AA15 -to add_btn
set_location_assignment PIN_AA14 -to sub_btn

set_location_assignment PIN_AC9  -to sw_a[0]
set_location_assignment PIN_AD10 -to sw_a[1]
set_location_assignment PIN_AE12 -to sw_a[2]

set_location_assignment PIN_AD11 -to sw_b[0]
set_location_assignment PIN_AD12 -to sw_b[1]
set_location_assignment PIN_AE11 -to sw_b[2]

set_location_assignment PIN_AA24 -to HEX4[0]
set_location_assignment PIN_Y23  -to HEX4[1]
set_location_assignment PIN_Y24  -to HEX4[2]
set_location_assignment PIN_W22  -to HEX4[3]
set_location_assignment PIN_W24  -to HEX4[4]
set_location_assignment PIN_V23  -to HEX4[5]
set_location_assignment PIN_W25  -to HEX4[6]

set_location_assignment PIN_AB23 -to HEX2[0]
set_location_assignment PIN_AE29 -to HEX2[1]
set_location_assignment PIN_AD29 -to HEX2[2]
set_location_assignment PIN_AC28 -to HEX2[3]
set_location_assignment PIN_AD30 -to HEX2[4]
set_location_assignment PIN_AC29 -to HEX2[5]
set_location_assignment PIN_AC30 -to HEX2[6]

set_location_assignment PIN_AE26 -to HEX0[0]
set_location_assignment PIN_AE27 -to HEX0[1]
set_location_assignment PIN_AE28 -to HEX0[2]
set_location_assignment PIN_AG27 -to HEX0[3]
set_location_assignment PIN_AF28 -to HEX0[4]
set_location_assignment PIN_AG28 -to HEX0[5]
set_location_assignment PIN_AH28 -to HEX0[6]


execute_flow -compile
project_close