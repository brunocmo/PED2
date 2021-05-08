library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exer1clk is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_div : out STD_LOGIC);
end exer1clk;

architecture Behavioral of exer1clk is

signal sclk_div : STD_LOGIC := '0';

begin

process (clk, reset)
variable count: integer range 0 to 2 := 0; -- MUDAR PARA 49_999_999 PARA O BITSTREAM
begin

    if reset = '1' then
        sclk_div <= '0';
        count := 0;
    elsif rising_edge(clk) then
        count := count + 1;
        if count = 2 then                  -- MUDAR PARA 49_999_999 PARA O BITSTREAM
            sclk_div <= not sclk_div;
            count := 0;
        end if;
        
    end if;

end process;
clk_div <= sclk_div;

end Behavioral;
