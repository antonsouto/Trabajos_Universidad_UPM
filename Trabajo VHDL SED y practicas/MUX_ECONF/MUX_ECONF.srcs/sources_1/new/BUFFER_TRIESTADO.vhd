----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 18:36:07
-- Design Name: 
-- Module Name: BUFFER_TRIESTADO - Behavioral
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


entity BUFFER_TRIESTADO is
    PORT (A : IN std_logic;
          OE : IN std_logic;
          B : OUT std_logic
          );
        
end entity BUFFER_TRIESTADO;

architecture DATAFLOW of BUFFER_TRIESTADO is

begin
    B <= A WHEN OE = '0' ELSE --activo a nivel bajo
    'Z'; -- Como es un circuito lo que ponemos a la salida es alta impedancia


end architecture DATAFLOW;
