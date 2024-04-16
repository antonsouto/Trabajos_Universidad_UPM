
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DISPENSADORA_REFRESCOS is
    Port
    ( 
            --DINERO INTRODUCIDO    
           button_coins : in STD_LOGIC_VECTOR (0 to 3);--1000 100c, 0100 50c, 0010 20c, 0001 10c
            --SELECCIÓN REFRESCO
           button_refresco : in STD_LOGIC_VECTOR (0 to 2);--100 cocacola1, 010 fanta1, 001 aquarius1
           
           --100MHz
           CLK : in STD_LOGIC;
           RESET_N : in STD_LOGIC;
           LIGHT_coins : out STD_LOGIC_VECTOR (0 to 1);--10 100c, 01 devuelve dinero
           LIGHT_refrescos : out STD_LOGIC_VECTOR (0 to 2);--100 cocacola1, 010 fanta1, 001 aquarius1
           LIGHT_display : out STD_LOGIC_VECTOR (0 to 6);
           LIGHT_current_display : out STD_LOGIC_VECTOR (0 to 3);
           LIGHT_depositos : out STD_LOGIC_VECTOR (0 to 2); --100 cocacola, 010 fanta, 001 aquarius
           LIGHT_motor : out STD_LOGIC --motor dispensador
    );
end DISPENSADORA_REFRESCOS;

architecture Behavioral of DISPENSADORA_REFRESCOS is
--botones de coins
     signal sync_out_coins: std_logic_vector(button_coins'range);
     signal edge_out_coins: std_logic_vector(button_coins'range);
     
--botones de seleccion
     signal sync_out_refresco: std_logic_vector(button_refresco'range);
     signal edge_out_refresco: std_logic_vector(button_refresco'range);
     
--señal que sale de la FSM y push_refresco y entra en la dispensadora_refrescos
    signal coins_ok_100c: std_logic;
    signal terminado_ok: std_logic; 
    
--señal state que sale de la FSM y entra en el mux
    signal STATES: std_logic_vector(0 TO 3);
    
--se trabaja con 1Hz
    component prescaler 
    generic ( relacion: integer := 500_000);-- reduce el periodo a 100 Hz, no hacer caso al nombre de la señal
    PORT ( clk : in  STD_LOGIC; -- 100 MHz
           reset : in  STD_LOGIC;
           clk_out : out  STD_LOGIC
           );
    end component;
    --reloj 1Hz
     signal CLK_1Hz: std_logic;
--COMPONENTES PARA LOS BOTONES    
     component SYNCHRNZR
     port(
         CLK : in std_logic; 
         ASYNC_IN : in std_logic; 
         SYNC_OUT : out std_logic);
     end component;
     
     component EDGEDTCTR
     port(
         CLK : in std_logic; 
         SYNC_IN : in std_logic; 
         EDGE : out std_logic);
     end component;
     
     component FSM_monedas
        generic (
            CLK_FREQ : positive := 100;  -- Reloj que le llega, 100Hz
            T_FAIL   : time := 5 sec
        );
        port(
           PUSHBUTTON       : in STD_LOGIC_VECTOR (0 to 3);
           LIGHT            : out STD_LOGIC_VECTOR (0 to 1);
           RESET_MONEDA     : in STD_LOGIC;
           CLK              : in STD_LOGIC;
           RESTART          : in STD_LOGIC;
           COINS_OK_100C    : out STD_LOGIC;
           STATE            : out STD_LOGIC_VECTOR (0 to 3)
         );
      end component;
      
      component MULTIPLEXOR 
        port(
            RESET_N: in std_logic;
            CLK: in std_logic;
            display: out std_logic_vector(6 downto 0);
            STATE:  in std_logic_vector(0 TO 3);
            current_display: out std_logic_vector(3 downto 0)
         );
      end component;
     
     component push_refresco
        port(
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
     
begin

    --componentes
    inst_prescaler_1Hz: prescaler
     port map (
                clk      => clk,
                reset    => RESET_N,
                clk_out  => clk_1Hz
            );   
            
   sincronizadores_coins: for i in button_coins'range generate
      inst_synchrnzr_i: SYNCHRNZR
            port map (
                clk      => clk_1Hz,
                async_in => button_coins(i),
                sync_out => sync_out_coins(i)
            );
        inst_edgedtctr_i: edgedtctr
            port map (
                clk         => clk_1Hz,
                sync_in     => sync_out_coins(i),
                edge        => edge_out_coins(i)
            );
    end generate;
    
   inst_fsm_monedas: FSM_monedas
            port map(
                RESET_MONEDA => RESET_N,
                CLK          => clk_1Hz,
                PUSHBUTTON   => edge_out_coins,
                restart      => terminado_ok,
                LIGHT        => LIGHT_coins,
                STATE        => STATES,
                COINS_OK_100C => coins_ok_100c
            );
     
     inst_multiplexor : MULTIPLEXOR
            port map (
                RESET_N         => RESET_N,
                CLK             => CLK,
                display         => LIGHT_display,
                STATE           => STATES,
                current_display => LIGHT_current_display 
            );
     
            
--para la eleccion de refrescos 
    sincronizadores_REFRESCOS: for i in button_refresco'range generate
        inst_synchrnzr_i: SYNCHRNZR
            port map (
                clk      => clk_1Hz,
                async_in =>button_refresco(i),
                sync_out => sync_out_refresco(i)
            );
        inst_edgedtctr_i: edgedtctr
            port map (
                clk         => clk_1Hz,
                sync_in     => sync_out_refresco(i),
                edge        => edge_out_refresco(i)
            );
    end generate;
 
 --DISPENSADORA
 
    inst_push_refresco: push_refresco
        port map(
             coins_ok   => coins_ok_100c,
             RESET      => RESET_N,-- este reset te devuelve el dinero directamente
             CLK        => clk_1Hz,
             PUSHBUTTON => edge_out_refresco, 
             terminado_ok => terminado_ok,
             LIGHT      => LIGHT_refrescos,
             LIGHT_depositos => light_depositos,
             LIGHT_MOTOR   => LIGHT_motor
        );
end Behavioral;
