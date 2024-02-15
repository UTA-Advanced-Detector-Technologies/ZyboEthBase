#Clock signal
#set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports sysClk]
#create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports sysClk]

#set_false_path -from [get_clocks -include_generated_clocks sys_clk_pin] -to [get_clocks clk_fpga_0]
#set_false_path -from [get_clocks -include_generated_clocks clk_fpga_0] -to [get_clocks sys_clk_pin]
#set_false_path -from [get_clocks -include_generated_clocks clk_out1_design_1_clk_wiz_0_0_1] -to [get_clocks clk_fpga_0]
#set_false_path -from [get_clocks -include_generated_clocks clk_out1_design_1_clk_wiz_0_0] -to [get_clocks clk_fpga_0]
#set_false_path -from [get_clocks -include_generated_clocks clk_fpga_0] -to [get_clocks clk_out1_design_1_clk_wiz_0_0]
#set_false_path -from [get_clocks -include_generated_clocks clk_fpga_0] -to [get_clocks clk_out1_design_1_clk_wiz_0_0_1]
#set_multicycle_path -setup -from [get_clocks clk_out1_design_1_clk_wiz_0_0_1] -to [get_clocks clk_fpga_0] 2
#set_multicycle_path -hold -from [get_clocks clk_out1_design_1_clk_wiz_0_0_1] -to [get_clocks clk_fpga_0] 1
#set_multicycle_path -setup -from [get_clocks clk_out1_design_1_clk_wiz_0_0] -to [get_clocks clk_fpga_0] 2
#set_multicycle_path -hold -from [get_clocks clk_out1_design_1_clk_wiz_0_0] -to [get_clocks clk_fpga_0] 1

#set_multicycle_path -setup -from [get_clocks clk_fpga_0] -to [get_clocks clk_out1_design_1_clk_wiz_0_0_1] 2
#set_multicycle_path -setup -from [get_clocks clk_fpga_0] -to [get_clocks clk_out1_design_1_clk_wiz_0_0] 2
#set_multicycle_path -hold -from [get_clocks clk_fpga_0] -to [get_clocks clk_out1_design_1_clk_wiz_0_0] 1
#set_multicycle_path -hold -from [get_clocks clk_fpga_0] -to [get_clocks clk_out1_design_1_clk_wiz_0_0_1] 1

#set_false_path -through [get_nets daqRx]
#set_false_path -through [get_nets daqTx]

#LEDs
#set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
#set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
#set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
#set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {led[3]}]

#################################################################################
#Zybo Z20 things
#################################################################################

## This file is a general .xdc for the Zybo Z7 Rev. B
## It is compatible with the Zybo Z7-20 and Zybo Z7-10
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

##Clock signal
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=sysclk

##Switches
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {sw[1]}]
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {sw[2]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {sw[3]}]


##Buttons
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]; #IO_L12N_T1_MRCC_35 Sch=btn[0]
#set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L24N_T3_34 Sch=btn[1]
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L10P_T1_AD11P_35 Sch=btn[2]
#set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]; #IO_L7P_T1_34 Sch=btn[3]


#LEDs
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {led[3]}]

##RGB LED 5 (Zybo Z7-20 only)
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS33} [get_ports led5_r]
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports led5_g]
set_property -dict {PACKAGE_PIN Y12 IOSTANDARD LVCMOS33} [get_ports led5_b]

##RGB LED 6
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports led6_r]
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS33} [get_ports led6_g]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports led6_b]


##Audio Codec
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { ac_bclk }]; #IO_0_34 Sch=ac_bclk
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { ac_mclk }]; #IO_L19N_T3_VREF_34 Sch=ac_mclk
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { ac_muten }]; #IO_L23N_T3_34 Sch=ac_muten
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { ac_pbdat }]; #IO_L20N_T3_34 Sch=ac_pbdat
#set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33 } [get_ports { ac_pblrc }]; #IO_25_34 Sch=ac_pblrc
#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { ac_recdat }]; #IO_L19P_T3_34 Sch=ac_recdat
#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { ac_reclrc }]; #IO_L17P_T2_34 Sch=ac_reclrc
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports { ac_scl }]; #IO_L13P_T2_MRCC_34 Sch=ac_scl
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { ac_sda }]; #IO_L23P_T3_34 Sch=ac_sda


##Additional Ethernet signals
#set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33  PULLUP true    } [get_ports { eth_int_pu_b }]; #IO_L6P_T0_35 Sch=eth_int_pu_b
#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { eth_rst_b }]; #IO_L3P_T0_DQS_AD1P_35 Sch=eth_rst_b


