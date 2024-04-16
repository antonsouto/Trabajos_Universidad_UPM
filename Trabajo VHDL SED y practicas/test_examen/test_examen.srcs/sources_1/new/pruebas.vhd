library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity PWM is
    port(
        RESET_N     :   IN std_logic ;
        CLK         :   IN std_logic ;
        LOAD_N      :   IN std_logic ;
        DUTY        :   IN std_logic_vector (9 downto 0);
        EN          :   IN std_logic ;
        GATE        :   OUT std_logic  
        );
end entity;


architecture beh of PWM is
signal ciclotrabajo : unsigned (DUTY'range );
signal micuenta : unsigned (DUTY'range );
signal output: std_logic ;
begin

cuenta:process (CLK ,   RESET_N )
    begin
        if RESET_N = '0' then
            micuenta  <= (others => '0');
        elsif rising_edge (CLK )then
            if EN = '0' then
                GATE <= '0';
            elsif EN = '1' then
                if LOAD_N = '0' then
                    ciclotrabajo <= unsigned(DUTY) ;
                end if;
                micuenta <= micuenta +1;
            end if;
        end if;
end process cuenta ;

comparador: process(CLK , micuenta, ciclotrabajo )
begin
    if micuenta <= ciclotrabajo then 
        output <= '1';
    else
        output <= '0';
    end if;
end process comparador ;

GATE <= output ; --sentencia concurrente

end architecture beh ;
