library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity contador is
    port(
        CLK     :   IN std_logic;
        A       :   IN std_logic;
        B       :   IN std_logic;
        C       :   OUT std_logic ;
        Q       :   OUT std_logic );
END ENTITY;


architecture beh of contador is
signal qi : std_logic ;
begin

cuenta:process(clk,a,b)
variable di, ci: std_logic ;
begin
    ci:= A and B;
    di:= ci xor qi;
    if rising_edge (CLK )then
        qi <= di;
    end if;       
        
end process;
Q   <=  qi;

end architecture beh ;