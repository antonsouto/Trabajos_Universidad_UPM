
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PDM is
  Port ( 
    RESET_N : IN std_logic ;--reset asincrono negado , reinicia el muestreo y carga registro de salida a 127
    CLK     : IN std_logic ;--reloj de 2.4 Mhz
    CE_N    : IN std_logic ;--habilitacion de reloj negada
    SIN     : IN std_logic; --entrada serie que se registra en los flancos de reloj 
    POUT    : OUT std_logic_vector(7 downto 0);--salida paralelo 
    READY   : OUT std_logic --se pone a 1 durante un ciclo de reloj cuando se actualiza el registro de salida 
  );
end PDM;

architecture Behavioral of PDM is

begin

contador:process(CLK , RESET_N )
subtype cont_t is integer range 0 to 255;
variable rem_smpls  :   cont_t ;
variable ones       :   cont_t ;
begin
    if RESET_N = '0' then
        rem_smpls := 255;
        ones := 0;
        POUT <= std_logic_vector(to_unsigned(127,POUT 'length ));
        READY <= '0';
    elsif rising_edge (CLK ) and CE_N = '0' then
        READY <= '0';
        if ones /= 255 and SIN = '1' then
            ones := ones +1;
        end if;
        if rem_smpls /= 0 then
            rem_smpls := rem_smpls -1;
            
        else
            POUT <= std_logic_vector(to_unsigned(ones,POUT 'length ));
            READY <= '1';
            rem_smpls := 255;
            ones := 0;
        end if;
    end if;
            

end process contador;


end Behavioral;
