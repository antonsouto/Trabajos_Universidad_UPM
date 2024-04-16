
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity C1_19_20 is
    generic (dif : integer :=2);
    port(
        signal desired_temp : in integer; 
        signal actual_temp  : in integer;
        signal heater_on    : out boolean); 
end C1_19_20;

architecture Behavioral of C1_19_20 is
    
begin
    calentador:process(actual_temp)
    
    begin
    if((actual_temp < desired_temp-dif ))then
         heater_on <= TRUE ;
    elsif((actual_temp > desired_temp-dif ))then
         heater_on <= FALSE ;
    end if;
end process calentador;
end Behavioral;
