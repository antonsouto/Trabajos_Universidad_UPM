library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity frameinit is
    port(
        RESET_N     :   IN std_logic ;
        CLK         :   IN std_logic ;
        SI          :   IN std_logic ;
        START       :   OUT std_logic 
        );
END entity frameinit ;


architecture moore of frameinit is
type ESTADO is(S0 , S1, S10, S101, S1011);
signal current_state, next_estate: ESTADO;

begin

actualizacion_estado:process(CLK , RESET_N )
begin
    if RESET_N = '1' then
        current_state <= S0;
    elsif rising_edge(CLK )then
        current_state <= next_estate ;
    end if;
end process actualizacion_estado ;

fms:process(CLK , RESET_N )
begin
    if rising_edge(CLK ) then
        case current_state is 
            when S0 => 
                if SI = '1' then next_estate <= S1;
                end if;
            when S1 => 
                if SI = '0' then next_estate <= S10;
                else next_estate <= S1;
                end if;
            when S10 => 
                if SI = '1' then next_estate <= S101;
                else next_estate <= S0;
                end if;
            when S101 => 
                if SI = '1' then next_estate <= S1011;
                else next_estate <= S0;
                end if;    
            when S1011 => 
                if SI = '1' then next_estate <= S1;
                else next_estate <= S0;
                end if;
        end case;
    end if;
end process;


START <= '1' when current_state = S1011 else '0'; --salida concurrente

end architecture moore ;