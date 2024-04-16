----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2022 14:00:58
-- Design Name: 
-- Module Name: DISPENSADORA_REFRESCOS_tb - Behavioral
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


entity DISPENSADORA_REFRESCOS_tb is
--  Port ( );
end DISPENSADORA_REFRESCOS_tb;

architecture Behavioral of DISPENSADORA_REFRESCOS_tb is
    component DISPENSADORA_REFRESCOS is
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
    end component;
    
    constant CLK_PERIOD : time := 10 ns;
    constant clk_period_1s: time:= 1000ms;
    
    signal button_coins: std_logic_vector(0 to 3);
    signal button_refresco: std_logic_vector(0 to 2);
    signal RESET_N, clk: std_logic;
    signal light_coins: std_logic_vector(0 to 1);
    signal light_refrescos: std_logic_vector(0 to 2);
    signal light_display: std_logic_vector(0 to 6);
    signal light_current_display: std_logic_vector(0 to 3);
    signal light_depositos: std_logic_vector(0 to 2);
    signal light_motor: std_logic;
    

begin

        dut: DISPENSADORA_REFRESCOS
            port map(
                button_coins            => button_coins,
                button_refresco         => button_refresco,
                CLK                     => clk,
                RESET_N                 => RESET_N,
                LIGHT_coins             => light_coins,
                LIGHT_refrescos         => light_refrescos,
                LIGHT_display           => light_display,
                LIGHT_current_display   => light_current_display,
                LIGHT_depositos         => light_depositos,
                LIGHT_motor             => light_motor
            
            );
        
        clk_process : process
        begin
              clk <= '1';
              wait for CLK_PERIOD/2;
              clk <= '0';
              wait for CLK_PERIOD/2;
        end process;

        DISPENSADORA_stimuli: process
        begin
        button_coins <= (others => '0');
        button_refresco <= (others => '0');
        wait for 2*CLK_PERIOD;
        
        RESET_N <= '0' after 0.25 * clk_period_1s, 
                 '1' after 0.75 * clk_period_1s;


        button_refresco <= "000",
                         "010" after 2* clk_period_1s,
                         "000" after 3* clk_period_1s;
            
        button_coins <= "0000",
                        "0100" after 0.5* clk_period_1s,
                        "0100" after 1.5* clk_period_1s;
              
        wait until light_motor'event;
        
        assert false
        report "Fin de la simulacion..."
        severity failure;
        end process;
end Behavioral;
