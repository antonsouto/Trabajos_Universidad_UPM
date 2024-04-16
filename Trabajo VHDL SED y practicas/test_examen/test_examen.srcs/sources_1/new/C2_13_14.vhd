library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity NIBBLECNTR is
    generic( cmax: integer := 9); -- como maximo seria igual a 15
    port(   
        RESET_N     :   IN std_logic ; --se resetea cuando vale '0'
        CLK         :   IN std_logic ;
        
        DIN         :   IN std_logic_vector(3 downto 0);
        DOUT        :   OUT std_logic_vector(3 downto 0);
        LOAD        :   IN std_logic;-- si es '1' se hace la precarga de din en memoria,,,,, TIENE PRECEDENCIA SOBRE EL AVANCE
        
        CIN         :   IN std_logic; --SOLO SE AVANZA SI CIN = '1'
        COUT        :   out std_logic ); -- ='1' si se alcanza la cuenta maxima y CIN ='1' ,,,, '0' en cualquier otro caso
end entity;

architecture beh of NIBBLECNTR is
signal carga : unsigned (DIN'RANGE);

begin

cuenta:process(CLK ,RESET_N )
begin
    if RESET_N ='0' then    
        DOUT <= (others =>'0');
        COUT <= '0';
        carga <= (others=>'0');
    elsif rising_edge (CLK ) then
        COUT <= '0';
        if LOAD = '1' then
            carga <= unsigned (DIN);
        elsif CIN = '1' then
            if carga < cmax then
                carga <= carga +1;
            else 
                carga <= (others => '0');
                COUT <= '1';
            end if;
        end if;
    end if;
DOUT <= std_logic_vector (carga) ;
end process cuenta ;

end architecture beh ;