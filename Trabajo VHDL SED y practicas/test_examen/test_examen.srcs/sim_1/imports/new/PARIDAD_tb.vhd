library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; --paquete que hay que añadir para las conversiones de tipo

entity PARIDAD_tb is
end entity;

architecture tb of PARIDAD_tb is

COMPONENT paridad is
generic( N: positive);
port(
    A: in bit_vector(N-1 downto 0);
    B: out bit_vector(N downto 0);
    PARIDAD: out bit);
end COMPONENT; 

signal Atb :bit_vector(7 downto 0); 
signal Btb: bit_vector(8 downto 0);
signal PARIDADtb: bit;

constant k: time    := 10ms; 

begin
uut:PARIDAD 
generic map(8)
port map(
    A => Atb ,
    B => Btb ,
    PARIDAD => PARIDADtb
);

p1:process 
begin
    Atb <= "00000000";
    wait for k;
    
    Atb <= "00000001";
    wait for k;
    
    Atb <= "00000011";
    wait for k;
    
    Atb <= "10000001";
    wait for k;
    
    Atb <= "10000000";
    wait for 3*k;
    
--    assert FALSE 
--    report "Test passed"
--    severity FAILURE ;
    wait;

end process;
end architecture tb ;