##USB-OTG over-current detect pin
#set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { otg_oc }]; #IO_L3P_T0_DQS_PUDC_B_34 Sch=otg_oc


##Fan (Zybo Z7-20 only)
#set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS33  PULLUP true    } [get_ports { fan_fb_pu }]; #IO_L20N_T3_13 Sch=fan_fb_pu


##HDMI RX
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_hpd }]; #IO_L22N_T3_34 Sch=hdmi_rx_hpd
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_scl }]; #IO_L22P_T3_34 Sch=hdmi_rx_scl
#set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_sda }]; #IO_L17N_T2_34 Sch=hdmi_rx_sda
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD TMDS_33     } [get_ports { hdmi_rx_clk_n }]; #IO_L12N_T1_MRCC_34 Sch=hdmi_rx_clk_n
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD TMDS_33     } [get_ports { hdmi_rx_clk_p }]; #IO_L12P_T1_MRCC_34 Sch=hdmi_rx_clk_p
#set_property -dict { PACKAGE_PIN W20   IOSTANDARD TMDS_33     } [get_ports { hdmi_rx_n[0] }]; #IO_L16N_T2_34 Sch=hdmi_rx_n[0]
#set_property -dict { PACKAGE_PIN V20   IOSTANDARD TMDS_33     } [get_ports { hdmi_rx_p[0] }]; #IO_L16P_T2_34 Sch=hdmi_rx_p[0]
#set_property -dict { PACKAGE_PIN U20   IOSTANDARD TMDS_33     } [get_ports { hdmi_rx_n[1] }]; #IO_L15N_T2_DQS_34 Sch=hdmi_rx_n[1]
#set_property -dict { PACKAGE_PIN T20   IOSTANDARD TMDS_33     } [get_ports { hdmi_rx_p[1] }]; #IO_L15P_T2_DQS_34 Sch=hdmi_rx_p[1]
#set_property -dict { PACKAGE_PIN P20   IOSTANDARD TMDS_33     } [get_ports { hdmi_rx_n[2] }]; #IO_L14N_T2_SRCC_34 Sch=hdmi_rx_n[2]
#set_property -dict { PACKAGE_PIN N20   IOSTANDARD TMDS_33     } [get_ports { hdmi_rx_p[2] }]; #IO_L14P_T2_SRCC_34 Sch=hdmi_rx_p[2]

##HDMI RX CEC (Zybo Z7-20 only)
#set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_cec }]; #IO_L14N_T2_SRCC_13 Sch=hdmi_rx_cec


##HDMI TX
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_hpd }]; #IO_L5P_T0_AD9P_35 Sch=hdmi_tx_hpd
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_scl }]; #IO_L16P_T2_35 Sch=hdmi_tx_scl
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_sda }]; #IO_L16N_T2_35 Sch=hdmi_tx_sda
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD TMDS_33     } [get_ports { hdmi_tx_clk_n }]; #IO_L13N_T2_MRCC_35 Sch=hdmi_tx_clk_n
#set_property -dict { PACKAGE_PIN H16   IOSTANDARD TMDS_33     } [get_ports { hdmi_tx_clk_p }]; #IO_L13P_T2_MRCC_35 Sch=hdmi_tx_clk_p
#set_property -dict { PACKAGE_PIN D20   IOSTANDARD TMDS_33     } [get_ports { hdmi_tx_n[0] }]; #IO_L4N_T0_35 Sch=hdmi_tx_n[0]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD TMDS_33     } [get_ports { hdmi_tx_p[0] }]; #IO_L4P_T0_35 Sch=hdmi_tx_p[0]
#set_property -dict { PACKAGE_PIN B20   IOSTANDARD TMDS_33     } [get_ports { hdmi_tx_n[1] }]; #IO_L1N_T0_AD0N_35 Sch=hdmi_tx_n[1]
#set_property -dict { PACKAGE_PIN C20   IOSTANDARD TMDS_33     } [get_ports { hdmi_tx_p[1] }]; #IO_L1P_T0_AD0P_35 Sch=hdmi_tx_p[1]
#set_property -dict { PACKAGE_PIN A20   IOSTANDARD TMDS_33     } [get_ports { hdmi_tx_n[2] }]; #IO_L2N_T0_AD8N_35 Sch=hdmi_tx_n[2]
#set_property -dict { PACKAGE_PIN B19   IOSTANDARD TMDS_33     } [get_ports { hdmi_tx_p[2] }]; #IO_L2P_T0_AD8P_35 Sch=hdmi_tx_p[2]

