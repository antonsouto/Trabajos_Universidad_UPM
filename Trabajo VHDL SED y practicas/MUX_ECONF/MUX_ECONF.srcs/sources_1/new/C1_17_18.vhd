
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity comparator is
port(   
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    B_GREATER : out std_logic;
    A_GREATER : out std_logic;
    EQUAL : out std_logic );
end entity; 


architecture dataflow of comparator is

begin

B_GREATER <= '1' WHEN signed(A) < signed(B) ELSE
 '0';
EQUAL <= '1' WHEN signed(A) = signed(B) ELSE
 '0';
A_GREATER <= '1' WHEN signed(A) > signed(B) ELSE
 '0';


end architecture dataflow;