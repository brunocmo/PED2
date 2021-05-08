library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity exer1pwd is
    Port ( clk2 : in STD_LOGIC;
           reset : in STD_LOGIC;
           duty : in STD_LOGIC_VECTOR (3 downto 0);
           pwm_out : out STD_LOGIC);
end exer1pwd;

architecture Behavioral of exer1pwd is

constant periodo : std_logic_vector(19 downto 0) := "10111011101111101000";
signal preset: std_logic_vector(19 downto 0) := (others=>'0');
signal cnt: std_logic_vector(19 downto 0) := (others=>'0');
signal pwm_aux: std_logic := '0';

begin
    with duty select
        preset <= "10111011101111101000" when "1010", -- 100%
                  "10101000111110000100" when "1001", -- 90%
                  "10010110001100100000" when "1000", -- 80%
                  "10000011011010111100" when "0111", -- 70%
                  "01110000101001011000" when "0110", -- 60%
                  "01011101110111110100" when "0101", -- 50%
                  "01001011000110010000" when "0100", -- 40%
                  "00111000010100101100" when "0011", -- 30%
                  "00100101100011001000" when "0010", -- 20%
                  "00010010110001100100" when "0001", -- 10%
                  "00000000000000000000" when "0000", -- 0%
                  "00000000000000000000" when others; -- 0%

process(clk2,reset)
begin
    if reset='1' then
    cnt <= (others=>'0');
    pwm_aux <= '0';
    elsif rising_edge(clk2) then
        if cnt < preset then
            cnt <= std_logic_vector(unsigned(cnt) + 1);
            pwm_aux <= '1';
        elsif cnt = periodo then
            cnt <= (others=>'0');
        else
            cnt <= std_logic_vector(unsigned(cnt) + 1);
            pwm_aux <= '0';
        end if;
    end if;
end process;

    pwm_out <= pwm_aux;

end Behavioral;
