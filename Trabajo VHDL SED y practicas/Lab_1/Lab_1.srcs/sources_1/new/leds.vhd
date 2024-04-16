----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2021 18:47:45
-- Design Name: 
-- Module Name: leds - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity leds is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end leds;

architecture Behavioral of leds is
Signal led_int : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";

begin
led <= led_int;
led_int(0) <= not(sw(0));
led_int(1) <= sw(1) and not(sw(2));
led_int(3) <= SW(2) and sw(3);
led_int(2) <= led_int(1) or led_int(3);
led_int(7 downto 4) <= SW(7 downto 4);

end Behavioral;
