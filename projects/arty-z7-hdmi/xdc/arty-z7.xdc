
# 125 MHz fabric clock
set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports {i_clk}];
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports {i_clk}];

set_property -dict {PACKAGE_PIN L17 IOSTANDARD TMDS_33} [get_ports o_dvi_clk_n]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD TMDS_33} [get_ports o_dvi_clk_p]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD TMDS_33} [get_ports o_dvi_red_n]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD TMDS_33} [get_ports o_dvi_red_p]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD TMDS_33} [get_ports o_dvi_blue_n]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD TMDS_33} [get_ports o_dvi_blue_p]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD TMDS_33} [get_ports o_dvi_green_n]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD TMDS_33} [get_ports o_dvi_green_p]

set_property -dict { PACKAGE_PIN D19    IOSTANDARD LVCMOS33 } [get_ports {i_rst}]; #IO_L4P_T0_35 Sch=BTN0