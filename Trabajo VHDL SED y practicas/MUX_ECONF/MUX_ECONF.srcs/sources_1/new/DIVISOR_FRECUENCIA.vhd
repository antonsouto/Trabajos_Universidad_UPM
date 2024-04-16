

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- basicamente un generador de pulsos de longitud un tiempo de CLK 
-- con la frecuencia con respecto a al clk que queramos
entity DIVISOR_FRECUENCIA is
    GENERIC (
        MODULE      :   positive:=6
    );
    PORT(
        RESET       :   IN std_logic ;
        CLK         :   IN std_logic ;
        CE_IN       :   IN std_logic ;
        CE_OUT      :   OUT std_logic 
    );
end DIVISOR_FRECUENCIA;

architecture Behavioral of DIVISOR_FRECUENCIA is

begin
    PROCESS(RESET,CLK)
    subtype count_range is integer (0 to MODULE-1);
    variable count : count_range;
    begin
        if RESET = '1' THEN 
            count := count_range'high ;
            CE_OUT <= '0';
        elsif rising_edge (CLK) THEN 
            CE_OUT <= '0';
            if CE_IN ='1' then
                 IF count /= 0 THEN 
                    count := count -1;
                 ELSE 
                    CE_OUT <= '1'; --salida a 1
                    count := count_range'high ; --reiniciamos la cuenta
                 end if;
            end if;
        end if;
    end process;
    
end Behavioral;
