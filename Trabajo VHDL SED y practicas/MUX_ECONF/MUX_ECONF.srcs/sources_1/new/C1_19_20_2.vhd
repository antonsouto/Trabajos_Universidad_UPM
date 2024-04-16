----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2022 09:06:38
-- Design Name: 
-- Module Name: C1_19_20_2 - Behavioral
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

entity paridad is
generic( N : integer:=8);
port(
    x : in std_logic_vector (N-1 downto 0);
    y : out std_logic_vector (N downto 0)     
    );
    end entity;

architecture dataflow of paridad is
signal internal: std_logic_vector(N-1 downto 0);

begin

    internal(0) <= x(0);
    gen: for i in 1 to n-1 generate
        internal(i) <= internal(i-1) XOR x(i);
    end generate gen;
    
    y <= internal (n-1) & x;

end architecture dataflow;