##HDMI TX CEC
#set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L5N_T0_AD9N_35 Sch=hdmi_tx_cec

##Pmod Header JA (XADC)
set_property -dict {PACKAGE_PIN N15 IOSTANDARD TMDS_33} [get_ports QDA_IN_A_p]
set_property -dict {PACKAGE_PIN L14 IOSTANDARD TMDS_33} [get_ports QDA_OUT_A_p]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD TMDS_33} [get_ports QDA_IN_B_p]
set_property -dict {PACKAGE_PIN K14 IOSTANDARD TMDS_33} [get_ports QDA_OUT_B_p]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD TMDS_33} [get_ports QDA_IN_A_n]
set_property -dict {PACKAGE_PIN L15 IOSTANDARD TMDS_33} [get_ports QDA_OUT_A_n]
set_property -dict {PACKAGE_PIN J16 IOSTANDARD TMDS_33} [get_ports QDA_IN_B_n]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD TMDS_33} [get_ports QDA_OUT_B_n]

##Pmod Header JB (Zybo Z7-20 only)
set_property -dict {PACKAGE_PIN V8 IOSTANDARD TMDS_33} [get_ports QDA_IN_C_p]
set_property -dict {PACKAGE_PIN W8 IOSTANDARD TMDS_33} [get_ports QDA_IN_C_n]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD TMDS_33} [get_ports QDA_IN_D_p]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD TMDS_33} [get_ports QDA_IN_D_n]
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD TMDS_33} [get_ports QDA_OUT_C_p]
set_property -dict {PACKAGE_PIN Y6 IOSTANDARD TMDS_33} [get_ports QDA_OUT_C_n]
set_property -dict {PACKAGE_PIN V6 IOSTANDARD TMDS_33} [get_ports QDA_OUT_D_p]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD TMDS_33} [get_ports QDA_OUT_D_n]

###Pmod Header JC
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {dFsmState[0]}]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports {dFsmState[1]}]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {dFsmState[2]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports dLocFifoFull]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports dExtFifoFull]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports dRxBusy]
set_property -dict {PACKAGE_PIN T12 IOSTANDARD LVCMOS33} [get_ports dRxValid]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports dRxError]

###Pmod Header JD
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {TxDisable[0]}]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {TxDisable[1]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {TxDisable[2]}]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {TxDisable[3]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports IntSoft]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports IntHard]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports DigReset]
set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports dTxBusy]


### DebugOut in QDA has 9 pins
##Pmod Header JE
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {EndeavorScale[0]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {EndeavorScale[1]}]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {EndeavorScale[2]}]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {TxDisable[0]}]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {TxDisable[1]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {TxDisable[2]}]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {TxDisable[3]}]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD LVCMOS33} [get_ports dDataValid]


##Pcam MIPI CSI-2 Connector
## This configuration expects the sensor to use 672Mbps/lane = 336 MHz HS_Clk
#create_clock -period 2.976 -name dphy_hs_clock_clk_p -waveform {0.000 1.488} [get_ports dphy_hs_clock_clk_p]
#set_property INTERNAL_VREF 0.6 [get_iobanks 35]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD HSUL_12     } [get_ports { dphy_clk_lp_n }]; #IO_L10N_T1_AD11N_35 Sch=lp_clk_n
#set_property -dict { PACKAGE_PIN H20   IOSTANDARD HSUL_12     } [get_ports { dphy_clk_lp_p }]; #IO_L17N_T2_AD5N_35 Sch=lp_clk_p
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD HSUL_12     } [get_ports { dphy_data_lp_n[0] }]; #IO_L8N_T1_AD10N_35 Sch=lp_lane_n[0]
#set_property -dict { PACKAGE_PIN L19   IOSTANDARD HSUL_12     } [get_ports { dphy_data_lp_p[0] }]; #IO_L9P_T1_DQS_AD3P_35 Sch=lp_lane_p[0]
#set_property -dict { PACKAGE_PIN L20   IOSTANDARD HSUL_12     } [get_ports { dphy_data_lp_n[1] }]; #IO_L9N_T1_DQS_AD3N_35 Sch=lp_lane_n[1]
#set_property -dict { PACKAGE_PIN J20   IOSTANDARD HSUL_12     } [get_ports { dphy_data_lp_p[1] }]; #IO_L17P_T2_AD5P_35 Sch=lp_lane_p[1]
#set_property -dict { PACKAGE_PIN H18   IOSTANDARD LVDS_25     } [get_ports { dphy_hs_clock_clk_n }]; #IO_L14N_T2_AD4N_SRCC_35 Sch=mipi_clk_n
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVDS_25     } [get_ports { dphy_hs_clock_clk_p }]; #IO_L14P_T2_AD4P_SRCC_35 Sch=mipi_clk_p
#set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVDS_25     } [get_ports { dphy_data_hs_n[0] }]; #IO_L7N_T1_AD2N_35 Sch=mipi_lane_n[0]
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVDS_25     } [get_ports { dphy_data_hs_p[0] }]; #IO_L7P_T1_AD2P_35 Sch=mipi_lane_p[0]
#set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVDS_25     } [get_ports { dphy_data_hs_n[1] }]; #IO_L11N_T1_SRCC_35 Sch=mipi_lane_n[1]
#set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVDS_25     } [get_ports { dphy_data_hs_p[1] }]; #IO_L11P_T1_SRCC_35 Sch=mipi_lane_p[1]
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { cam_clk }]; #IO_L18P_T2_AD13P_35 Sch=cam_clk
#set_property -dict { PACKAGE_PIN G20   IOSTANDARD LVCMOS33 	PULLUP true} [get_ports { cam_gpio }]; #IO_L18N_T2_AD13N_35 Sch=cam_gpio
#set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports { cam_scl }]; #IO_L15N_T2_DQS_AD12N_35 Sch=cam_scl
#set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { cam_sda }]; #IO_L15P_T2_DQS_AD12P_35 Sch=cam_sda


