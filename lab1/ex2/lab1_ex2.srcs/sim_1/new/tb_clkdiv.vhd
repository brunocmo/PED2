library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity tb_clkdiv is
--  Port ( );
end tb_clkdiv;

architecture Behavioral of tb_clkdiv is

component clkdiv is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clkdiv1s : out STD_LOGIC;
           clkdiv4s : out STD_LOGIC);
end component;

signal sclk : std_logic := '0';
signal sreset : std_logic := '0';
signal sclkdiv1s : std_logic := '0';
signal sclkdiv4s : std_logic := '0';

begin

uut2: clkdiv port map(
        clk => sclk,
        reset => sreset,
        clkdiv1s => sclkdiv1s,
        clkdiv4s => sclkdiv4s
    );
    
sclk <= not sclk after 5 ns;
sreset <= '0', '1' after 15 ns, '0' after 25 ns;


end Behavioral;
