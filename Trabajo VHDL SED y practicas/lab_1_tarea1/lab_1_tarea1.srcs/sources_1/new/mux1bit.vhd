----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2021 10:47:05
-- Design Name: 
-- Module Name: mux1bit - Behavioral
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

entity mux1bit is
    Port ( in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           s : in STD_LOGIC;
           y : out STD_LOGIC);
end mux1bit;

architecture Behavioral of mux1bit is

begin
    
    process (in1, in2, s)
    begin
        if s = '0' then y <= in1;
        else y <= in2;
        end if;
    end process;

end Behavioral;
