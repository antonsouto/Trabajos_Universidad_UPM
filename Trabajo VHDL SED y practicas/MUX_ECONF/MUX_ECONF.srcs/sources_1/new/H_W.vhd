----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2022 17:42:46
-- Design Name: 
-- Module Name: H_W - Behavioral
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
use ieee.numeric_std.all;
-- PROGRAMA QUE CUENTA EL NUMERO DE 1'S QUE TIENE UN VECTOR DE BITS
entity H_W is
generic (N:integer:=8); 
PORT(X: in std_logic_vector ( N -1 downto 0);
     Y: out natural range 0 to N); 
--  Port ( );
end H_W;

architecture dataflow of H_W is
    type natural_array is array (0 to n) of natural range 0 to n;
    signal internal : natural_array; --vector que almacena el numero de "unos" 
    
begin
    internal(0) <= 0;
    gen: for i in 1 to n generate   
            internal(i) <= internal (i-1) +1 when x(i-1) ='1' else internal(i-1);
            -- la señal interna nos sirve para "asignar diferentes valores a la misma señal dentro de un bucle"
            -- porque no tenemos diferentes asignaciones si no diferentes posiciones del vector de dicha señal 
            -- a las cuales se le asignan diferentes valres, pero tecnicamente son DIFERENTES SEÑALES porque fisicamente fisicamente 
            -- son cables distintos -> señales distintas 
         end generate;
    y <= internal (n); 
end dataflow;
