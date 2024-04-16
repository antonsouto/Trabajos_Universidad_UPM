library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity prescaler is
    generic ( relacion: integer := 50_000_000);
    PORT ( clk : in  STD_LOGIC; -- 100 MHz
           reset : in  STD_LOGIC;
           clk_out : out  STD_LOGIC
           );
end prescaler;
  
architecture Behavioral of prescaler is
	signal count: integer range 1 to relacion;
	signal clk_out_i: STD_LOGIC := '0';
	
BEGIN

	frequency_divider: process (clk , reset) 
	BEGIN
	   if reset = '0' then
		   count <= 1;
		   clk_out_i <= '0';
	   elsif clk = '1' and clk'event then
	       if (count = relacion) then
		       count <= 1;
		       clk_out_i <= not (clk_out_i);
		   else
		       count <= count + 1;
		   end if;
        end if;
    end process;
	
	clk_out <= clk_out_i ;
	
end Behavioral;
