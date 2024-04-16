-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Sun Nov 21 19:15:50 2021
-- Host        : DESKTOP-0E14V7U running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/SED_LAB/Practica3/Practica3.sim/sim_1/synth/func/xsim/FSM_tb_func_synth.vhd
-- Design      : TOP
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity EDGEDTCTR is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \sreg_reg[0]_0\ : in STD_LOGIC;
    CLK_IBUF_BUFG : in STD_LOGIC
  );
end EDGEDTCTR;

architecture STRUCTURE of EDGEDTCTR is
  signal sreg : STD_LOGIC_VECTOR ( 2 downto 0 );
begin
edge: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => sreg(2),
      I1 => sreg(0),
      I2 => sreg(1),
      O => E(0)
    );
\sreg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => \sreg_reg[0]_0\,
      Q => sreg(0),
      R => '0'
    );
\sreg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => sreg(0),
      Q => sreg(1),
      R => '0'
    );
\sreg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => sreg(1),
      Q => sreg(2),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity FSM is
  port (
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK_IBUF_BUFG : in STD_LOGIC;
    reset_IBUF : in STD_LOGIC
  );
end FSM;

architecture STRUCTURE of FSM is
  signal \FSM_onehot_current_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[0]\ : label is "s1:0010,s2:0100,s0:0001,s3:1000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[1]\ : label is "s1:0010,s2:0100,s0:0001,s3:1000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[2]\ : label is "s1:0010,s2:0100,s0:0001,s3:1000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_current_state_reg[3]\ : label is "s1:0010,s2:0100,s0:0001,s3:1000";
begin
  Q(3 downto 0) <= \^q\(3 downto 0);
\FSM_onehot_current_state[3]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => reset_IBUF,
      O => \FSM_onehot_current_state[3]_i_1_n_0\
    );
\FSM_onehot_current_state_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => E(0),
      D => \^q\(3),
      PRE => \FSM_onehot_current_state[3]_i_1_n_0\,
      Q => \^q\(0)
    );
\FSM_onehot_current_state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => E(0),
      CLR => \FSM_onehot_current_state[3]_i_1_n_0\,
      D => \^q\(0),
      Q => \^q\(1)
    );
\FSM_onehot_current_state_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => E(0),
      CLR => \FSM_onehot_current_state[3]_i_1_n_0\,
      D => \^q\(1),
      Q => \^q\(2)
    );
\FSM_onehot_current_state_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => E(0),
      CLR => \FSM_onehot_current_state[3]_i_1_n_0\,
      D => \^q\(2),
      Q => \^q\(3)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity synchrnzr is
  port (
    \sreg_reg[0]_0\ : out STD_LOGIC;
    CLK_IBUF_BUFG : in STD_LOGIC;
    botton_IBUF : in STD_LOGIC
  );
end synchrnzr;

architecture STRUCTURE of synchrnzr is
  signal \sreg_reg_n_0_[0]\ : STD_LOGIC;
  attribute srl_name : string;
  attribute srl_name of sync_out_reg_srl2 : label is "\Inst_synchrnzr/sync_out_reg_srl2 ";
begin
\sreg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => botton_IBUF,
      Q => \sreg_reg_n_0_[0]\,
      R => '0'
    );
sync_out_reg_srl2: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => '1',
      A1 => '0',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => CLK_IBUF_BUFG,
      D => \sreg_reg_n_0_[0]\,
      Q => \sreg_reg[0]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity TOP is
  port (
    CLK : in STD_LOGIC;
    botton : in STD_LOGIC;
    reset : in STD_LOGIC;
    light : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of TOP : entity is true;
end TOP;

architecture STRUCTURE of TOP is
  signal CLK_IBUF : STD_LOGIC;
  signal CLK_IBUF_BUFG : STD_LOGIC;
  signal Inst_synchrnzr_n_0 : STD_LOGIC;
  signal botton_IBUF : STD_LOGIC;
  signal botton_edge : STD_LOGIC;
  signal light_OBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal reset_IBUF : STD_LOGIC;
begin
CLK_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => CLK_IBUF,
      O => CLK_IBUF_BUFG
    );
CLK_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => CLK,
      O => CLK_IBUF
    );
Inst_edgedtctr: entity work.EDGEDTCTR
     port map (
      CLK_IBUF_BUFG => CLK_IBUF_BUFG,
      E(0) => botton_edge,
      \sreg_reg[0]_0\ => Inst_synchrnzr_n_0
    );
Inst_fsm: entity work.FSM
     port map (
      CLK_IBUF_BUFG => CLK_IBUF_BUFG,
      E(0) => botton_edge,
      Q(3 downto 0) => light_OBUF(3 downto 0),
      reset_IBUF => reset_IBUF
    );
Inst_synchrnzr: entity work.synchrnzr
     port map (
      CLK_IBUF_BUFG => CLK_IBUF_BUFG,
      botton_IBUF => botton_IBUF,
      \sreg_reg[0]_0\ => Inst_synchrnzr_n_0
    );
botton_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => botton,
      O => botton_IBUF
    );
\light_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => light_OBUF(0),
      O => light(0)
    );
\light_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => light_OBUF(1),
      O => light(1)
    );
\light_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => light_OBUF(2),
      O => light(2)
    );
\light_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => light_OBUF(3),
      O => light(3)
    );
reset_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => reset,
      O => reset_IBUF
    );
end STRUCTURE;
