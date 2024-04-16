----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 19:14:28
-- Design Name: 
-- Module Name: MUX_N_EN - Behavioral
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
entity MUX_N_EN is
    GENERIC(FANIN: positive := 4);
    PORT( A: IN MUX_BUS_VECTOR (FANIN -1 TO 0); -- MUX_BUS_VECTOR NO ESTA ACOTADO, HAY QUE HACERLO, AUNQUE TENGA RANGO NO QUIERE DECIR QUE SEA SU LONGITUD, SOLO EL MAXIMO.
    Y: OUT MUX_BUS ;
    S: IN std_logic_vector(integer(ceil(log2(real(fanin)))))
    );
end MUX_N_EN;


architecture dataflow of MUX_N_EN is

begin
    Y<=A(TO_INTEGER(UNSIGNED(S)));

end dataflow;
