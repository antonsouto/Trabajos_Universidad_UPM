----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2022 13:36:31
-- Design Name: 
-- Module Name: DEMUX_N_EN - Behavioral
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
use work.MUX_PLEG.all;
use ieee.numeric_std.all; --paquete que hay que añadir para las conversiones de tipo


entity DEMUX_N_EN is
    GENERIC(FANOUT: positive := 4);  --MUX_BUS_VECTOR es vector de vectores 8 bit
    PORT( DOUT: OUT MUX_BUS_VECTOR (FANOUT -1 DOWNTO 0); -- MUX_BUS_VECTOR NO ESTA ACOTADO, HAY QUE HACERLO, AUNQUE TENGA RANGO NO QUIERE DECIR QUE SEA SU LONGITUD, SOLO EL MAXIMO.
    DIN: IN MUX_BUS ; --8 bits
    SEL: IN std_logic_vector(integer(ceil(log2(real(FANOUT)))))
    );
end DEMUX_N_EN;

architecture dataflow of DEMUX_N_EN is
begin
    -- DOUT <= (OTHERS =>'0'); ESTA MAL 
    -- HABRIA0 QUE ASIGNAR CON UN BUCLE FOR A TODAS LAS FILAS ( FANOUT-1 DOWNTO 0) CEROS A LOS 8 BITS ANTES DE HACER LO SIGUIENTE 
    
    DOUT(TO_INTEGER(UNSIGNED(SEL)))<=DIN;
end dataflow ;