##Unloaded Crypto Chip SWI (for future use)
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { crypto_sda }]; #IO_L13N_T2_MRCC_34 Sch=crypto_sda


##Unconnected Pins (Zybo Z7-20 only)
#set_property PACKAGE_PIN T9 [get_ports {netic19_t9}]; #IO_L12P_T1_MRCC_13
#set_property PACKAGE_PIN U10 [get_ports {netic19_u10}]; #IO_L12N_T1_MRCC_13
#set_property PACKAGE_PIN U5 [get_ports {netic19_u5}]; #IO_L19N_T3_VREF_13
#set_property PACKAGE_PIN U8 [get_ports {netic19_u8}]; #IO_L17N_T2_13
#set_property PACKAGE_PIN U9 [get_ports {netic19_u9}]; #IO_L17P_T2_13
#set_property PACKAGE_PIN V10 [get_ports {netic19_v10}]; #IO_L21N_T3_DQS_13
#set_property PACKAGE_PIN V11 [get_ports {netic19_v11}]; #IO_L21P_T3_DQS_13
#set_property PACKAGE_PIN V5 [get_ports {netic19_v5}]; #IO_L6N_T0_VREF_13
#set_property PACKAGE_PIN W10 [get_ports {netic19_w10}]; #IO_L16P_T2_13
#set_property PACKAGE_PIN W11 [get_ports {netic19_w11}]; #IO_L18P_T2_13
#set_property PACKAGE_PIN W9 [get_ports {netic19_w9}]; #IO_L16N_T2_13
#set_property PACKAGE_PIN Y9 [get_ports {netic19_y9}]; #IO_L14P_T2_SRCC_13

