library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity push_refresco_tb is
--  Port ( );
end push_refresco_tb;

architecture Behavioral of push_refresco_tb is
    
    component push_refresco
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
    end component;
    
    constant CLK_PERIOD : time := 1 ms;
    signal coins_ok_100c, RESET_N, clk_1Hz, terminado_ok, LIGHT_motor: std_logic;
    signal edge_out_refresco, LIGHT_refrescos, LIGHT_depositos : std_logic_vector (0 to 2);
            
begin

    dut: push_refresco
            port map(
                RESET             => RESET_N,
                CLK               => clk_1Hz,
                coins_ok          => coins_ok_100c,
                PUSHBUTTON        => edge_out_refresco,
                terminado_ok      => terminado_ok,
                LIGHT             => LIGHT_refrescos,
                LIGHT_depositos   => LIGHT_depositos,
                LIGHT_MOTOR       => LIGHT_motor
                );
    
    clk_process : process
    begin
        clk_1Hz <= '1';
        wait for CLK_PERIOD/2;
        clk_1Hz <= '0';
        wait for CLK_PERIOD/2;
    end process;
    
    push_refresco_stimuli: process
    begin
        RESET_N <= '0';
        edge_out_refresco <= (others => '0');
        coins_ok_100c <= '0';
        wait for 5*CLK_PERIOD;
        
        RESET_N <= '1';
        coins_ok_100c <= '1';
        wait for 2*CLK_PERIOD;
        
        edge_out_refresco <= "100";
                             
        wait for 15 sec;
        
        assert false
        report "Fin de la simulacion..."
        severity failure;
     
    end process;

end Behavioral;
