# Both pinoout & timing constraints are included in this file
# This constraints file is based on https://github.com/Digilent/digilent-xdc/blob/master/Arty-Z7-10-Master.xdc
#******************************
# PIN allocations
#******************************
# Reset signal-- connect to BTN0
set_property -dict { PACKAGE_PIN D19    IOSTANDARD LVCMOS33 } [get_ports { i_sys_rst }]; #IO_L4P_T2_MRCC_35 Sch=SYSCLK
# Clock signal
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { i_sys_clk }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
## Pmod Header JA (referenced along with https://digilent.com/reference/pmod/pmodi2s2/reference-manual)
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { o_mclk }]; #IO_L17P_T2_34 Sch=JA1_P (Pin 1)
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { o_lrclk }]; #IO_L17N_T2_34 Sch=JA1_N (Pin 2)
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { o_sclk }]; #IO_L7P_T1_34 Sch=JA2_P (Pin 3)
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { o_sd }]; #IO_L7N_T1_34 Sch=JA2_N (Pin 4)
# LEDs
set_property -dict { PACKAGE_PIN R14    IOSTANDARD LVCMOS33 } [get_ports { o_led[0] }]; #IO_L6N_T0_VREF_34 Sch=LED0
set_property -dict { PACKAGE_PIN P14    IOSTANDARD LVCMOS33 } [get_ports { o_led[1] }]; #IO_L6P_T0_34 Sch=LED1
set_property -dict { PACKAGE_PIN N16    IOSTANDARD LVCMOS33 } [get_ports { o_led[2] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=LED2
set_property -dict { PACKAGE_PIN M14    IOSTANDARD LVCMOS33 } [get_ports { o_led[3] }]; #IO_L23P_T3_35 Sch=LED3
#******************************
# Timing constraints
#******************************
# PL clock is driven by Crystal oscillator at 125 MHz
create_clock -period 8 [get_ports i_sys_clk]

