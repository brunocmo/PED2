library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_mergePBlaze is
--  Port ( );
end tb_mergePBlaze;

architecture Behavioral of tb_mergePBlaze is

component DeslTimer is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           led : in STD_LOGIC_VECTOR (15 downto 0);
           sel : in STD_LOGIC_VECTOR (7 downto 0);
           saida16 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal sclk : STD_LOGIC := '0';
signal sreset : STD_LOGIC := '0';
signal sled : STD_LOGIC_VECTOR (15 downto 0) := "0111010000000100";
signal ssel : STD_LOGIC_VECTOR (7 downto 0) := "00000001";


begin

     uut: DeslTimer port map (
               clk => sclk,
               reset => sreset,
               led => sled,
               sel => ssel);

sclk <= not sclk after 5 ns;
sreset <= '0', '1' after 15ns, '0' after 25 ns;


end Behavioral;
