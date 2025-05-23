----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2021 10:02:00
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( RESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PUSHBUTTON : in STD_LOGIC;
           LIGHT : out STD_LOGIC_VECTOR (3 downto 0));
end FSM;

architecture Behavioral of FSM is
 type STATES is (S0, S1, S2, S3);
 signal current_state: STATES := S0;
 signal next_state: STATES;

begin

state_register: process (RESET, CLK)
    begin
    -- COMPLETAR
        if RESET = '0' then 
            current_state <= S0;
        elsif CLK'event and CLK = '1' then
            current_state <= next_state;
        end if;
    end process;

 nextstate_decod: process (PUSHBUTTON, current_state)
    begin
        next_state <= current_state;
        case current_state is
            when S0 =>
                if PUSHBUTTON = '1' then
                next_state <= S1;
                end if;
            when S1 =>
                if PUSHBUTTON = '1' then
                next_state <= S2;
                end if;
            when S2 =>
                if PUSHBUTTON = '1' then
                next_state <= S3;
                end if;
            when S3 =>
                if PUSHBUTTON = '1' then
                next_state <= S0;
                end if;
            when others =>
                next_state <= S0;
            end case;
    end process;

 output_decod: process (current_state)
    begin
    LIGHT <= (OTHERS => '0');
        case current_state is
        when S0 =>
            LIGHT(0) <= '1';
        when S1 =>
            LIGHT(1) <= '1';
        when S2 =>
            LIGHT(2) <= '1';
        when S3 =>
            LIGHT(3) <= '1';
        when others =>
            LIGHT <= (OTHERS => '0');
        end case;
    end process;
end Behavioral;
