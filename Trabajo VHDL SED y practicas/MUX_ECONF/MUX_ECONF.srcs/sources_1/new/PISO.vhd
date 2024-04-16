

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PIPO is
    GENERIC(
        n               : POSITIVE :=4    
    );
    PORT(
        CLK,LOAD,CLR_N  : IN std_logic;
        PI              : IN std_logic_vector (N-1 DOWNTO 0);
        SO              : OUT std_logic   
    
    );
end PIPO;


architecture Behavioral of PIPO is
    SIGNAL REG : std_logic_vector (PI'length downto 0);
begin
    process(CLR_N, CLK)
    BEGIN
        IF CLR_N ='0' THEN  
            REG <= (OTHERS => '0');
        ELSIF rising_edge (CLK) then    
            IF LOAD ='1' then   
                REG <= PI;
            else
                REG <= '0' & REG (REG'LEFT DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;
    
    SO <= REG(0);
    
end Behavioral;
