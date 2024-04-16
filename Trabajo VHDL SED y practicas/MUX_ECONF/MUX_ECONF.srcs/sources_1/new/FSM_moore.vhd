
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- MARINA HA PASADO EL ESQUEMA GRAFICO POR WHATSAPP AL GRUPO DE CHIQUITINES

entity FSM_moore is
    PORT(RESET,CLK,PUSHBUTTON : IN std_logic ;
         LIGHT                : OUT std_logic_vector (1 DOWNTO 0) );
end FSM_moore;

architecture Behavioral of FSM_moore is
    TYPE STATES is (S0,S1,S2,S3); --states de tipo enumerado 
    SIGNAL current_state, next_state: STATES;
begin
    state_register : PROCESS(RESET, CLK)
    begin
        IF RESET = '1' THEN 
            current_state <= S0;
        ELSIF CLK'EVENT AND CLK ='1' then
            current_state <= next_state ;
        END IF;
    END process ;
    
    nextstate: PROCESS (PUSHBUTTON , current_state )
    begin 
        CASE current_state is 
        WHEN S0 => 
            IF PUSHBUTTON ='1' then
                next_state <= S1;
            END IF;
        WHEN S1 => 
            IF PUSHBUTTON ='1' then
                next_state <= S2;
            END IF;
        WHEN S2 => 
            IF PUSHBUTTON ='1' then
                next_state <= S3;
            END IF;
        WHEN S3 => 
            IF PUSHBUTTON ='1' then
                next_state <= S0;
            END IF;
        END CASE;
      END PROCESS;
      
      output_process: PROCESS(current_state )
      begin
            case current_state is 
                WHEN S0 => LIGHT <= "00";
                WHEN S1 => LIGHT <= ('0','1');
                WHEN S2 => LIGHT(0)<= '0'; LIGHT (1)<= '1';
                WHEN S3 => LIGHT <= "11";
            END CASE;
      end process;
end Behavioral;
