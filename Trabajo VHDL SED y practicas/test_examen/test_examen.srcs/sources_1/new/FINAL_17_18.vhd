library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity BCD2DEC is
  Port (
        RESET       :   IN std_logic ;
        CLK_N       :   IN std_logic ;
        CE          :   IN std_logic ;
        LOAD_N      :   IN std_logic ;
        DIN         :   IN std_logic_vector(3 downto 0);
        DEC         :   OUT std_logic_vector (9 downto 0)
  );
end BCD2DEC;

architecture Behavioral of BCD2DEC is
signal micuenta : unsigned (din'range);

begin
    CUENTA_P:PROCESS(CLK_N ,RESET )
    begin
        if RESET = '1' then
            micuenta <= (others=>'0');
        elsif CLK_N'event and CLK_N = '0' then
            if LOAD_N = '0'then
                micuenta <= unsigned(DIN );
            end if;
            
            if CE = '1' then
                micuenta <= micuenta +1;
            end if;
        end if;
    end process CUENTA_P ;
    
    DECODER: PROCESS(CLK_N , micuenta )
    begin
        case micuenta is 
            when "0000" => 
                DEC <= "0000000001";
            when "0001" => 
                DEC <= "0000000010";
            when "0010" => 
                DEC <= "0000000100";
            when "0011" => 
                DEC <= "0000001000";                        
            when "0100" => 
                DEC <= "0000010000";
            when "0101" => 
                DEC <= "0000100000";
            when "0110" => 
                DEC <= "0001000000";
            when "0111" => 
                DEC <= "0010000000";
            when "1000" => 
                DEC <= "0100000000";
            when "1001" => 
                DEC <= "1000000000";
            when others => 
                DEC <= (others =>'0');
        end case;
    end process DECODER ;

end Behavioral;
