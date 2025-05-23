----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2021 11:13:15
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
    Port ( in1 : in STD_LOGIC_VECTOR (1 downto 0);
           in2 : in STD_LOGIC_VECTOR (1 downto 0);
           s : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (1 downto 0));
end mux;

architecture Behavioral of mux is

begin

    process
    begin
        if s = '0' then y (1 downto 0) <= in1 (1 downto 0);
        else y (1 downto 0) <= in2 (1 downto 0);
        end if;
    end process;


end Behavioral;
