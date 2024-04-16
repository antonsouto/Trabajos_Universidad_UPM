----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2021 10:49:24
-- Design Name: 
-- Module Name: TOP - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
    Port ( CLK : in STD_LOGIC;
           botton : in STD_LOGIC;
           reset : in STD_LOGIC;
           light : out STD_LOGIC_VECTOR (3 downto 0));
end TOP;

architecture Behavioral of TOP is
 signal botton_sinc: std_logic;
 signal botton_edge: std_logic;
 
 --DECLARACION COMPONENTE SINCRONIZADOR 
 COMPONENT synchrnzr is
    Port ( clk : in STD_LOGIC;
           async_in : in STD_LOGIC;
           sync_out : out STD_LOGIC);
end COMPONENT;
 --DECLARACION COMPONENTE EDGEDTCTR 
 COMPONENT EDGEDTCTR is
    Port ( clk : in STD_LOGIC;
           sync_in : in STD_LOGIC;
           edge : out STD_LOGIC);
end COMPONENT;
--DECLARACION DEL COMPONENTE FSM 
COMPONENT FSM is
    Port ( RESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PUSHBUTTON : in STD_LOGIC;
           LIGHT : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

begin
--INSTANCIACION COMPONENTE SINCRONIZADOR 
Inst_synchrnzr: synchrnzr PORT MAP(
    clk => CLK,
    async_in => botton,
    sync_out => botton_sinc
);
--INSTANCIACION COMPONENTE EDGEDTCTR 
Inst_edgedtctr: edgedtctr PORT MAP(
    clk => CLK,
    sync_in => botton_sinc,
    edge => botton_edge
);
--INSTANCIACION COMPONENTE FSM 
Inst_fsm: FSM PORT MAP(
RESET => reset,
CLK => CLK,
PUSHBUTTON => botton_edge,
LIGHT => light
);

end Behavioral;
