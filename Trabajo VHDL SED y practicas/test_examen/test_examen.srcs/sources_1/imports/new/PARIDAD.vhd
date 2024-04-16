library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; --paquete que hay que añadir para las conversiones de tipo


entity paridad is
generic( N: positive :=8);
port(
    A: in bit_vector(N-1 downto 0);
    B: out bit_vector(N downto 0);
    PARIDAD: out bit);
end entity; 


architecture dataflow of paridad is
signal intermedia: bit_vector (A'range);

begin
intermedia(0)<= A(0);

    mifor:for i in 1 to N-1 generate
        intermedia(i)<=intermedia(i-1) xor A(i);
    end generate mifor; 

PARIDAD <= not intermedia(N-1) ;
B <= PARIDAD & A;
end architecture dataflow ;



