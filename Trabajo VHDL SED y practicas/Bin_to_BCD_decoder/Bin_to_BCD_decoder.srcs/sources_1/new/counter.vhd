----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.10.2021 11:24:50
-- Design Name: 
-- Module Name: counter - Behavioral
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
use ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk : in STD_LOGIC;
           CE : in STD_LOGIC;
           code : out STD_LOGIC_VECTOR (3 downto 0);
           resett : in std_logic);
           
end counter;

architecture Behavioral of counter is
begin
    process(clk,CE)
    subtype count is integer range 0 to 9;
    variable contador : count:=0;
    begin
        if resett = '1' then contador := 0;
        elsif clk'event and clk = '1' then
            if CE = '1' and contador < 9 then 
                    contador := contador + 1;
            elsif CE = '1' and contador = 9 then 
                    contador := 0;
            end if;
        end if;
    code <= std_logic_vector( TO_UNSIGNED (contador, code'length));
    end process;
               
end Behavioral;
