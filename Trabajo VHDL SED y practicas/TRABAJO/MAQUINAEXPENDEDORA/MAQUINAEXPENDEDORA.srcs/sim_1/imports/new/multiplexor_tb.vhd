library ieee;
use ieee.std_logic_1164.all;

entity tb_MULTIPLEXOR is
end tb_MULTIPLEXOR;

architecture tb of tb_MULTIPLEXOR is

    component MULTIPLEXOR
        port (RESET_N         : in std_logic;
              CLK             : in std_logic;
              display         : out std_logic_vector (6 downto 0);
              STATE           : in std_logic_vector (0 to 3);
              current_display : out std_logic_vector (3 downto 0));
    end component;

    signal RESET_N         : std_logic;
    signal CLK             : std_logic;
    signal display         : std_logic_vector (6 downto 0);
    signal STATE           : std_logic_vector (0 to 3);
    signal current_display : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 5ns; 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : MULTIPLEXOR
    port map (RESET_N         => RESET_N,
              CLK             => CLK,
              display         => display,
              STATE           => STATE,
              current_display => current_display
    );


    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    CLK <= TbClock;

    stimuli : process
    begin
        RESET_N <= '0' after 0.25 * TbPeriod, '1' after 0.75 * TbPeriod;
        
        STATE <= "0000";
        wait for 10ns;
        STATE <="0001";
        wait for 10ns;
        STATE <="0010";
        wait for 10ns;
        STATE <="0011";
        wait for 10ns;
        STATE <="0100";
        wait for 10ns;
        STATE <="0101";
        wait for 10ns;
        STATE <="0110";
        wait for 10ns;
        STATE <="0111";
        wait for 10ns;
        STATE <="1000";
        wait for 10ns;
        STATE <="1001";
        wait for 10ns;
        STATE <="1010";
        wait for 10ns;
        STATE <="1011";
        wait for 10ns;
        
        wait for 100 * TbPeriod;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;



