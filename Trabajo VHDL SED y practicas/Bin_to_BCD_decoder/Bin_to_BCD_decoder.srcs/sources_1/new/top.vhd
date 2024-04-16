----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.10.2021 10:12:50
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( 
           button : in std_logic;
           clk : in std_logic;
           
           code : in STD_LOGIC_VECTOR (3 downto 0);
           digsel : in STD_LOGIC_VECTOR (3 downto 0);
           digctrl : out STD_LOGIC_VECTOR (3 downto 0);
           segment : out STD_LOGIC_VECTOR (6 downto 0));
end top;

architecture Behavioral of top is
        signal botton_sinc : std_logic;
        signal botton_edge : std_logic;

            COMPONENT decoder
                PORT (
                    code : IN std_logic_vector(3 DOWNTO 0);
                    led : OUT std_logic_vector(6 DOWNTO 0)
                );
            END COMPONENT;
            
            COMPONENT synchrnzr 
                Port (
                    clk : in STD_LOGIC;
                    async_in : in STD_LOGIC;
                    sync_out : out STD_LOGIC);
            END COMPONENT;
            
            COMPONENT EDGEDTCTR 
                Port ( 
                    clk : in STD_LOGIC;
                    sync_in : in STD_LOGIC;
                    edge : out STD_LOGIC);
            END COMPONENT;
            
            COMPONENT counter 
                Port ( 
                    clk : in STD_LOGIC;
                    CE : in STD_LOGIC;
                    code : out STD_LOGIC_VECTOR (3 downto 0));
            END COMPONENT;
BEGIN

    Inst_synchrnzr: synchrnzr 
            PORT MAP (
                clk => clk,
                async_in => button,
                sync_out => botton_sinc
                );
                
    Inst_edgedtctr: EDGEDTCTR PORT MAP(
                clk => clk,
                sync_in => botton_sinc,
                edge => botton_edge
                );                  
    
    Inst_counter: counter PORT MAP(
                clk => clk,
                CE => botton_edge,
                code => code
                );
                
    Inst_decoder: decoder PORT MAP (
                code => code ,
                led => segment
                );
digctrl <= NOT digsel;
end Behavioral;
