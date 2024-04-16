// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Sun Nov 21 19:16:54 2021
// Host        : DESKTOP-0E14V7U running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/SED_LAB/Practica3/Practica3.sim/sim_1/synth/timing/xsim/FSM_tb_time_synth.v
// Design      : TOP
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

module EDGEDTCTR
   (E,
    \sreg_reg[0]_0 ,
    CLK_IBUF_BUFG);
  output [0:0]E;
  input \sreg_reg[0]_0 ;
  input CLK_IBUF_BUFG;

  wire CLK_IBUF_BUFG;
  wire [0:0]E;
  wire [2:0]sreg;
  wire \sreg_reg[0]_0 ;

  LUT3 #(
    .INIT(8'h02)) 
    \edge 
       (.I0(sreg[2]),
        .I1(sreg[0]),
        .I2(sreg[1]),
        .O(E));
  FDRE #(
    .INIT(1'b0)) 
    \sreg_reg[0] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\sreg_reg[0]_0 ),
        .Q(sreg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sreg_reg[1] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(sreg[0]),
        .Q(sreg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sreg_reg[2] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(sreg[1]),
        .Q(sreg[2]),
        .R(1'b0));
endmodule

module FSM
   (Q,
    E,
    CLK_IBUF_BUFG,
    reset_IBUF);
  output [3:0]Q;
  input [0:0]E;
  input CLK_IBUF_BUFG;
  input reset_IBUF;

  wire CLK_IBUF_BUFG;
  wire [0:0]E;
  wire \FSM_onehot_current_state[3]_i_1_n_0 ;
  wire [3:0]Q;
  wire reset_IBUF;

  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_current_state[3]_i_1 
       (.I0(reset_IBUF),
        .O(\FSM_onehot_current_state[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "s1:0010,s2:0100,s0:0001,s3:1000" *) 
  FDPE #(
    .INIT(1'b1)) 
    \FSM_onehot_current_state_reg[0] 
       (.C(CLK_IBUF_BUFG),
        .CE(E),
        .D(Q[3]),
        .PRE(\FSM_onehot_current_state[3]_i_1_n_0 ),
        .Q(Q[0]));
  (* FSM_ENCODED_STATES = "s1:0010,s2:0100,s0:0001,s3:1000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[1] 
       (.C(CLK_IBUF_BUFG),
        .CE(E),
        .CLR(\FSM_onehot_current_state[3]_i_1_n_0 ),
        .D(Q[0]),
        .Q(Q[1]));
  (* FSM_ENCODED_STATES = "s1:0010,s2:0100,s0:0001,s3:1000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[2] 
       (.C(CLK_IBUF_BUFG),
        .CE(E),
        .CLR(\FSM_onehot_current_state[3]_i_1_n_0 ),
        .D(Q[1]),
        .Q(Q[2]));
  (* FSM_ENCODED_STATES = "s1:0010,s2:0100,s0:0001,s3:1000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[3] 
       (.C(CLK_IBUF_BUFG),
        .CE(E),
        .CLR(\FSM_onehot_current_state[3]_i_1_n_0 ),
        .D(Q[2]),
        .Q(Q[3]));
endmodule

(* NotValidForBitStream *)
module TOP
   (CLK,
    botton,
    reset,
    light);
  input CLK;
  input botton;
  input reset;
  output [3:0]light;

  wire CLK;
  wire CLK_IBUF;
  wire CLK_IBUF_BUFG;
  wire Inst_synchrnzr_n_0;
  wire botton;
  wire botton_IBUF;
  wire botton_edge;
  wire [3:0]light;
  wire [3:0]light_OBUF;
  wire reset;
  wire reset_IBUF;

initial begin
 $sdf_annotate("FSM_tb_time_synth.sdf",,,,"tool_control");
end
  BUFG CLK_IBUF_BUFG_inst
       (.I(CLK_IBUF),
        .O(CLK_IBUF_BUFG));
  IBUF CLK_IBUF_inst
       (.I(CLK),
        .O(CLK_IBUF));
  EDGEDTCTR Inst_edgedtctr
       (.CLK_IBUF_BUFG(CLK_IBUF_BUFG),
        .E(botton_edge),
        .\sreg_reg[0]_0 (Inst_synchrnzr_n_0));
  FSM Inst_fsm
       (.CLK_IBUF_BUFG(CLK_IBUF_BUFG),
        .E(botton_edge),
        .Q(light_OBUF),
        .reset_IBUF(reset_IBUF));
  synchrnzr Inst_synchrnzr
       (.CLK_IBUF_BUFG(CLK_IBUF_BUFG),
        .botton_IBUF(botton_IBUF),
        .\sreg_reg[0]_0 (Inst_synchrnzr_n_0));
  IBUF botton_IBUF_inst
       (.I(botton),
        .O(botton_IBUF));
  OBUF \light_OBUF[0]_inst 
       (.I(light_OBUF[0]),
        .O(light[0]));
  OBUF \light_OBUF[1]_inst 
       (.I(light_OBUF[1]),
        .O(light[1]));
  OBUF \light_OBUF[2]_inst 
       (.I(light_OBUF[2]),
        .O(light[2]));
  OBUF \light_OBUF[3]_inst 
       (.I(light_OBUF[3]),
        .O(light[3]));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
endmodule

module synchrnzr
   (\sreg_reg[0]_0 ,
    CLK_IBUF_BUFG,
    botton_IBUF);
  output \sreg_reg[0]_0 ;
  input CLK_IBUF_BUFG;
  input botton_IBUF;

  wire CLK_IBUF_BUFG;
  wire botton_IBUF;
  wire \sreg_reg[0]_0 ;
  wire \sreg_reg_n_0_[0] ;

  FDRE #(
    .INIT(1'b0)) 
    \sreg_reg[0] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(botton_IBUF),
        .Q(\sreg_reg_n_0_[0] ),
        .R(1'b0));
  (* srl_name = "\Inst_synchrnzr/sync_out_reg_srl2 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    sync_out_reg_srl2
       (.A0(1'b1),
        .A1(1'b0),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK_IBUF_BUFG),
        .D(\sreg_reg_n_0_[0] ),
        .Q(\sreg_reg[0]_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
