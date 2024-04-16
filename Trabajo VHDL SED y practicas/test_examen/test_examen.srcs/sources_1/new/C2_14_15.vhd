library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PISO is 
    port( 
        RESET_N     :   in std_logic;--reset negado con prioridad 
        CLK         :   in std_logic;--reloj 
        LOAD_N      :   in std_logic;--carga de dato negada, provoca la carga del dato presente en DIN 
        DIN         :   in std_logic_vector(7 downto 0);--dato a trasmitir 
        SO          :   out std_logic;--salida a '0' cuando reset o despues de trasmitir ultimo bit 
        DONE        :   out std_logic );--'1' despues del reset y tras transmitir el ultimo bit de un dato, '0' en otro caso.
end entity ;



architecture beh of PISO is 
signal carga: std_logic_vector(din'range);

begin

proc:process(CLK, RESET_N )
variable remaining_ticks: integer range 0 to din'length+1 ;
begin   
    if RESET_N = '0' then
        remaining_ticks := 0;
        DONE <= '1';
        SO <= '0';
    elsif rising_edge (CLK )then
        if remaining_ticks = 0 and LOAD_N = '0' then
            carga <= DIN ;
            remaining_ticks := DIN'length+1;
            DONE <= '0';
        elsif remaining_ticks /= 0 then
            remaining_ticks := remaining_ticks -1;
            SO <= carga (remaining_ticks);
        elsif remaining_ticks = 0 then
            DONE <= '1';
            carga <= (others =>'0');
        end if;
    end if;
end process proc;

end architecture beh ;









-------------------------------------------------------------------------------------------------architecture

--architecture behavioral of PISO is
--  signal reg: std_logic_vector(din'range);
--begin
--  process (reset_n, clk)
--    variable remaining: integer range din'range;
--  begin
--    if reset_n = '0' then
--      reg  <= (others => '0');
--      done <= '1';
--      remaining := 0;
--    elsif rising_edge(clk) then
--      if load_n = '0' then
--        reg  <= din;
--        done <= '0';
--        remaining := din'high;
--      elsif remaining /= 0 then
--        reg <= '0' & reg(reg'high downto 1);
--        remaining := remaining - 1;
--      else
--        reg  <= (others => '0');
--        done <= '1';
--      end if;
--    end if;
--  end process;
--  so <= reg(0);
--end behavioral;

