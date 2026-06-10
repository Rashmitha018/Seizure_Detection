# File saved with Nlview 7.8.0 2024-04-26 e1825d835c VDI=44 GEI=38 GUI=JA:21.0 threadsafe
# 
# non-default properties - (restore without -noprops)
property -colorscheme classic
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 18
property maxzoom 7.5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #0000ff
property overlaycolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 4
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 18
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 1
property timelimit 1
#
module new basys3_top work:basys3_top:NOFILE -nosplit
load symbol RTL_ADD18 work RTL(+) pin I1 input.left pinBus I0 input.left [25:0] pinBus O output.right [25:0] fillcolor 1
load symbol RTL_MUX46 work MUX pinBus I0 input.left [25:0] pinBus I1 input.left [25:0] pinBus O output.right [25:0] pinBus S input.bot [25:0] fillcolor 1
load symbol RTL_INV work INV pin I0 input pin O output fillcolor 1
load symbol RTL_ROM8 work GEN pin O output.right pinBus A input.left [25:0] fillcolor 1
load symbol RTL_REG_ASYNC__BREG_1 work GEN pin C input.clk.left pin CE input.left pin CLR input.top pin D input.left pin Q output.right fillcolor 1
load symbol bin2bcd work:bin2bcd:NOFILE HIERBOX pinBus binary input.left [9:0] pinBus hund output.right [3:0] pinBus ones output.right [3:0] pinBus tens output.right [3:0] pinBus thou output.right [3:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol top_seizure_det work:top_seizure_det:NOFILE HIERBOX pin clk input.left pin data_valid input.left pin rst input.left pin seizure_detected output.right pinBus eeg_data_in input.left [15:0] pinBus spike_count output.right [9:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol eeg_bram work:eeg_bram:NOFILE HIERBOX pin clk input.left pinBus addr input.left [16:0] pinBus data_out output.right [15:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol sample_rate_ctrl work:sample_rate_ctrl:NOFILE HIERBOX pin clk input.left pin data_valid output.right pin done output.right pin loop_en input.left pin rst input.left pinBus sample_addr output.right [16:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol seven_seg_mux work:seven_seg_mux:NOFILE HIERBOX pin clk input.left pinBus an output.right [3:0] pinBus hund input.left [3:0] pinBus ones input.left [3:0] pinBus seg output.right [6:0] pinBus tens input.left [3:0] pinBus thou input.left [3:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol uart_controller work:uart_controller:NOFILE HIERBOX pin clk input.left pin data_valid input.left pin rst input.left pin seizure_detected input.left pin tx_out output.right pinBus eeg_data input.left [15:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RTL_REG_ASYNC__BREG_4 work[25:0]ssww GEN pin C input.clk.left pin CLR input.top pinBus D input.left [25:0] pinBus Q output.right [25:0] fillcolor 1 sandwich 3 prop @bundle 26
load port CLK100MHZ input -pg 1 -lvl 0 -x 0 -y 360
load port RsTx output -pg 1 -lvl 7 -x 2090 -y 360
load portBus an output [3:0] -attr @name an[3:0] -pg 1 -lvl 7 -x 2090 -y 80
load portBus led output [15:0] -attr @name led[15:0] -pg 1 -lvl 7 -x 2090 -y 440
load portBus seg output [6:0] -attr @name seg[6:0] -pg 1 -lvl 7 -x 2090 -y 110
load portBus sw input [1:0] -attr @name sw[1:0] -pg 1 -lvl 0 -x 0 -y 330
load inst heartbeat_counter0_i RTL_ADD18 work -attr @cell(#000000) RTL_ADD -pinBusAttr I0 @name I0[25:0] -pinBusAttr O @name O[25:0] -pg 1 -lvl 1 -x 100 -y 250
load inst heartbeat_counter_i RTL_MUX46 work -attr @cell(#000000) RTL_MUX -pinBusAttr I0 @name I0[25:0] -pinBusAttr I0 @attr S=26'b10111110101111000001111111 -pinBusAttr I1 @name I1[25:0] -pinBusAttr I1 @attr S=default -pinBusAttr O @name O[25:0] -pinBusAttr S @name S[25:0] -pg 1 -lvl 2 -x 540 -y 240
load inst heartbeat_led0_i RTL_INV work -attr @cell(#000000) RTL_INV -pg 1 -lvl 4 -x 1140 -y 320
load inst heartbeat_led_i RTL_ROM8 work -attr @cell(#000000) RTL_ROM -pinBusAttr A @name A[25:0] -pg 1 -lvl 4 -x 1140 -y 230
load inst heartbeat_led_reg RTL_REG_ASYNC__BREG_1 work -attr @cell(#000000) RTL_REG_ASYNC -pg 1 -lvl 5 -x 1500 -y 270
load inst u_bin2bcd bin2bcd work:bin2bcd:NOFILE -autohide -attr @cell(#000000) bin2bcd -pinBusAttr binary @name binary[9:0] -pinBusAttr hund @name hund[3:0] -pinBusAttr ones @name ones[3:0] -pinBusAttr tens @name tens[3:0] -pinBusAttr thou @name thou[3:0] -pg 1 -lvl 5 -x 1500 -y 70
load inst u_detector top_seizure_det work:top_seizure_det:NOFILE -autohide -attr @cell(#000000) top_seizure_det -pinBusAttr eeg_data_in @name eeg_data_in[15:0] -pinBusAttr spike_count @name spike_count[9:0] -pg 1 -lvl 5 -x 1500 -y 430
load inst u_eeg_mem eeg_bram work:eeg_bram:NOFILE -autohide -attr @cell(#000000) eeg_bram -pinBusAttr addr @name addr[16:0] -pinBusAttr data_out @name data_out[15:0] -pg 1 -lvl 4 -x 1140 -y 430
load inst u_sample_ctrl sample_rate_ctrl work:sample_rate_ctrl:NOFILE -autohide -attr @cell(#000000) sample_rate_ctrl -pinBusAttr sample_addr @name sample_addr[16:0] -pg 1 -lvl 3 -x 760 -y 370
load inst u_seg_mux seven_seg_mux work:seven_seg_mux:NOFILE -autohide -attr @cell(#000000) seven_seg_mux -pinBusAttr an @name an[3:0] -pinBusAttr hund @name hund[3:0] -pinBusAttr ones @name ones[3:0] -pinBusAttr seg @name seg[6:0] -pinBusAttr tens @name tens[3:0] -pinBusAttr thou @name thou[3:0] -pg 1 -lvl 6 -x 1900 -y 50
load inst u_uart uart_controller work:uart_controller:NOFILE -autohide -attr @cell(#000000) uart_controller -pinBusAttr eeg_data @name eeg_data[15:0] -pg 1 -lvl 6 -x 1900 -y 310
load inst heartbeat_counter_reg[25:0] RTL_REG_ASYNC__BREG_4 work[25:0]ssww -attr @cell(#000000) RTL_REG_ASYNC -pg 1 -lvl 3 -x 760 -y 230
load net <const0> -ground -pin heartbeat_counter_i I0[25] -pin heartbeat_counter_i I0[24] -pin heartbeat_counter_i I0[23] -pin heartbeat_counter_i I0[22] -pin heartbeat_counter_i I0[21] -pin heartbeat_counter_i I0[20] -pin heartbeat_counter_i I0[19] -pin heartbeat_counter_i I0[18] -pin heartbeat_counter_i I0[17] -pin heartbeat_counter_i I0[16] -pin heartbeat_counter_i I0[15] -pin heartbeat_counter_i I0[14] -pin heartbeat_counter_i I0[13] -pin heartbeat_counter_i I0[12] -pin heartbeat_counter_i I0[11] -pin heartbeat_counter_i I0[10] -pin heartbeat_counter_i I0[9] -pin heartbeat_counter_i I0[8] -pin heartbeat_counter_i I0[7] -pin heartbeat_counter_i I0[6] -pin heartbeat_counter_i I0[5] -pin heartbeat_counter_i I0[4] -pin heartbeat_counter_i I0[3] -pin heartbeat_counter_i I0[2] -pin heartbeat_counter_i I0[1] -pin heartbeat_counter_i I0[0] -port led[13] -port led[12] -port led[11] -port led[10] -port led[9] -port led[8] -port led[7] -port led[6] -port led[5] -port led[4] -port led[3] -port led[2] -port led[1]
load net <const1> -power -pin heartbeat_counter0_i I1
load net CLK100MHZ -port CLK100MHZ -pin heartbeat_counter_reg[25:0] C -pin heartbeat_led_reg C -pin u_detector clk -pin u_eeg_mem clk -pin u_sample_ctrl clk -pin u_seg_mux clk -pin u_uart clk
netloc CLK100MHZ 1 0 6 NJ 360 NJ 360 680 320 1030 360 1350 340 1710
load net RsTx -port RsTx -pin u_uart tx_out
netloc RsTx 1 6 1 NJ 360
load net an[0] -attr @rip(#000000) an[0] -port an[0] -pin u_seg_mux an[0]
load net an[1] -attr @rip(#000000) an[1] -port an[1] -pin u_seg_mux an[1]
load net an[2] -attr @rip(#000000) an[2] -port an[2] -pin u_seg_mux an[2]
load net an[3] -attr @rip(#000000) an[3] -port an[3] -pin u_seg_mux an[3]
load net data_valid -pin u_detector data_valid -pin u_sample_ctrl data_valid -pin u_uart data_valid
netloc data_valid 1 3 3 NJ 380 1330 380 1730
load net eeg_data[0] -attr @rip(#000000) data_out[0] -pin u_detector eeg_data_in[0] -pin u_eeg_mem data_out[0] -pin u_uart eeg_data[0]
load net eeg_data[10] -attr @rip(#000000) data_out[10] -pin u_detector eeg_data_in[10] -pin u_eeg_mem data_out[10] -pin u_uart eeg_data[10]
load net eeg_data[11] -attr @rip(#000000) data_out[11] -pin u_detector eeg_data_in[11] -pin u_eeg_mem data_out[11] -pin u_uart eeg_data[11]
load net eeg_data[12] -attr @rip(#000000) data_out[12] -pin u_detector eeg_data_in[12] -pin u_eeg_mem data_out[12] -pin u_uart eeg_data[12]
load net eeg_data[13] -attr @rip(#000000) data_out[13] -pin u_detector eeg_data_in[13] -pin u_eeg_mem data_out[13] -pin u_uart eeg_data[13]
load net eeg_data[14] -attr @rip(#000000) data_out[14] -pin u_detector eeg_data_in[14] -pin u_eeg_mem data_out[14] -pin u_uart eeg_data[14]
load net eeg_data[15] -attr @rip(#000000) data_out[15] -pin u_detector eeg_data_in[15] -pin u_eeg_mem data_out[15] -pin u_uart eeg_data[15]
load net eeg_data[1] -attr @rip(#000000) data_out[1] -pin u_detector eeg_data_in[1] -pin u_eeg_mem data_out[1] -pin u_uart eeg_data[1]
load net eeg_data[2] -attr @rip(#000000) data_out[2] -pin u_detector eeg_data_in[2] -pin u_eeg_mem data_out[2] -pin u_uart eeg_data[2]
load net eeg_data[3] -attr @rip(#000000) data_out[3] -pin u_detector eeg_data_in[3] -pin u_eeg_mem data_out[3] -pin u_uart eeg_data[3]
load net eeg_data[4] -attr @rip(#000000) data_out[4] -pin u_detector eeg_data_in[4] -pin u_eeg_mem data_out[4] -pin u_uart eeg_data[4]
load net eeg_data[5] -attr @rip(#000000) data_out[5] -pin u_detector eeg_data_in[5] -pin u_eeg_mem data_out[5] -pin u_uart eeg_data[5]
load net eeg_data[6] -attr @rip(#000000) data_out[6] -pin u_detector eeg_data_in[6] -pin u_eeg_mem data_out[6] -pin u_uart eeg_data[6]
load net eeg_data[7] -attr @rip(#000000) data_out[7] -pin u_detector eeg_data_in[7] -pin u_eeg_mem data_out[7] -pin u_uart eeg_data[7]
load net eeg_data[8] -attr @rip(#000000) data_out[8] -pin u_detector eeg_data_in[8] -pin u_eeg_mem data_out[8] -pin u_uart eeg_data[8]
load net eeg_data[9] -attr @rip(#000000) data_out[9] -pin u_detector eeg_data_in[9] -pin u_eeg_mem data_out[9] -pin u_uart eeg_data[9]
load net heartbeat_counter0[0] -attr @rip(#000000) O[0] -pin heartbeat_counter0_i O[0] -pin heartbeat_counter_i I1[0]
load net heartbeat_counter0[10] -attr @rip(#000000) O[10] -pin heartbeat_counter0_i O[10] -pin heartbeat_counter_i I1[10]
load net heartbeat_counter0[11] -attr @rip(#000000) O[11] -pin heartbeat_counter0_i O[11] -pin heartbeat_counter_i I1[11]
load net heartbeat_counter0[12] -attr @rip(#000000) O[12] -pin heartbeat_counter0_i O[12] -pin heartbeat_counter_i I1[12]
load net heartbeat_counter0[13] -attr @rip(#000000) O[13] -pin heartbeat_counter0_i O[13] -pin heartbeat_counter_i I1[13]
load net heartbeat_counter0[14] -attr @rip(#000000) O[14] -pin heartbeat_counter0_i O[14] -pin heartbeat_counter_i I1[14]
load net heartbeat_counter0[15] -attr @rip(#000000) O[15] -pin heartbeat_counter0_i O[15] -pin heartbeat_counter_i I1[15]
load net heartbeat_counter0[16] -attr @rip(#000000) O[16] -pin heartbeat_counter0_i O[16] -pin heartbeat_counter_i I1[16]
load net heartbeat_counter0[17] -attr @rip(#000000) O[17] -pin heartbeat_counter0_i O[17] -pin heartbeat_counter_i I1[17]
load net heartbeat_counter0[18] -attr @rip(#000000) O[18] -pin heartbeat_counter0_i O[18] -pin heartbeat_counter_i I1[18]
load net heartbeat_counter0[19] -attr @rip(#000000) O[19] -pin heartbeat_counter0_i O[19] -pin heartbeat_counter_i I1[19]
load net heartbeat_counter0[1] -attr @rip(#000000) O[1] -pin heartbeat_counter0_i O[1] -pin heartbeat_counter_i I1[1]
load net heartbeat_counter0[20] -attr @rip(#000000) O[20] -pin heartbeat_counter0_i O[20] -pin heartbeat_counter_i I1[20]
load net heartbeat_counter0[21] -attr @rip(#000000) O[21] -pin heartbeat_counter0_i O[21] -pin heartbeat_counter_i I1[21]
load net heartbeat_counter0[22] -attr @rip(#000000) O[22] -pin heartbeat_counter0_i O[22] -pin heartbeat_counter_i I1[22]
load net heartbeat_counter0[23] -attr @rip(#000000) O[23] -pin heartbeat_counter0_i O[23] -pin heartbeat_counter_i I1[23]
load net heartbeat_counter0[24] -attr @rip(#000000) O[24] -pin heartbeat_counter0_i O[24] -pin heartbeat_counter_i I1[24]
load net heartbeat_counter0[25] -attr @rip(#000000) O[25] -pin heartbeat_counter0_i O[25] -pin heartbeat_counter_i I1[25]
load net heartbeat_counter0[2] -attr @rip(#000000) O[2] -pin heartbeat_counter0_i O[2] -pin heartbeat_counter_i I1[2]
load net heartbeat_counter0[3] -attr @rip(#000000) O[3] -pin heartbeat_counter0_i O[3] -pin heartbeat_counter_i I1[3]
load net heartbeat_counter0[4] -attr @rip(#000000) O[4] -pin heartbeat_counter0_i O[4] -pin heartbeat_counter_i I1[4]
load net heartbeat_counter0[5] -attr @rip(#000000) O[5] -pin heartbeat_counter0_i O[5] -pin heartbeat_counter_i I1[5]
load net heartbeat_counter0[6] -attr @rip(#000000) O[6] -pin heartbeat_counter0_i O[6] -pin heartbeat_counter_i I1[6]
load net heartbeat_counter0[7] -attr @rip(#000000) O[7] -pin heartbeat_counter0_i O[7] -pin heartbeat_counter_i I1[7]
load net heartbeat_counter0[8] -attr @rip(#000000) O[8] -pin heartbeat_counter0_i O[8] -pin heartbeat_counter_i I1[8]
load net heartbeat_counter0[9] -attr @rip(#000000) O[9] -pin heartbeat_counter0_i O[9] -pin heartbeat_counter_i I1[9]
load net heartbeat_counter0_out[0] -attr @rip(#000000) O[0] -pin heartbeat_counter_i O[0] -pin heartbeat_counter_reg[25:0] D[0]
load net heartbeat_counter0_out[10] -attr @rip(#000000) O[10] -pin heartbeat_counter_i O[10] -pin heartbeat_counter_reg[25:0] D[10]
load net heartbeat_counter0_out[11] -attr @rip(#000000) O[11] -pin heartbeat_counter_i O[11] -pin heartbeat_counter_reg[25:0] D[11]
load net heartbeat_counter0_out[12] -attr @rip(#000000) O[12] -pin heartbeat_counter_i O[12] -pin heartbeat_counter_reg[25:0] D[12]
load net heartbeat_counter0_out[13] -attr @rip(#000000) O[13] -pin heartbeat_counter_i O[13] -pin heartbeat_counter_reg[25:0] D[13]
load net heartbeat_counter0_out[14] -attr @rip(#000000) O[14] -pin heartbeat_counter_i O[14] -pin heartbeat_counter_reg[25:0] D[14]
load net heartbeat_counter0_out[15] -attr @rip(#000000) O[15] -pin heartbeat_counter_i O[15] -pin heartbeat_counter_reg[25:0] D[15]
load net heartbeat_counter0_out[16] -attr @rip(#000000) O[16] -pin heartbeat_counter_i O[16] -pin heartbeat_counter_reg[25:0] D[16]
load net heartbeat_counter0_out[17] -attr @rip(#000000) O[17] -pin heartbeat_counter_i O[17] -pin heartbeat_counter_reg[25:0] D[17]
load net heartbeat_counter0_out[18] -attr @rip(#000000) O[18] -pin heartbeat_counter_i O[18] -pin heartbeat_counter_reg[25:0] D[18]
load net heartbeat_counter0_out[19] -attr @rip(#000000) O[19] -pin heartbeat_counter_i O[19] -pin heartbeat_counter_reg[25:0] D[19]
load net heartbeat_counter0_out[1] -attr @rip(#000000) O[1] -pin heartbeat_counter_i O[1] -pin heartbeat_counter_reg[25:0] D[1]
load net heartbeat_counter0_out[20] -attr @rip(#000000) O[20] -pin heartbeat_counter_i O[20] -pin heartbeat_counter_reg[25:0] D[20]
load net heartbeat_counter0_out[21] -attr @rip(#000000) O[21] -pin heartbeat_counter_i O[21] -pin heartbeat_counter_reg[25:0] D[21]
load net heartbeat_counter0_out[22] -attr @rip(#000000) O[22] -pin heartbeat_counter_i O[22] -pin heartbeat_counter_reg[25:0] D[22]
load net heartbeat_counter0_out[23] -attr @rip(#000000) O[23] -pin heartbeat_counter_i O[23] -pin heartbeat_counter_reg[25:0] D[23]
load net heartbeat_counter0_out[24] -attr @rip(#000000) O[24] -pin heartbeat_counter_i O[24] -pin heartbeat_counter_reg[25:0] D[24]
load net heartbeat_counter0_out[25] -attr @rip(#000000) O[25] -pin heartbeat_counter_i O[25] -pin heartbeat_counter_reg[25:0] D[25]
load net heartbeat_counter0_out[2] -attr @rip(#000000) O[2] -pin heartbeat_counter_i O[2] -pin heartbeat_counter_reg[25:0] D[2]
load net heartbeat_counter0_out[3] -attr @rip(#000000) O[3] -pin heartbeat_counter_i O[3] -pin heartbeat_counter_reg[25:0] D[3]
load net heartbeat_counter0_out[4] -attr @rip(#000000) O[4] -pin heartbeat_counter_i O[4] -pin heartbeat_counter_reg[25:0] D[4]
load net heartbeat_counter0_out[5] -attr @rip(#000000) O[5] -pin heartbeat_counter_i O[5] -pin heartbeat_counter_reg[25:0] D[5]
load net heartbeat_counter0_out[6] -attr @rip(#000000) O[6] -pin heartbeat_counter_i O[6] -pin heartbeat_counter_reg[25:0] D[6]
load net heartbeat_counter0_out[7] -attr @rip(#000000) O[7] -pin heartbeat_counter_i O[7] -pin heartbeat_counter_reg[25:0] D[7]
load net heartbeat_counter0_out[8] -attr @rip(#000000) O[8] -pin heartbeat_counter_i O[8] -pin heartbeat_counter_reg[25:0] D[8]
load net heartbeat_counter0_out[9] -attr @rip(#000000) O[9] -pin heartbeat_counter_i O[9] -pin heartbeat_counter_reg[25:0] D[9]
load net heartbeat_counter[0] -attr @rip(#000000) 0 -pin heartbeat_counter0_i I0[0] -pin heartbeat_counter_i S[0] -pin heartbeat_counter_reg[25:0] Q[0] -pin heartbeat_led_i A[0]
load net heartbeat_counter[10] -attr @rip(#000000) 10 -pin heartbeat_counter0_i I0[10] -pin heartbeat_counter_i S[10] -pin heartbeat_counter_reg[25:0] Q[10] -pin heartbeat_led_i A[10]
load net heartbeat_counter[11] -attr @rip(#000000) 11 -pin heartbeat_counter0_i I0[11] -pin heartbeat_counter_i S[11] -pin heartbeat_counter_reg[25:0] Q[11] -pin heartbeat_led_i A[11]
load net heartbeat_counter[12] -attr @rip(#000000) 12 -pin heartbeat_counter0_i I0[12] -pin heartbeat_counter_i S[12] -pin heartbeat_counter_reg[25:0] Q[12] -pin heartbeat_led_i A[12]
load net heartbeat_counter[13] -attr @rip(#000000) 13 -pin heartbeat_counter0_i I0[13] -pin heartbeat_counter_i S[13] -pin heartbeat_counter_reg[25:0] Q[13] -pin heartbeat_led_i A[13]
load net heartbeat_counter[14] -attr @rip(#000000) 14 -pin heartbeat_counter0_i I0[14] -pin heartbeat_counter_i S[14] -pin heartbeat_counter_reg[25:0] Q[14] -pin heartbeat_led_i A[14]
load net heartbeat_counter[15] -attr @rip(#000000) 15 -pin heartbeat_counter0_i I0[15] -pin heartbeat_counter_i S[15] -pin heartbeat_counter_reg[25:0] Q[15] -pin heartbeat_led_i A[15]
load net heartbeat_counter[16] -attr @rip(#000000) 16 -pin heartbeat_counter0_i I0[16] -pin heartbeat_counter_i S[16] -pin heartbeat_counter_reg[25:0] Q[16] -pin heartbeat_led_i A[16]
load net heartbeat_counter[17] -attr @rip(#000000) 17 -pin heartbeat_counter0_i I0[17] -pin heartbeat_counter_i S[17] -pin heartbeat_counter_reg[25:0] Q[17] -pin heartbeat_led_i A[17]
load net heartbeat_counter[18] -attr @rip(#000000) 18 -pin heartbeat_counter0_i I0[18] -pin heartbeat_counter_i S[18] -pin heartbeat_counter_reg[25:0] Q[18] -pin heartbeat_led_i A[18]
load net heartbeat_counter[19] -attr @rip(#000000) 19 -pin heartbeat_counter0_i I0[19] -pin heartbeat_counter_i S[19] -pin heartbeat_counter_reg[25:0] Q[19] -pin heartbeat_led_i A[19]
load net heartbeat_counter[1] -attr @rip(#000000) 1 -pin heartbeat_counter0_i I0[1] -pin heartbeat_counter_i S[1] -pin heartbeat_counter_reg[25:0] Q[1] -pin heartbeat_led_i A[1]
load net heartbeat_counter[20] -attr @rip(#000000) 20 -pin heartbeat_counter0_i I0[20] -pin heartbeat_counter_i S[20] -pin heartbeat_counter_reg[25:0] Q[20] -pin heartbeat_led_i A[20]
load net heartbeat_counter[21] -attr @rip(#000000) 21 -pin heartbeat_counter0_i I0[21] -pin heartbeat_counter_i S[21] -pin heartbeat_counter_reg[25:0] Q[21] -pin heartbeat_led_i A[21]
load net heartbeat_counter[22] -attr @rip(#000000) 22 -pin heartbeat_counter0_i I0[22] -pin heartbeat_counter_i S[22] -pin heartbeat_counter_reg[25:0] Q[22] -pin heartbeat_led_i A[22]
load net heartbeat_counter[23] -attr @rip(#000000) 23 -pin heartbeat_counter0_i I0[23] -pin heartbeat_counter_i S[23] -pin heartbeat_counter_reg[25:0] Q[23] -pin heartbeat_led_i A[23]
load net heartbeat_counter[24] -attr @rip(#000000) 24 -pin heartbeat_counter0_i I0[24] -pin heartbeat_counter_i S[24] -pin heartbeat_counter_reg[25:0] Q[24] -pin heartbeat_led_i A[24]
load net heartbeat_counter[25] -attr @rip(#000000) 25 -pin heartbeat_counter0_i I0[25] -pin heartbeat_counter_i S[25] -pin heartbeat_counter_reg[25:0] Q[25] -pin heartbeat_led_i A[25]
load net heartbeat_counter[2] -attr @rip(#000000) 2 -pin heartbeat_counter0_i I0[2] -pin heartbeat_counter_i S[2] -pin heartbeat_counter_reg[25:0] Q[2] -pin heartbeat_led_i A[2]
load net heartbeat_counter[3] -attr @rip(#000000) 3 -pin heartbeat_counter0_i I0[3] -pin heartbeat_counter_i S[3] -pin heartbeat_counter_reg[25:0] Q[3] -pin heartbeat_led_i A[3]
load net heartbeat_counter[4] -attr @rip(#000000) 4 -pin heartbeat_counter0_i I0[4] -pin heartbeat_counter_i S[4] -pin heartbeat_counter_reg[25:0] Q[4] -pin heartbeat_led_i A[4]
load net heartbeat_counter[5] -attr @rip(#000000) 5 -pin heartbeat_counter0_i I0[5] -pin heartbeat_counter_i S[5] -pin heartbeat_counter_reg[25:0] Q[5] -pin heartbeat_led_i A[5]
load net heartbeat_counter[6] -attr @rip(#000000) 6 -pin heartbeat_counter0_i I0[6] -pin heartbeat_counter_i S[6] -pin heartbeat_counter_reg[25:0] Q[6] -pin heartbeat_led_i A[6]
load net heartbeat_counter[7] -attr @rip(#000000) 7 -pin heartbeat_counter0_i I0[7] -pin heartbeat_counter_i S[7] -pin heartbeat_counter_reg[25:0] Q[7] -pin heartbeat_led_i A[7]
load net heartbeat_counter[8] -attr @rip(#000000) 8 -pin heartbeat_counter0_i I0[8] -pin heartbeat_counter_i S[8] -pin heartbeat_counter_reg[25:0] Q[8] -pin heartbeat_led_i A[8]
load net heartbeat_counter[9] -attr @rip(#000000) 9 -pin heartbeat_counter0_i I0[9] -pin heartbeat_counter_i S[9] -pin heartbeat_counter_reg[25:0] Q[9] -pin heartbeat_led_i A[9]
load net heartbeat_led -pin heartbeat_led_i O -pin heartbeat_led_reg CE
netloc heartbeat_led 1 4 1 1330 230n
load net heartbeat_led0 -pin heartbeat_led0_i O -pin heartbeat_led_reg D
netloc heartbeat_led0 1 4 1 1330 290n
load net hund[0] -attr @rip(#000000) hund[0] -pin u_bin2bcd hund[0] -pin u_seg_mux hund[0]
load net hund[1] -attr @rip(#000000) hund[1] -pin u_bin2bcd hund[1] -pin u_seg_mux hund[1]
load net hund[2] -attr @rip(#000000) hund[2] -pin u_bin2bcd hund[2] -pin u_seg_mux hund[2]
load net hund[3] -attr @rip(#000000) hund[3] -pin u_bin2bcd hund[3] -pin u_seg_mux hund[3]
load net led[0] -attr @rip(#000000) 0 -port led[0] -pin u_detector seizure_detected -pin u_uart seizure_detected
load net led[14] -attr @rip(#000000) 14 -port led[14] -pin u_sample_ctrl done
load net led[15] -attr @rip(#000000) 15 -pin heartbeat_led0_i I0 -pin heartbeat_led_reg Q -port led[15]
load net ones[0] -attr @rip(#000000) ones[0] -pin u_bin2bcd ones[0] -pin u_seg_mux ones[0]
load net ones[1] -attr @rip(#000000) ones[1] -pin u_bin2bcd ones[1] -pin u_seg_mux ones[1]
load net ones[2] -attr @rip(#000000) ones[2] -pin u_bin2bcd ones[2] -pin u_seg_mux ones[2]
load net ones[3] -attr @rip(#000000) ones[3] -pin u_bin2bcd ones[3] -pin u_seg_mux ones[3]
load net sample_addr[0] -attr @rip(#000000) sample_addr[0] -pin u_eeg_mem addr[0] -pin u_sample_ctrl sample_addr[0]
load net sample_addr[10] -attr @rip(#000000) sample_addr[10] -pin u_eeg_mem addr[10] -pin u_sample_ctrl sample_addr[10]
load net sample_addr[11] -attr @rip(#000000) sample_addr[11] -pin u_eeg_mem addr[11] -pin u_sample_ctrl sample_addr[11]
load net sample_addr[12] -attr @rip(#000000) sample_addr[12] -pin u_eeg_mem addr[12] -pin u_sample_ctrl sample_addr[12]
load net sample_addr[13] -attr @rip(#000000) sample_addr[13] -pin u_eeg_mem addr[13] -pin u_sample_ctrl sample_addr[13]
load net sample_addr[14] -attr @rip(#000000) sample_addr[14] -pin u_eeg_mem addr[14] -pin u_sample_ctrl sample_addr[14]
load net sample_addr[15] -attr @rip(#000000) sample_addr[15] -pin u_eeg_mem addr[15] -pin u_sample_ctrl sample_addr[15]
load net sample_addr[16] -attr @rip(#000000) sample_addr[16] -pin u_eeg_mem addr[16] -pin u_sample_ctrl sample_addr[16]
load net sample_addr[1] -attr @rip(#000000) sample_addr[1] -pin u_eeg_mem addr[1] -pin u_sample_ctrl sample_addr[1]
load net sample_addr[2] -attr @rip(#000000) sample_addr[2] -pin u_eeg_mem addr[2] -pin u_sample_ctrl sample_addr[2]
load net sample_addr[3] -attr @rip(#000000) sample_addr[3] -pin u_eeg_mem addr[3] -pin u_sample_ctrl sample_addr[3]
load net sample_addr[4] -attr @rip(#000000) sample_addr[4] -pin u_eeg_mem addr[4] -pin u_sample_ctrl sample_addr[4]
load net sample_addr[5] -attr @rip(#000000) sample_addr[5] -pin u_eeg_mem addr[5] -pin u_sample_ctrl sample_addr[5]
load net sample_addr[6] -attr @rip(#000000) sample_addr[6] -pin u_eeg_mem addr[6] -pin u_sample_ctrl sample_addr[6]
load net sample_addr[7] -attr @rip(#000000) sample_addr[7] -pin u_eeg_mem addr[7] -pin u_sample_ctrl sample_addr[7]
load net sample_addr[8] -attr @rip(#000000) sample_addr[8] -pin u_eeg_mem addr[8] -pin u_sample_ctrl sample_addr[8]
load net sample_addr[9] -attr @rip(#000000) sample_addr[9] -pin u_eeg_mem addr[9] -pin u_sample_ctrl sample_addr[9]
load net seg[0] -attr @rip(#000000) seg[0] -port seg[0] -pin u_seg_mux seg[0]
load net seg[1] -attr @rip(#000000) seg[1] -port seg[1] -pin u_seg_mux seg[1]
load net seg[2] -attr @rip(#000000) seg[2] -port seg[2] -pin u_seg_mux seg[2]
load net seg[3] -attr @rip(#000000) seg[3] -port seg[3] -pin u_seg_mux seg[3]
load net seg[4] -attr @rip(#000000) seg[4] -port seg[4] -pin u_seg_mux seg[4]
load net seg[5] -attr @rip(#000000) seg[5] -port seg[5] -pin u_seg_mux seg[5]
load net seg[6] -attr @rip(#000000) seg[6] -port seg[6] -pin u_seg_mux seg[6]
load net spike_count[0] -attr @rip(#000000) spike_count[0] -pin u_bin2bcd binary[0] -pin u_detector spike_count[0]
load net spike_count[1] -attr @rip(#000000) spike_count[1] -pin u_bin2bcd binary[1] -pin u_detector spike_count[1]
load net spike_count[2] -attr @rip(#000000) spike_count[2] -pin u_bin2bcd binary[2] -pin u_detector spike_count[2]
load net spike_count[3] -attr @rip(#000000) spike_count[3] -pin u_bin2bcd binary[3] -pin u_detector spike_count[3]
load net spike_count[4] -attr @rip(#000000) spike_count[4] -pin u_bin2bcd binary[4] -pin u_detector spike_count[4]
load net spike_count[5] -attr @rip(#000000) spike_count[5] -pin u_bin2bcd binary[5] -pin u_detector spike_count[5]
load net spike_count[6] -attr @rip(#000000) spike_count[6] -pin u_bin2bcd binary[6] -pin u_detector spike_count[6]
load net spike_count[7] -attr @rip(#000000) spike_count[7] -pin u_bin2bcd binary[7] -pin u_detector spike_count[7]
load net spike_count[8] -attr @rip(#000000) spike_count[8] -pin u_bin2bcd binary[8] -pin u_detector spike_count[8]
load net spike_count[9] -attr @rip(#000000) spike_count[9] -pin u_bin2bcd binary[9] -pin u_detector spike_count[9]
load net sw[0] -attr @rip(#000000) sw[0] -pin heartbeat_counter_reg[25:0] CLR -pin heartbeat_led_reg CLR -port sw[0] -pin u_detector rst -pin u_sample_ctrl rst -pin u_uart rst
load net sw[1] -attr @rip(#000000) sw[1] -port sw[1] -pin u_sample_ctrl loop_en
load net tens[0] -attr @rip(#000000) tens[0] -pin u_bin2bcd tens[0] -pin u_seg_mux tens[0]
load net tens[1] -attr @rip(#000000) tens[1] -pin u_bin2bcd tens[1] -pin u_seg_mux tens[1]
load net tens[2] -attr @rip(#000000) tens[2] -pin u_bin2bcd tens[2] -pin u_seg_mux tens[2]
load net tens[3] -attr @rip(#000000) tens[3] -pin u_bin2bcd tens[3] -pin u_seg_mux tens[3]
load net thou[0] -attr @rip(#000000) thou[0] -pin u_bin2bcd thou[0] -pin u_seg_mux thou[0]
load net thou[1] -attr @rip(#000000) thou[1] -pin u_bin2bcd thou[1] -pin u_seg_mux thou[1]
load net thou[2] -attr @rip(#000000) thou[2] -pin u_bin2bcd thou[2] -pin u_seg_mux thou[2]
load net thou[3] -attr @rip(#000000) thou[3] -pin u_bin2bcd thou[3] -pin u_seg_mux thou[3]
load netBundle @sw 2 sw[1] sw[0] -autobundled
netbloc @sw 1 0 6 NJ 330 NJ 330 660 170N 1030 280 1310 200N 1750
load netBundle @an 4 an[3] an[2] an[1] an[0] -autobundled
netbloc @an 1 6 1 NJ 80
load netBundle @led 3 led[15] led[14] led[0] -autobundled
netbloc @led 1 3 4 1050 180 NJ 180 1770 440 2040J
load netBundle @seg 7 seg[6] seg[5] seg[4] seg[3] seg[2] seg[1] seg[0] -autobundled
netbloc @seg 1 6 1 2040J 100n
load netBundle @heartbeat_counter0 26 heartbeat_counter0[25] heartbeat_counter0[24] heartbeat_counter0[23] heartbeat_counter0[22] heartbeat_counter0[21] heartbeat_counter0[20] heartbeat_counter0[19] heartbeat_counter0[18] heartbeat_counter0[17] heartbeat_counter0[16] heartbeat_counter0[15] heartbeat_counter0[14] heartbeat_counter0[13] heartbeat_counter0[12] heartbeat_counter0[11] heartbeat_counter0[10] heartbeat_counter0[9] heartbeat_counter0[8] heartbeat_counter0[7] heartbeat_counter0[6] heartbeat_counter0[5] heartbeat_counter0[4] heartbeat_counter0[3] heartbeat_counter0[2] heartbeat_counter0[1] heartbeat_counter0[0] -autobundled
netbloc @heartbeat_counter0 1 1 1 NJ 250
load netBundle @heartbeat_counter0_out 26 heartbeat_counter0_out[25] heartbeat_counter0_out[24] heartbeat_counter0_out[23] heartbeat_counter0_out[22] heartbeat_counter0_out[21] heartbeat_counter0_out[20] heartbeat_counter0_out[19] heartbeat_counter0_out[18] heartbeat_counter0_out[17] heartbeat_counter0_out[16] heartbeat_counter0_out[15] heartbeat_counter0_out[14] heartbeat_counter0_out[13] heartbeat_counter0_out[12] heartbeat_counter0_out[11] heartbeat_counter0_out[10] heartbeat_counter0_out[9] heartbeat_counter0_out[8] heartbeat_counter0_out[7] heartbeat_counter0_out[6] heartbeat_counter0_out[5] heartbeat_counter0_out[4] heartbeat_counter0_out[3] heartbeat_counter0_out[2] heartbeat_counter0_out[1] heartbeat_counter0_out[0] -autobundled
netbloc @heartbeat_counter0_out 1 2 1 N 240
load netBundle @hund 4 hund[3] hund[2] hund[1] hund[0] -autobundled
netbloc @hund 1 5 1 N 80
load netBundle @ones 4 ones[3] ones[2] ones[1] ones[0] -autobundled
netbloc @ones 1 5 1 N 100
load netBundle @tens 4 tens[3] tens[2] tens[1] tens[0] -autobundled
netbloc @tens 1 5 1 N 120
load netBundle @thou 4 thou[3] thou[2] thou[1] thou[0] -autobundled
netbloc @thou 1 5 1 N 140
load netBundle @spike_count 10 spike_count[9] spike_count[8] spike_count[7] spike_count[6] spike_count[5] spike_count[4] spike_count[3] spike_count[2] spike_count[1] spike_count[0] -autobundled
netbloc @spike_count 1 4 2 1370 20 1690
load netBundle @eeg_data 16 eeg_data[15] eeg_data[14] eeg_data[13] eeg_data[12] eeg_data[11] eeg_data[10] eeg_data[9] eeg_data[8] eeg_data[7] eeg_data[6] eeg_data[5] eeg_data[4] eeg_data[3] eeg_data[2] eeg_data[1] eeg_data[0] -autobundled
netbloc @eeg_data 1 4 2 1370 360 N
load netBundle @sample_addr 17 sample_addr[16] sample_addr[15] sample_addr[14] sample_addr[13] sample_addr[12] sample_addr[11] sample_addr[10] sample_addr[9] sample_addr[8] sample_addr[7] sample_addr[6] sample_addr[5] sample_addr[4] sample_addr[3] sample_addr[2] sample_addr[1] sample_addr[0] -autobundled
netbloc @sample_addr 1 3 1 1010 420n
load netBundle @heartbeat_counter 26 heartbeat_counter[25] heartbeat_counter[24] heartbeat_counter[23] heartbeat_counter[22] heartbeat_counter[21] heartbeat_counter[20] heartbeat_counter[19] heartbeat_counter[18] heartbeat_counter[17] heartbeat_counter[16] heartbeat_counter[15] heartbeat_counter[14] heartbeat_counter[13] heartbeat_counter[12] heartbeat_counter[11] heartbeat_counter[10] heartbeat_counter[9] heartbeat_counter[8] heartbeat_counter[7] heartbeat_counter[6] heartbeat_counter[5] heartbeat_counter[4] heartbeat_counter[3] heartbeat_counter[2] heartbeat_counter[1] heartbeat_counter[0] -autobundled
netbloc @heartbeat_counter 1 0 4 20 300 NJ 300N N 300 1010
levelinfo -pg 1 0 100 540 760 1140 1500 1900 2090
pagesize -pg 1 -db -bbox -sgen -130 0 2200 540
show
zoom 0.381568
scrollpos -49 -141
#
# initialize ictrl to current module basys3_top work:basys3_top:NOFILE
ictrl init topinfo |
