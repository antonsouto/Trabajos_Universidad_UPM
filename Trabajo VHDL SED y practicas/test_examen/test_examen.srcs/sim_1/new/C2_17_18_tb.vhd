library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm_tb is
end pwm_tb;

architecture behavior of pwm_tb is 

  component pwm
    port(
      reset_n: in  std_logic;
      clk    : in  std_logic;
      load_n : in  std_logic;
      duty   : in  std_logic_vector(9 downto 0);
      en     : in  std_logic;
      gate   : out std_logic
    );
  end component;

  --Inputs
  signal reset_n: std_logic;
  signal clk    : std_logic;
  signal load_n : std_logic;
  signal duty   : std_logic_vector(9 downto 0);
  signal en     : std_logic;
  --Outputs
  signal gate : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant duty_value : positive := 256;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: pwm
    port map (
      reset_n => reset_n,
      clk     => clk,
      load_n  => load_n,
      duty    => duty,
      en      => en,
      gate    => gate
    );

  -- Clock process definitions
  clk_process :process
  begin
    clk <= '0';
    wait for 0.5 * clk_period;
    clk <= '1';
    wait for 0.5 * clk_period;
  end process;

  reset_n <= '0' after 0.25 * clk_period, '1' after 0.75 * clk_period;
  
  -- Stimulus process
  stim_proc: process
  begin		
    duty <= std_logic_vector(to_unsigned(duty_value, duty'length));
    en   <= '1';
    load_n <= '1';	

    wait until reset_n = '1';

    wait until clk = '1';
    load_n <= '0';	
    wait until clk = '1';
    load_n <= '1';
    for i in 1 to 2**(duty'length + 1) loop
      wait until clk = '1';
    end loop;

    wait until clk = '1';
    wait until clk = '1';
    wait until clk = '0';
    en   <= '0';
    wait until clk = '1';
    wait until clk = '1';
    wait until clk = '0';
    en   <= '1';
    wait until clk = '1';
    for i in 1 to 2**duty'length loop
      wait until clk = '1';
    end loop;

    wait for 0.5 * clk_period;

    assert false
      report "[SUCCESS]: simulation finished."
      severity failure;
  end process;

end;
