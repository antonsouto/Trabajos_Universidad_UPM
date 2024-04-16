----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2022 17:46:43
-- Design Name: 
-- Module Name: DEMUX_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

    ---------------------------------------------------- ENTIDAD VACIA 
entity DEMUX_tb is
--  Port ( );
end DEMUX_tb;

architecture tb of DEMUX_tb is
    ---------------------------------------------------- COMPONENTE A TESTEAR 
    COMPONENT demux_4bit 
        port (SEL  : in std_logic_vector(1 downto 0);
              DIN  : in std_logic;
              DOUT : out std_logic_vector( 3 downto 0));
    end component ;
   
   
   ------------------------------------------------------ SEÑALES  
    signal SEL    : std_logic_vector( 1 downto 0);
    signal DIN    : std_logic;
    signal DOUT   : std_logic_vector(3 downto 0);
    
begin --------------------------------------------------- COMIENZO DE ARQUITECTURA EN SI 
    ----------------------------------------------------- ASIGNACION DE SEÑALES
    uut: demux_4bit -- SIEMPRE SE HACE EN UNA UNIDAD UNDER TEST 
            port map( SEL  => SEL,
                     DIN  => DIN,
                     DOUT => DOUT);

    stimuli : process 
    begin --A partir de aqui es lo que tenemos que rellenar nosotros cuando lo hace la herramienta 
        SEL <= (others => '0');
        DIN <= '0';
        
        DIN <= '1';
        SEL <= "10";
        
        wait for 10ns;
        
        SEL <= "01";
        
        wait;
    end process;
        
end tb;
