
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FINAL_18_19_2 is
    generic (N  :   positive:=8);
    port(   
        clk     :   in std_logic ;
        qs       :   out std_logic_vector(N-1 downto 0));
end FINAL_18_19_2;

architecture STRUCTURAL of FINAL_18_19_2 is
signal  as,bs : std_logic_vector (N downto 0);

    COMPONENT contador is
    port(
        CLK     :   IN std_logic;
        A       :   IN std_logic;
        B       :   IN std_logic;
        C       :   OUT std_logic ;
        Q       :   OUT std_logic );
    END COMPONENT;

begin

    as(0)<='1';
    bs(0)<='1';
    
    gen: FOR i IN 0 TO N-1 GENERATE
    counter: contador PORT MAP (clk, as(i), bs(i), as(i+1), bs(i+1));
    END GENERATE;
    qs <= bs(n-1 downto 0); 


end STRUCTURAL;
