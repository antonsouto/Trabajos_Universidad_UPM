

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity plazaslibres is
    generic(CAPACITY : integer :=255);
    port(
        RESET_N     :   IN std_logic ;  --reinicia el numero de plazas al total
        CLK         :   IN std_logic ;  
        SNSR_IN     :   IN std_logic ;  --pulso de un ciclo de reloj cuando entra un coche, muestreada en flanco positivo clk 
        SNSR_OUT    :   IN std_logic ;  --lo mismo para coche que sale
        FREEPL      :   IN std_logic_vector(7 downto 0);    --numero plazas del sistema 
        LOAD_IN     :   IN std_logic ;  -- si esta a '0' el valor de la entrada FREEPL se carga en el sistema en el siguiente flanco. tiene mas prioridad que los sensores 
        DRIVE_IN    :   OUT std_logic ; --  vale '1' cuando quedan plazas y '0' en otro caso 
        FULL        :   OUT std_logic );    -- vale 1 cuando esta lleno y 0 en otro caso
END entity ;

--architecture profesor of plazaslibres is
--signal rem_places   : unsigned (FREEPL'RANGE);
--signal full_i       : std_logic ;
--signal snsrs        : std_logic_vector(1 downto 0);

--begin
--snsrs <= SNSR_IN & SNSR_OUT ;

--cntr1: process(RESET_N , CLK )
--begin
--    if RESET_N = '0' then   
--        rem_places <= to_unsigned(CAPACITY, rem_places'length);
--    elsif CLK'event and clk='1' then
--        if LOAD_IN = '0' then   
--            rem_places <= unsigned(FREEPL );
--        else
--            case snsrs is 
--                when "10" =>
--                    rem_places <= rem_places - 1;
--                when "01" =>
--                    rem_places <= rem_places + 1;
--                when others =>
--                    rem_places <= rem_places;
--            end case;
--        end if;
--    end if;
--end process;
--cmprtr1:full_i <= '1' when rem_places = 0 else '0';
-- FULL <= full_i;
-- DRIVE_IN <= not full_i;
--end architecture profesor ;

architecture behavioral of plazaslibres is
begin
p1:process(clk, RESET_N )
    subtype cap is integer range 0 to CAPACITY ;
    variable micap: cap:=CAPACITY ;

    begin
        if RESET_N = '1' then
            micap := to_integer(unsigned(FREEPL ));
            DRIVE_IN <= '1';
            FULL <= '0';
        elsif CLK'event and clk='1' then
            if LOAD_IN = '0' then 
                micap := to_integer(unsigned(FREEPL ));
            else
            
                if SNSR_IN = '1' and micap/=0 then 
                    micap := micap -1;
                end if;
            
                if SNSR_OUT = '1' and micap < 255 then
                    micap := micap +1;
                end if;
            end if;
        end if;        
    if micap = 0 then 
        FULL            <= '1'; 
        else FULL       <= '0';
    end if;
    if micap /= 0 then 
        DRIVE_IN        <= '1'; 
        else DRIVE_IN   <= '0';
    end if;
end process;

end architecture behavioral ;