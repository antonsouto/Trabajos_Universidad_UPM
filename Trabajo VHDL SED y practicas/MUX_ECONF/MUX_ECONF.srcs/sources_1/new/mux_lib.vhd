----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 19:34:47
-- Design Name: 
-- Module Name: mux_lib - Behavioral
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

package MUX_PLEG IS 
    SUBTYPE MUX_BUS IS std_logic_vector(7 downto 0);-- "SUBTYPE" ES CUANDO TIENES UN TIPO MAS PEQUEÑO DE OTRO, EN ESTE CASO DE STD_LOGIC_VECTOR
    TYPE MUX_BUS_VECTOR IS ARRAY ( NATURAL RANGE<>) OF MUX_BUS ;-- "TYPE" ES CUANDO ES UN TIPO NUEVO QUE NO DERIVA DE NADA ANTERIOR
END package ;
