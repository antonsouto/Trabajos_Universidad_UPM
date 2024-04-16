
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity SIPO is
    port(                          ---------------------ENTRADAS 
        CLK     :   IN bit ; --RELOJ DEL SISTEMA 
        SS_N    :   IN bit ; --RESET ASINCRONO NEGADO , PONE A 0 LA CUENTA Y EL REGISTRO DE DESPLAZAMIENTO 
        RDY_IN  :   IN bit ; --SOLO SE CUENTA CUANDO ESTA ENTRADA ESTA A '1'
        SIN     :   IN bit ; --ENTRADA SERIE 
                                  ----------------------SALIDAS 
        POUT    :   OUT bit_vector (7 downto 0); --SALIDA DE DATOS PARALELA 
        RDY_OUT :   OUT bit ); --FIN DE LA RECEPCION = '1'
end SIPO;

architecture Behavioral of SIPO is
signal salida: bit_vector (7 downto 0); 
subtype count is integer range 0 to 8;
begin

cuenta:process(CLK , SS_N )
    variable micuenta: count ;
    begin
        RDY_OUT <= '0';
        
        if SS_N = '0' then
        micuenta := 0;
        salida <= (others => '0');
        elsif CLK'event and clk = '1' and RDY_IN = '1' then
            if micuenta /= 8 then
                salida(micuenta) <= SIN;
            else 
                micuenta := 0;
                RDY_OUT <= '1';
            end if;
        end if;
        POUT <= salida;
    end process cuenta ;   

end Behavioral;
