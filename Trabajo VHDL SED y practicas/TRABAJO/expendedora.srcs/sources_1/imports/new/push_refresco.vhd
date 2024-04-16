library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity push_refresco is
port (
     RESET : in std_logic;-- este reset te devuelve el dinero directamente
     CLK : in std_logic;
     coins_ok: in std_logic;
     PUSHBUTTON : in std_logic_vector(0 TO 2);      
     terminado_ok: out std_logic; 
     LIGHT : out std_logic_vector(0 TO 2); --0 Cocacola 1 Fanta 2 Aquarius
     LIGHT_depositos : out std_logic_vector(0 TO 2); --0 Cocacola 1 Fanta 2 Aquarius
     LIGHT_MOTOR: out std_logic
     );
end push_refresco;

architecture Behavioral of push_refresco is
    --pasar a 1Hz de frecuenciA DE RELOJ
    component prescaler is 
    generic ( relacion: integer := 50000000);--50000000
    PORT ( clk : in  STD_LOGIC; -- 100 MHz
           reset : in  STD_LOGIC;
           clk_out : out  STD_LOGIC
           );
    end component;
    --reloj 1Hz
     signal clk_1Hz: std_logic;
     --FSM
     type STATES is (eleccion_refresco, cocacola, fanta, aquarius, cocacola_surtidor, fanta_surtidor, aquarius_surtidor, completado );
     type eleccion is (nada, cocacola1, fanta1, aquarius1);
     signal current_state, next_state: STATES;
     signal remainig_ticks, nxt_remainig_ticks: unsigned(7 downto 0);        
     signal refresco_state, nxt_refresco_state: eleccion;
   

begin

--    --componente
--    inst_prescaler_1Hz: prescaler
--     port map (
--                clk      => CLK,
--                reset    => RESET,
--                clk_out  => clk_1Hz
--            );   
    CTR : entity work.counter 

    	generic map(
    		C_CNT_BITS  => 8, --: natural := 8;         -- Counter resolution
    		C_CNT_MAX   => 100, --: natural := 200;       -- Maximum count
    		C_OV        => true, --: boolean := false;     -- Overflow mode (true - enabled, false - disabled)
    		C_RSTPOL    => '0'  --: std_logic := '1'      -- Reset poling
    	)
    	port map(
    		-- Inputs
    		clk             => CLK,
    		reset          => RESET,
    		clr            => '0',
    		enable         => '1',
    		-- Output      => ,
    		count          => OPEN,
    		overflow       => clk_1Hz
    	);
    

    election_refresco: process(RESET, clk_1Hz)	
        begin
            if RESET='0' then
                 current_state <= eleccion_refresco;
                 remainig_ticks <= X"00"; --HEX
                 refresco_state <= nada;
                 
                 
            elsif rising_edge(clk_1Hz) then
                 current_state <= next_state;
                 remainig_ticks<= nxt_remainig_ticks;
                 refresco_state <= nxt_refresco_state;
            end if;
    end process;
    
     nextstate_decod: process (PUSHBUTTON, coins_ok, current_state, refresco_state, remainig_ticks)
      --variable enable: std_logic := '1' ;


      --tiempo de encendido del motor
      constant t_encendido_motor: unsigned(7 downto 0) := X"01";
      
      --tiempos de refresco
      constant t_cocacola: unsigned(7 downto 0) := X"01";
      constant t_fanta: unsigned(7 downto 0) := X"01";
      constant t_aquarius: unsigned(7 downto 0) := X"01";
     
      --tiempo en trance de completado
      constant t_completado: unsigned (7 downto 0):= X"01";

      begin
         
        nxt_remainig_ticks <= remainig_ticks - 1;
        next_state <=  current_state;
        nxt_refresco_state <= refresco_state;
         case current_state is
             when eleccion_refresco =>
                 if coins_ok ='1' then 
                    if PUSHBUTTON =  "100" then
                            next_state <= cocacola;
                   		    nxt_refresco_state <= cocacola1;
                   		    nxt_remainig_ticks <= t_encendido_motor;
                            
                    elsif  PUSHBUTTON =  "010" then
                            next_state <= fanta;
                            nxt_refresco_state <= fanta1;
                            nxt_remainig_ticks <= t_encendido_motor;
                            
                    elsif PUSHBUTTON =  "001" then
                            next_state <= aquarius;
                            nxt_refresco_state <= aquarius1;
                            nxt_remainig_ticks <= t_encendido_motor;
                    else
                         nxt_remainig_ticks <= X"00";
                           
                    end if;   
                                
                  end if; 
                    
             when cocacola =>
                if remainig_ticks = 0 then
                    next_state <= cocacola_surtidor;
                    nxt_remainig_ticks <= t_cocacola;     
                end if;
                
             when fanta =>
                if remainig_ticks = 0 then
                    next_state <= fanta_surtidor;
                    nxt_remainig_ticks <= t_fanta;     
                end if;
                
             when aquarius =>
                if remainig_ticks = 0 then
                    next_state <= aquarius_surtidor;
                    nxt_remainig_ticks <= t_aquarius;     
                end if;       
                                         
             when cocacola_surtidor =>
                if remainig_ticks = 0 then 
                    	next_state <= completado;
                    	nxt_refresco_state<= nada;
                end if;
                
             when fanta_surtidor =>
                if remainig_ticks = 0 then
                    	next_state <= completado;
                    	nxt_refresco_state<= nada;
                end if;
             
             when aquarius_surtidor =>
                if remainig_ticks = 0 then
                    next_state <= completado;
                    nxt_refresco_state<= nada;
                       
                end if;
             when completado =>
                 next_state <= eleccion_refresco;
                 nxt_remainig_ticks<= X"00";
             when others =>
                next_state <= eleccion_refresco;
                nxt_remainig_ticks<= X"00";
        
         end case;
         end process;
     

    output_decod_refresco_seleccionado: process (refresco_state)
    begin 
    case refresco_state is 
       		when cocacola1 =>
                 LIGHT <="100" ;
                 LIGHT_MOTOR <='1';
             when fanta1=>
                 LIGHT <="010";
                 LIGHT_MOTOR <='1';
             when aquarius1 =>
                 LIGHT <="001";
                 LIGHT_MOTOR <='1';
             when others =>
                LIGHT <= (OTHERS => '0');
             	LIGHT_MOTOR <='0';
        end case;
    end process; 
    
 terminado_ok <= '1' when current_state = completado else '0';
 
    output_decod_depositos: process (current_state)
         begin         
         case current_state is
             when cocacola =>
                LIGHT_depositos <= "100";
             when fanta =>
                LIGHT_depositos <= "010";
             when aquarius =>
                LIGHT_depositos <= "001";
             when others=>
                 LIGHT_depositos<=(others=>'0');
       end case;
end process;

end Behavioral;