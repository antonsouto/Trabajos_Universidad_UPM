library ieee;
use ieee.std_logic_1164.all;
 
entity PISO_tb is
end PISO_tb;
 
architecture behavior of PISO_tb is 
 
  -- Component Declaration for the Unit Under Test (UUT)
  component PISO
    port(
      reset_n : in  std_logic;
      clk : in  std_logic;
      load_n : in  std_logic;
      din : in  std_logic_vector(7 downto 0);
      so : out  std_logic;
      done : out  std_logic
    );
  end component;
    

  --Inputs
  signal reset_n: std_logic;
  signal clk    : std_logic;
  signal load_n : std_logic;
  signal din    : std_logic_vector(7 downto 0);

  --Outputs
  signal so : std_logic;
  signal done : std_logic;

  -- Clock period definitions
  constant clk_period: time := 10 ms;
  constant delay     : time :=  1 ms;
 
begin
 
  -- Instantiate the Unit Under Test (UUT)
  uut: PISO port map (
    reset_n => reset_n,
    clk     => clk,
    load_n  => load_n,
    din     => din,
    so      => so,
    done    => done
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

  check_reset: process
  begin
    wait until reset_n = '0';
    wait for delay;
    assert so = '0'
      report "SO should be 0 after reset."
      severity failure;
    assert done = '1'
      report "DONE should be 1 after reset."
      severity failure;
  end process;

  -- stimulus process
  stim_proc: process
  begin
    wait until reset_n = '0';
    wait for 0.25 * clk_period;
    din    <= (others => '0');
    load_n <= '1';
    wait until reset_n = '1';
    wait until clk = '0';
    wait for 0.25 * clk_period;
    din    <= "10001010";
    load_n <= '0';
    wait until clk = '1';
    wait for 0.25 * clk_period;
    load_n <= '1';
    for i in 1 to 10 loop
      wait until clk = '1';	
    end loop;

    assert false
      report "[SUCCESS]: Simulation passed"
      severity failure;
  end process;

end;
