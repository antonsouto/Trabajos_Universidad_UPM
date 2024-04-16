library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity FSM_monedas is
    generic (
        CLK_FREQ : positive := 100;  -- clk que le llega, 100Hz
        T_FAIL   : time := 5 sec
    );
    
    Port ( PUSHBUTTON : in STD_LOGIC_VECTOR (0 to 3); --simulan la entrada de monedas
           LIGHT : out STD_LOGIC_VECTOR (0 to 1); --se enciende el led 0 si esta en S10 y led 1 si esta en S11
           RESET_MONEDA : in STD_LOGIC; --devuelve el dinero directamente
           CLK : in STD_LOGIC;
           RESTART : in STD_LOGIC;
           COINS_OK_100C : out STD_LOGIC;
           STATE : out STD_LOGIC_VECTOR (0 to 3)); --devuelve el estado actual a la maquina
end FSM_monedas;

architecture Behavioral of FSM_monedas is

    constant T_FAIL_TICKS : positive := CLK_FREQ * T_FAIL / 1 sec;
 
    type STATES is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11); --s0:0c, s1:10c, s2:20c, s3:30c, s4:40c, s5:50c, s6:60c, s7:70c, s8:80c, s9:90, s10:100c, s11:DEVUELVEDINERO
    signal current_state : STATES;
    signal next_state    : STATES;

    subtype ticks_t is integer range 0 to T_FAIL_TICKS;
    signal remainig_ticks, nxt_remainig_ticks: ticks_t; 

begin
    state_register: process (CLK, RESET_MONEDA)
    begin
        if RESET_MONEDA = '0' then
            current_state  <= S0;
            remainig_ticks <= 0;
        elsif CLK'event and CLK = '1' then
            current_state  <= next_state;
            remainig_ticks <= nxt_remainig_ticks;
        end if;
    end process;

    nextstate_decod: process (current_state, remainig_ticks, PUSHBUTTON, RESTART, CLK)
    begin
        next_state         <= current_state;
        nxt_remainig_ticks <= remainig_ticks;

        case current_state is
            when S0 => --hay 0c
                if PUSHBUTTON = "0001" then --meto 10c
                    next_state <= S1;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S2;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S5;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S10;
                end if;
                
            when S1 => --hay 10c
                if PUSHBUTTON = "0001" then --meto 10c
                    next_state <= S2;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S3;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S6;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
                
            when S2 => --hay 20c
                if PUSHBUTTON = "0001" then --meto 10c
                    next_state <= S3;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S4;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S7;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
                
            when S3 => --hay 30c
                if PUSHBUTTON = "0001" then --meto 10c
                    next_state <= S4;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S5;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S8;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
                
            when S4 => --hay 40c
                if PUSHBUTTON = "0001" then --meto 10c
                    next_state <= S5;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S6;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S9;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
           
            when S5 => --hay 50c 
                if PUSHBUTTON = "0001" then
                    next_state <= S6;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S7;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S10;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
           
            when S6 => --hay 60c 
                if PUSHBUTTON = "0001" then
                    next_state <= S7;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S8;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
                
            when S7 => --hay 70c 
                if PUSHBUTTON = "0001" then
                    next_state <= S8;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S9;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
                
            when S8 => --hay 80c 
                if PUSHBUTTON = "0001" then
                    next_state <= S9;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S10;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
            
            when S9 => --hay 90c 
                if PUSHBUTTON = "0001" then
                    next_state <= S10;
                elsif PUSHBUTTON = "0010" then --meto 20c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                elsif PUSHBUTTON = "0100" then --meto 50c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                elsif PUSHBUTTON = "1000" then --meto 100c
                    next_state <= S11;
                    nxt_remainig_ticks <= T_FAIL_TICKS;
                end if;
            when S10 => --hay 100c
                if restart = '1' then 
                    next_state <= S0;
                end if; 
            when S11 => -- hay mas de 100c 
               if remainig_ticks /= 0 then
                    nxt_remainig_ticks <= remainig_ticks - 1;
                else
                    next_state <= S0;     
                end if;
      
            when others =>
                nxt_remainig_ticks <= T_FAIL_TICKS;
                next_state <= S0;
        end case;
    end process;

    output_decod: process (current_state, remainig_ticks)
    begin
        LIGHT        <= (others => '0');
        COINS_OK_100C <= '0';

        case current_state is
            when S0 =>
                STATE <= "0000";

            when S1 =>
                STATE <= "0001";

            when S2 =>
                STATE <= "0010";

            when S3 =>
                STATE <= "0011";

            when S4 =>
                STATE <= "0100";
           
            when S5 => 
                STATE <= "0101";
                
            when S6 => 
                STATE <= "0110";
                
            when S7 => 
                STATE <= "0111";
                
            when S8 => 
                STATE <= "1000";
                
            when S9 => 
                STATE <= "1001";

            when S10 =>
                STATE <= "1010";
                LIGHT <= "10";
                COINS_OK_100C <= '1';

            when S11=>
                STATE <= "1011";
                LIGHT <= "01";

            when others =>
                STATE <= "1111";
        end case;
    end process;
end architecture BEHAVIORAL;