set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[0]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[11]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[14]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[15]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[18]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[48]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[50]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[57]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[16]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[42]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[2]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[5]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[40]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[22]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[34]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[49]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[21]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[10]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[20]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[24]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[25]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[38]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[55]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[60]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[9]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[12]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[45]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[23]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[30]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[37]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[62]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[36]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[1]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[6]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[44]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[27]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[28]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[33]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[59]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[61]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[4]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[3]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[8]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[17]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[47]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[46]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[54]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[56]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[39]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[26]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[29]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[32]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[35]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[51]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[53]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[63]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[7]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[13]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[41]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[19]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[31]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[43]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[52]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/dout[58]}]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/QDA_fifo_ren]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/rd_en]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/s_axi_tlast_r]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/s_axi_tvalid]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/s_fifo_ren]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/sel]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/S_AXIS_0_tready]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/S_AXIS_0_tvalid]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/S_AXIS_0_tlast]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/nPackets]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[15]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[0]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[3]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[6]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[17]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[22]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[30]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[23]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[24]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[26]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[28]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[14]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[2]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[7]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[8]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[10]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[16]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[19]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[21]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[29]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[1]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[9]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[25]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[13]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[4]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[5]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[11]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[12]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[18]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[20]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[27]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[31]}]
set_property MARK_DEBUG true [get_nets QDANode_U/fifo_rd_en]
set_property MARK_DEBUG true [get_nets QDANode_U/QDA_fifo_ren]
set_property MARK_DEBUG true [get_nets QDANode_U/qdaRxValid]
set_property MARK_DEBUG true [get_nets QDANode_U/rxByteAck]
set_property MARK_DEBUG true [get_nets QDANode_U/S_AXIS_0_tlast]
set_property MARK_DEBUG true [get_nets QDANode_U/S_AXIS_0_tready]
set_property MARK_DEBUG true [get_nets QDANode_U/S_AXIS_0_tvalid]
set_property MARK_DEBUG true [get_nets QDANode_U/valid]
set_property MARK_DEBUG true [get_nets QDANode_U/RxValid_reg_0]
set_property MARK_DEBUG true [get_nets QDANode_U/full]
set_property MARK_DEBUG true [get_nets {QDANode_U/QRx[0]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QRx[1]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QRx[2]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QRx[3]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QTx[0]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QTx[1]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QTx[2]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QTx[3]}]
set_property MARK_DEBUG true [get_nets QDANode_U/AXIS_QDAFifo_U/empty]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[16]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[15]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[20]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[31]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[37]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[55]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[61]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[9]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[6]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[4]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[44]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[17]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[38]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[32]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[62]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[63]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[50]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[45]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[40]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[42]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[28]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[39]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[60]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[35]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[36]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[27]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[10]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[3]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[53]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[14]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[46]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[29]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[41]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[0]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[5]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[19]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[33]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[43]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[49]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[51]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[56]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[8]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[2]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[34]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[22]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[25]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[26]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[1]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[12]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[11]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[21]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[23]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[30]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[52]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[54]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[13]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[7]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[47]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[48]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[18]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[24]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[57]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[58]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/din[59]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[0]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[1]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[38]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[6]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[60]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[13]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[20]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[35]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[29]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[36]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[37]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[45]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[52]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[57]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[43]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[8]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[9]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[42]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[59]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[17]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[24]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[28]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[14]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[11]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[15]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[22]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[23]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[26]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[54]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[56]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[34]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[4]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[7]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[48]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[19]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[32]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[49]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[51]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[62]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[25]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[12]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[16]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[58]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[63]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[27]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[55]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[30]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[31]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[41]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[5]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[2]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[3]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[40]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[46]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[61]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[39]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[53]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[33]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[10]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[18]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[21]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[44]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[47]}]
set_property MARK_DEBUG true [get_nets {QDANode_U/QDAFifo_U/dout[50]}]
set_property MARK_DEBUG true [get_nets QDANode_U/QDAFifo_U/empty]
set_property MARK_DEBUG true [get_nets QDANode_U/QDAFifo_U/full]
set_property MARK_DEBUG true [get_nets QDANode_U/QDAFifo_U/rd_en]
set_property MARK_DEBUG true [get_nets QDANode_U/QDAFifo_U/rst]
set_property MARK_DEBUG true [get_nets QDANode_U/QDAFifo_U/valid]
set_property MARK_DEBUG true [get_nets QDANode_U/QDAFifo_U/wr_en]
connect_debug_port u_ila_0/probe0 [get_nets [list {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[0]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[1]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[2]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[3]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[4]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[5]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[6]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[7]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[8]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[9]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[10]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[11]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[12]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[13]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[14]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[15]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[16]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[17]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[18]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[19]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[20]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[21]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[22]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[23]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[24]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[25]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[26]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[27]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[28]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[29]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[30]} {QDANode_U/AXIS_QDAFifo_U/s_axi_tdata_reg[31]_0[31]}]]
connect_debug_port u_ila_0/probe1 [get_nets [list {QDANode_U/AXIS_QDAFifo_U/dout[0]} {QDANode_U/AXIS_QDAFifo_U/dout[1]} {QDANode_U/AXIS_QDAFifo_U/dout[2]} {QDANode_U/AXIS_QDAFifo_U/dout[3]} {QDANode_U/AXIS_QDAFifo_U/dout[4]} {QDANode_U/AXIS_QDAFifo_U/dout[5]} {QDANode_U/AXIS_QDAFifo_U/dout[6]} {QDANode_U/AXIS_QDAFifo_U/dout[7]} {QDANode_U/AXIS_QDAFifo_U/dout[8]} {QDANode_U/AXIS_QDAFifo_U/dout[9]} {QDANode_U/AXIS_QDAFifo_U/dout[10]} {QDANode_U/AXIS_QDAFifo_U/dout[11]} {QDANode_U/AXIS_QDAFifo_U/dout[12]} {QDANode_U/AXIS_QDAFifo_U/dout[13]} {QDANode_U/AXIS_QDAFifo_U/dout[14]} {QDANode_U/AXIS_QDAFifo_U/dout[15]} {QDANode_U/AXIS_QDAFifo_U/dout[16]} {QDANode_U/AXIS_QDAFifo_U/dout[17]} {QDANode_U/AXIS_QDAFifo_U/dout[18]} {QDANode_U/AXIS_QDAFifo_U/dout[19]} {QDANode_U/AXIS_QDAFifo_U/dout[20]} {QDANode_U/AXIS_QDAFifo_U/dout[21]} {QDANode_U/AXIS_QDAFifo_U/dout[22]} {QDANode_U/AXIS_QDAFifo_U/dout[23]} {QDANode_U/AXIS_QDAFifo_U/dout[24]} {QDANode_U/AXIS_QDAFifo_U/dout[25]} {QDANode_U/AXIS_QDAFifo_U/dout[26]} {QDANode_U/AXIS_QDAFifo_U/dout[27]} {QDANode_U/AXIS_QDAFifo_U/dout[28]} {QDANode_U/AXIS_QDAFifo_U/dout[29]} {QDANode_U/AXIS_QDAFifo_U/dout[30]} {QDANode_U/AXIS_QDAFifo_U/dout[31]} {QDANode_U/AXIS_QDAFifo_U/dout[32]} {QDANode_U/AXIS_QDAFifo_U/dout[33]} {QDANode_U/AXIS_QDAFifo_U/dout[34]} {QDANode_U/AXIS_QDAFifo_U/dout[35]} {QDANode_U/AXIS_QDAFifo_U/dout[36]} {QDANode_U/AXIS_QDAFifo_U/dout[37]} {QDANode_U/AXIS_QDAFifo_U/dout[38]} {QDANode_U/AXIS_QDAFifo_U/dout[39]} {QDANode_U/AXIS_QDAFifo_U/dout[40]} {QDANode_U/AXIS_QDAFifo_U/dout[41]} {QDANode_U/AXIS_QDAFifo_U/dout[42]} {QDANode_U/AXIS_QDAFifo_U/dout[43]} {QDANode_U/AXIS_QDAFifo_U/dout[44]} {QDANode_U/AXIS_QDAFifo_U/dout[45]} {QDANode_U/AXIS_QDAFifo_U/dout[46]} {QDANode_U/AXIS_QDAFifo_U/dout[47]} {QDANode_U/AXIS_QDAFifo_U/dout[48]} {QDANode_U/AXIS_QDAFifo_U/dout[49]} {QDANode_U/AXIS_QDAFifo_U/dout[50]} {QDANode_U/AXIS_QDAFifo_U/dout[51]} {QDANode_U/AXIS_QDAFifo_U/dout[52]} {QDANode_U/AXIS_QDAFifo_U/dout[53]} {QDANode_U/AXIS_QDAFifo_U/dout[54]} {QDANode_U/AXIS_QDAFifo_U/dout[55]} {QDANode_U/AXIS_QDAFifo_U/dout[56]} {QDANode_U/AXIS_QDAFifo_U/dout[57]} {QDANode_U/AXIS_QDAFifo_U/dout[58]} {QDANode_U/AXIS_QDAFifo_U/dout[59]} {QDANode_U/AXIS_QDAFifo_U/dout[60]} {QDANode_U/AXIS_QDAFifo_U/dout[61]} {QDANode_U/AXIS_QDAFifo_U/dout[62]} {QDANode_U/AXIS_QDAFifo_U/dout[63]}]]
connect_debug_port u_ila_0/probe6 [get_nets [list QDANode_U/AXIS_QDAFifo_U/empty]]
connect_debug_port u_ila_0/probe12 [get_nets [list QDANode_U/QDA_fifo_ren]]
connect_debug_port u_ila_0/probe13 [get_nets [list QDANode_U/AXIS_QDAFifo_U/QDA_fifo_ren]]
connect_debug_port u_ila_0/probe14 [get_nets [list QDANode_U/qdaRxValid]]
connect_debug_port u_ila_0/probe15 [get_nets [list QDANode_U/AXIS_QDAFifo_U/rd_en]]
connect_debug_port u_ila_0/probe18 [get_nets [list QDANode_U/RxValid_reg_0]]
connect_debug_port u_ila_0/probe21 [get_nets [list QDANode_U/S_AXIS_0_tlast]]
connect_debug_port u_ila_0/probe22 [get_nets [list QDANode_U/AXIS_QDAFifo_U/S_AXIS_0_tlast]]
connect_debug_port u_ila_0/probe23 [get_nets [list QDANode_U/AXIS_QDAFifo_U/S_AXIS_0_tready]]
connect_debug_port u_ila_0/probe24 [get_nets [list QDANode_U/S_AXIS_0_tready]]
connect_debug_port u_ila_0/probe25 [get_nets [list QDANode_U/AXIS_QDAFifo_U/S_AXIS_0_tvalid]]
connect_debug_port u_ila_0/probe26 [get_nets [list QDANode_U/S_AXIS_0_tvalid]]
connect_debug_port u_ila_0/probe28 [get_nets [list QDANode_U/AXIS_QDAFifo_U/sel]]


