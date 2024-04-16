----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2022 13:57:27
-- Design Name: 
-- Module Name: DEMUX_4BIT - Behavioral
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


entity DEMUX_4BIT is
    PORT(DIN: in std_logic;
         SEL: in std_logic_vector(1 downto 0);
         DOUT: OUT std_logic_vector(3 downto 0)
         );
end DEMUX_4BIT;

architecture dataflow of DEMUX_4BIT is
begin
    WITH SEL SELECT
    DOUT <= (0=>DIN, others => '0') WHEN "00",
            (1=>DIN, others => '0') WHEN "01",
            (2=>DIN, others => '0') WHEN "10",
            (3=>DIN, others => '0') WHEN OTHERS;

end dataflow;

-- otra forma 

architecture dataflow of DEMUX_4BIT is
begin 
    --DOUT(0)<= DIN when SEL = "00" else '0';
    DOUT <= ('0','0','0',DIN);
    --DOUT(1)<= DIN when SEL = "01" else '0';
    DOUT <= ("00DIN0");
    DOUT(2)<= DIN when SEL = "10" else '0';
    DOUT(3)<= DIN when SEL = "11" else '0';
end architecture dataflow;