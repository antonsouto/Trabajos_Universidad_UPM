library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MULTIPLEXOR is
port (
	RESET_N: in std_logic;
    CLK: in STD_LOGIC; --reloj de la FPGA : 100MHz
    display: out STD_LOGIC_VECTOR(6 downto 0);
    STATE:  in std_logic_vector(0 TO 3);
    current_display: out STD_LOGIC_VECTOR(3 downto 0)
);
end MULTIPLEXOR;

architecture behavioral of MULTIPLEXOR is
signal refresh_state: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal display_vec: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin
  gen_clock: process(RESET_N, CLK)
    constant MAX_REFRESH_COUNT : integer := 500_000; --100Hz
    subtype refresh_count_t is integer range 0 to MAX_REFRESH_COUNT - 1;
    variable refresh_count : refresh_count_t;
    begin
    if RESET_N = '0' then
      refresh_count := 0;
      refresh_state <= (others => '0');
    elsif rising_edge(CLK) then
    current_display <= display_vec;  
      -- contador 100Hz (para refresco del display)
      if refresh_count < refresh_count_t'high - 1 then
        refresh_count := refresh_count + 1;
      else
        refresh_count := 0;
        refresh_state <= refresh_state + 1;
      end if; 
    end if; 
  end process;
  
    show_display: process(refresh_state,STATE)
        begin -- selección del display 
            case refresh_state is 
                when "00" => 
                    display_vec <= "1110"; -- display 0 0111
                when "01" => 
                    display_vec <= "1101"; -- display 1 1011
                when "10" => 
                    display_vec <= "1011"; -- display 2 1101
                when "11" => 
                    display_vec <= "0111"; -- display 3 1110
                when others => 
                    display_vec <= "1111"; 
            end case; 
        
                                           -- mostrar digitos 
            case STATE is 
                when "0000"=> --Estado 0
                    case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "0000001"; -- 0
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                   
                when "0001"=> --Estado 1
                    case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0 
                            when "1011" => 
                        display <= "1001111"; -- 1
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                    
                 when "0010"=> --Estado 2
                    case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "0010010"; -- 2
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                    
                  when "0011"=> --Estado 3
                        case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "0000110"; -- 3
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                    
                  when "0100"=> --Estado 4
                    case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "1001100"; -- 4
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                    
                  when "0101"=> --Estado 5
                  case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "0100100"; -- 5
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                  
                  when "0110"=> --Estado 6
                        case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "1100000"; -- 6
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;  
                    
                 
                  when "0111"=> --Estado 7
                    case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "0001111"; -- 7
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                  
                  when "1000"=> --Estado 8
                    case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "1111111"; -- 8
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                    
                  when "1001"=> --Estado 9
                    case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "0000001"; -- 0
                            when "1011" => 
                        display <= "0001100"; -- 9
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                  
                  when "1010"=> --Estado 10
                    case display_vec is 
                            when "1110" => 
                        display <= "0000001"; -- 0 
                            when "1101" => 
                        display <= "1001111"; -- 1
                            when "1011" => 
                        display <= "0000001"; -- 0
                            when "0111" => 
                        display <= "0000001"; -- 0
                            when others =>
                        display <= "1111111"; 
                    end case;
                    
                  when "1011" =>--Estado 11
                       case display_vec is 
                                when "1110" => 
                            display <= "0111000"; -- F 
                                when "1101" => 
                                
                            display <= "0001000"; -- A
                                when "1011" => 
                            display <= "1001111";-- I
                                when "0111" => 
                                
                            display <= "1110001"; -- L
                                when others =>
                            display <= "1111111";
                        end case;
                    
                    
                   when others =>
                    display <= "1111111"; 
               end case;
	end process;
end behavioral;