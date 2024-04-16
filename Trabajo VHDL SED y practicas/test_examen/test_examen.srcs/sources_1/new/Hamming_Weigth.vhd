

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Hamming_Weigth is
generic(N:positive:=8);
  Port ( A: in bit_vector (N-1 downto 0);
         HW: out natural range 0 to N );
end Hamming_Weigth;

architecture Behavioral of Hamming_Weigth is
type natural_array is array (A'range+1) of natural(HW'range );
signal internal: natural_array ;
begin

internal(0) <= 0;
mifor:for i in 1 to N generate
    internal(i) <= internal(i-1)+1 when A(i-1)='1' else 
        internal(i-1);
end generate;

end Behavioral;
