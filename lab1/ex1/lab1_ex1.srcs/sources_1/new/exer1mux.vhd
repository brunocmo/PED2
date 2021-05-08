library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity exer1mux is
    Port ( pwm_out : in STD_LOGIC;
           clk1hz : in STD_LOGIC;
           reset : in STD_LOGIC;
           selclk : in STD_LOGIC;
           led : out STD_LOGIC);
end exer1mux;

architecture Behavioral of exer1mux is

signal ledpisca : std_logic := '0';

begin

process (clk1hz, reset)
begin
    if reset ='1' then
        ledpisca <= '0';
    elsif rising_edge(clk1hz) then
        ledpisca <= pwm_out and (not ledpisca);
    end if;
end process;

    led <= pwm_out when selclk = '0' else
           ledpisca when selclk = '1';

end Behavioral;
