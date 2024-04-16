library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity monoestable is
    --generic ( N     :       positive := 1000);
    port(   
        RESET_N     :       in std_logic ; --termina temporizacion y pone Q a 0 
        CLK         :       in std_logic ;--clk 
        DELAY       :       in std_logic_vector(7 downto 0);--valor de la temporizacion medido en ciclos del clk 
        TRIGGER_N   :       in std_logic ;--disparo sincrono negado, se dispara cuando esta a cero en FP de CLK ,,,,SIEMPRE QUE NO HAYA TEMPORIZACION EN CURSO 
        Q           :       out std_logic );--0 REPOSO 1 PERMANECE TRAS DISPARO EL TIEMPO DE DELAY
end entity;


architecture beh of monoestable is
subtype CUENTA is unsigned (DELAY'range );
signal micuenta: CUENTA;

begin
incremento:process(CLK ,RESET_N )
begin
    if RESET_N = '1' then
        micuenta <= (OTHERS=>'0');
    elsif rising_edge (CLK ) then
        micuenta <= micuenta -1;
    end if;
end process incremento ;

p1:process (CLK ,RESET_N )
begin
    if RESET_N = '1' then 
        Q <= '0';
    elsif CLK'event and CLK = '1' then
        if micuenta = 0 and TRIGGER_N = '0' then
            micuenta <= unsigned (DELAY );
        end if;
    end if;
end process p1;

Q <= '1' when micuenta < 0 else '0';
            


end architecture ;

