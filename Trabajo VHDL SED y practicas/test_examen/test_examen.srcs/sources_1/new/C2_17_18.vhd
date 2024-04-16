library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PWM is
    --generic(REFERENCIA: positive);
    port(
        RESET_N     :   in std_logic ; --reinicia ciclo de trabajo y cuenta iinterna a 0
        CLK         :   in std_logic ; --reloj 
        LOAD_N      :   in std_logic ; --carga asincrona, si esta a '0' la entrada duty se memoriza en flanco CLK 
        DUTY        :   in std_logic_vector(9 downto 0); --valor del nuevo ciclo de trabajo 
        EN          :   in std_logic ; --'0' se detiene cuenta y GATE '0' ....'1' todo funciona 
        GATE        :   out std_logic ); -- señal pwm 
end entity;

architecture beh of PWM is
--subtype periodo is integer (DUTY'RANGE);
--signal MAXcount     :   unsigned(duty'range );
signal MIcount      :   unsigned(duty'range );
signal ciclotrabajo :   unsigned(duty'range );
begin
    counter:process(CLK, RESET_N )

    begin
        if(RESET_N = '0') then
            MIcount <= (others => '0');
        elsif rising_edge(CLK) then
            MIcount <= MIcount +1;
        end if;
    end process counter;
    
    charger:process(CLK, RESET_N )
    begin
        if(RESET_N = '0') then
            ciclotrabajo  <= (others => '0');
        elsif rising_edge(CLK) then
            case EN is
               when '0'=>
                    ciclotrabajo <= (others => '0'); 
               when '1'=> 
                    ciclotrabajo  <= unsigned(DUTY) ;
            end case;
            
        end if;
    end process charger;
    
    GATE <= '0' WHEN EN = '0' or MIcount > ciclotrabajo else '1';
          
end architecture beh ;
------------------------------------------------------------------------------------------------ RESOLUCION PROFESOR
--architecture behavioral of PWM is
--  signal duty_i: unsigned(duty'range);
--  signal cntr_i: unsigned(duty'range);
--begin
  
--  duty_reg: process (reset_n, clk)
--  begin
--    if reset_n = '0' then
--      duty_i <= (others => '0');
--    elsif rising_edge(clk) then
--      if load_n = '0' then
--        duty_i <= unsigned(duty);
--      end if;
--    end if;
--  end process;

--  counter: process (reset_n, clk)
--  begin
--    if reset_n = '0' then
--      cntr_i <= (others => '0');
--    elsif rising_edge(clk) then
--      if en = '0' then
--        cntr_i <= (others => '0');
--      else
--        cntr_i <= cntr_i + 1;
--      end if;
--    end if;
--  end process;

--  comp: gate <= '0' when en = '0' or duty_i <= cntr_i else
--                '1';

--end behavioral;

