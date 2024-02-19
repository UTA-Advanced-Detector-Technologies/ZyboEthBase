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

##Pmod Header JA (XADC) debug on J2 for the QDA board
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports dLocFifoFull]
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports dRxBusy]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports dRxError]
set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports dTxBusy]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports dExtFifoFull]
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports {dFsmState[0]}]
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports {dFsmState[1]}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {dFsmState[2]}]

##Pmod Header JB (Zybo Z7-20 only)
set_property -dict {PACKAGE_PIN V8 IOSTANDARD TMDS_33} [get_ports QDA_IN_A_p]
set_property -dict {PACKAGE_PIN W8 IOSTANDARD TMDS_33} [get_ports QDA_IN_A_n]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD TMDS_33} [get_ports QDA_IN_B_p]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD TMDS_33} [get_ports QDA_IN_B_n]
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD TMDS_33} [get_ports QDA_OUT_A_p]
set_property -dict {PACKAGE_PIN Y6 IOSTANDARD TMDS_33} [get_ports QDA_OUT_A_n]
set_property -dict {PACKAGE_PIN V6 IOSTANDARD TMDS_33} [get_ports QDA_OUT_B_p]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD TMDS_33} [get_ports QDA_OUT_B_n]

###Pmod Header JC
set_property -dict {PACKAGE_PIN V15 IOSTANDARD TMDS_33} [get_ports QDA_IN_C_p]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD TMDS_33} [get_ports QDA_IN_C_n]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD TMDS_33} [get_ports QDA_IN_D_p]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD TMDS_33} [get_ports QDA_IN_D_n]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD TMDS_33} [get_ports QDA_OUT_C_p]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD TMDS_33} [get_ports QDA_OUT_C_n]
set_property -dict {PACKAGE_PIN T12 IOSTANDARD TMDS_33} [get_ports QDA_OUT_D_p]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD TMDS_33} [get_ports QDA_OUT_D_n]

###Pmod Header JD
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports SPI_SRST]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports SPI_PCLK]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports SPI_SCLK]
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports SPI_SIN]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports DigReset]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports IntSoft]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports IntHard]
# set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports dTxBusy]

### DebugOut in QDA has 9 pins
##Pmod Header JE
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {EndeavorScale[2]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {EndeavorScale[1]}]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {EndeavorScale[0]}]
# set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports dDataValid]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {TxDisable[0]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {TxDisable[1]}]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {TxDisable[2]}]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD LVCMOS33} [get_ports {TxDisable[3]}]


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

set_property MARK_DEBUG true [get_nets EthBaseRegMap_U/U_IRS3D_DAC_CONTROL/iUpdate]
set_property MARK_DEBUG true [get_nets EthBaseRegMap_U/U_IRS3D_DAC_CONTROL/PCLK_i]
set_property MARK_DEBUG true [get_nets EthBaseRegMap_U/U_IRS3D_DAC_CONTROL/SCLK_i]
set_property MARK_DEBUG true [get_nets EthBaseRegMap_U/U_IRS3D_DAC_CONTROL/SIN_i]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[0]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[9]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[1]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[2]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[6]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[10]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[5]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[8]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[13]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[3]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[4]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[7]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[11]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/iRegData[12]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/EndeavorScale_OBUF[0]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/EndeavorScale_OBUF[1]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/EndeavorScale_OBUF[2]}]
set_property MARK_DEBUG true [get_nets {EthBaseRegMap_U/dFsmState_IBUF[0]}]
set_property MARK_DEBUG true [get_nets AxiLiteSlaveSimple_U_n_72]
set_property MARK_DEBUG true [get_nets AxiLiteSlaveSimple_U_n_71]
set_property MARK_DEBUG true [get_nets AxiLiteSlaveSimple_U_n_70]
set_property MARK_DEBUG true [get_nets IntHard_OBUF]
set_property MARK_DEBUG true [get_nets IntSoft_OBUF]
set_property MARK_DEBUG true [get_nets DigReset_OBUF]
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list design_1_U/design_1_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 3 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {EthBaseRegMap_U/EndeavorScale_OBUF[0]} {EthBaseRegMap_U/EndeavorScale_OBUF[1]} {EthBaseRegMap_U/EndeavorScale_OBUF[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 14 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {EthBaseRegMap_U/iRegData[0]} {EthBaseRegMap_U/iRegData[1]} {EthBaseRegMap_U/iRegData[2]} {EthBaseRegMap_U/iRegData[3]} {EthBaseRegMap_U/iRegData[4]} {EthBaseRegMap_U/iRegData[5]} {EthBaseRegMap_U/iRegData[6]} {EthBaseRegMap_U/iRegData[7]} {EthBaseRegMap_U/iRegData[8]} {EthBaseRegMap_U/iRegData[9]} {EthBaseRegMap_U/iRegData[10]} {EthBaseRegMap_U/iRegData[11]} {EthBaseRegMap_U/iRegData[12]} {EthBaseRegMap_U/iRegData[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {EthBaseRegMap_U/dFsmState_IBUF[0]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list AxiLiteSlaveSimple_U_n_70]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list AxiLiteSlaveSimple_U_n_71]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list AxiLiteSlaveSimple_U_n_72]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list DigReset_OBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list IntHard_OBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list IntSoft_OBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list EthBaseRegMap_U/U_IRS3D_DAC_CONTROL/iUpdate]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list EthBaseRegMap_U/U_IRS3D_DAC_CONTROL/PCLK_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list EthBaseRegMap_U/U_IRS3D_DAC_CONTROL/SCLK_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list EthBaseRegMap_U/U_IRS3D_DAC_CONTROL/SIN_i]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets fclk]