connect_debug_port u_ila_0/probe10 [get_nets [list QDANode_U/rxByteAck]]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list design_1_U/design_1_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 4 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {QDANode_U/QRx[0]} {QDANode_U/QRx[1]} {QDANode_U/QRx[2]} {QDANode_U/QRx[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 4 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {QDANode_U/QTx[0]} {QDANode_U/QTx[1]} {QDANode_U/QTx[2]} {QDANode_U/QTx[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 64 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {QDANode_U/QDAFifo_U/din[0]} {QDANode_U/QDAFifo_U/din[1]} {QDANode_U/QDAFifo_U/din[2]} {QDANode_U/QDAFifo_U/din[3]} {QDANode_U/QDAFifo_U/din[4]} {QDANode_U/QDAFifo_U/din[5]} {QDANode_U/QDAFifo_U/din[6]} {QDANode_U/QDAFifo_U/din[7]} {QDANode_U/QDAFifo_U/din[8]} {QDANode_U/QDAFifo_U/din[9]} {QDANode_U/QDAFifo_U/din[10]} {QDANode_U/QDAFifo_U/din[11]} {QDANode_U/QDAFifo_U/din[12]} {QDANode_U/QDAFifo_U/din[13]} {QDANode_U/QDAFifo_U/din[14]} {QDANode_U/QDAFifo_U/din[15]} {QDANode_U/QDAFifo_U/din[16]} {QDANode_U/QDAFifo_U/din[17]} {QDANode_U/QDAFifo_U/din[18]} {QDANode_U/QDAFifo_U/din[19]} {QDANode_U/QDAFifo_U/din[20]} {QDANode_U/QDAFifo_U/din[21]} {QDANode_U/QDAFifo_U/din[22]} {QDANode_U/QDAFifo_U/din[23]} {QDANode_U/QDAFifo_U/din[24]} {QDANode_U/QDAFifo_U/din[25]} {QDANode_U/QDAFifo_U/din[26]} {QDANode_U/QDAFifo_U/din[27]} {QDANode_U/QDAFifo_U/din[28]} {QDANode_U/QDAFifo_U/din[29]} {QDANode_U/QDAFifo_U/din[30]} {QDANode_U/QDAFifo_U/din[31]} {QDANode_U/QDAFifo_U/din[32]} {QDANode_U/QDAFifo_U/din[33]} {QDANode_U/QDAFifo_U/din[34]} {QDANode_U/QDAFifo_U/din[35]} {QDANode_U/QDAFifo_U/din[36]} {QDANode_U/QDAFifo_U/din[37]} {QDANode_U/QDAFifo_U/din[38]} {QDANode_U/QDAFifo_U/din[39]} {QDANode_U/QDAFifo_U/din[40]} {QDANode_U/QDAFifo_U/din[41]} {QDANode_U/QDAFifo_U/din[42]} {QDANode_U/QDAFifo_U/din[43]} {QDANode_U/QDAFifo_U/din[44]} {QDANode_U/QDAFifo_U/din[45]} {QDANode_U/QDAFifo_U/din[46]} {QDANode_U/QDAFifo_U/din[47]} {QDANode_U/QDAFifo_U/din[48]} {QDANode_U/QDAFifo_U/din[49]} {QDANode_U/QDAFifo_U/din[50]} {QDANode_U/QDAFifo_U/din[51]} {QDANode_U/QDAFifo_U/din[52]} {QDANode_U/QDAFifo_U/din[53]} {QDANode_U/QDAFifo_U/din[54]} {QDANode_U/QDAFifo_U/din[55]} {QDANode_U/QDAFifo_U/din[56]} {QDANode_U/QDAFifo_U/din[57]} {QDANode_U/QDAFifo_U/din[58]} {QDANode_U/QDAFifo_U/din[59]} {QDANode_U/QDAFifo_U/din[60]} {QDANode_U/QDAFifo_U/din[61]} {QDANode_U/QDAFifo_U/din[62]} {QDANode_U/QDAFifo_U/din[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 64 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {QDANode_U/QDAFifo_U/dout[0]} {QDANode_U/QDAFifo_U/dout[1]} {QDANode_U/QDAFifo_U/dout[2]} {QDANode_U/QDAFifo_U/dout[3]} {QDANode_U/QDAFifo_U/dout[4]} {QDANode_U/QDAFifo_U/dout[5]} {QDANode_U/QDAFifo_U/dout[6]} {QDANode_U/QDAFifo_U/dout[7]} {QDANode_U/QDAFifo_U/dout[8]} {QDANode_U/QDAFifo_U/dout[9]} {QDANode_U/QDAFifo_U/dout[10]} {QDANode_U/QDAFifo_U/dout[11]} {QDANode_U/QDAFifo_U/dout[12]} {QDANode_U/QDAFifo_U/dout[13]} {QDANode_U/QDAFifo_U/dout[14]} {QDANode_U/QDAFifo_U/dout[15]} {QDANode_U/QDAFifo_U/dout[16]} {QDANode_U/QDAFifo_U/dout[17]} {QDANode_U/QDAFifo_U/dout[18]} {QDANode_U/QDAFifo_U/dout[19]} {QDANode_U/QDAFifo_U/dout[20]} {QDANode_U/QDAFifo_U/dout[21]} {QDANode_U/QDAFifo_U/dout[22]} {QDANode_U/QDAFifo_U/dout[23]} {QDANode_U/QDAFifo_U/dout[24]} {QDANode_U/QDAFifo_U/dout[25]} {QDANode_U/QDAFifo_U/dout[26]} {QDANode_U/QDAFifo_U/dout[27]} {QDANode_U/QDAFifo_U/dout[28]} {QDANode_U/QDAFifo_U/dout[29]} {QDANode_U/QDAFifo_U/dout[30]} {QDANode_U/QDAFifo_U/dout[31]} {QDANode_U/QDAFifo_U/dout[32]} {QDANode_U/QDAFifo_U/dout[33]} {QDANode_U/QDAFifo_U/dout[34]} {QDANode_U/QDAFifo_U/dout[35]} {QDANode_U/QDAFifo_U/dout[36]} {QDANode_U/QDAFifo_U/dout[37]} {QDANode_U/QDAFifo_U/dout[38]} {QDANode_U/QDAFifo_U/dout[39]} {QDANode_U/QDAFifo_U/dout[40]} {QDANode_U/QDAFifo_U/dout[41]} {QDANode_U/QDAFifo_U/dout[42]} {QDANode_U/QDAFifo_U/dout[43]} {QDANode_U/QDAFifo_U/dout[44]} {QDANode_U/QDAFifo_U/dout[45]} {QDANode_U/QDAFifo_U/dout[46]} {QDANode_U/QDAFifo_U/dout[47]} {QDANode_U/QDAFifo_U/dout[48]} {QDANode_U/QDAFifo_U/dout[49]} {QDANode_U/QDAFifo_U/dout[50]} {QDANode_U/QDAFifo_U/dout[51]} {QDANode_U/QDAFifo_U/dout[52]} {QDANode_U/QDAFifo_U/dout[53]} {QDANode_U/QDAFifo_U/dout[54]} {QDANode_U/QDAFifo_U/dout[55]} {QDANode_U/QDAFifo_U/dout[56]} {QDANode_U/QDAFifo_U/dout[57]} {QDANode_U/QDAFifo_U/dout[58]} {QDANode_U/QDAFifo_U/dout[59]} {QDANode_U/QDAFifo_U/dout[60]} {QDANode_U/QDAFifo_U/dout[61]} {QDANode_U/QDAFifo_U/dout[62]} {QDANode_U/QDAFifo_U/dout[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list QDANode_U/QDAFifo_U/empty]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list QDANode_U/fifo_rd_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list QDANode_U/full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list QDANode_U/QDAFifo_U/full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list QDANode_U/AXIS_QDAFifo_U/nPackets]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list QDAsend]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list QDANode_U/QDAFifo_U/rd_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list QDANode_U/AXIS_QDAFifo_U/s_axi_tlast_r]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list QDANode_U/AXIS_QDAFifo_U/s_axi_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list QDANode_U/AXIS_QDAFifo_U/s_fifo_ren]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list QDANode_U/QDAFifo_U/valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list QDANode_U/valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list QDANode_U/QDAFifo_U/wr_en]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets fclk]
