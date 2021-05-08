library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_decodificador is
--  Port ( );
end tb_decodificador;

architecture Behavioral of tb_decodificador is

component decodificador is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           hex : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal sclk : STD_LOGIC := '0';
signal sreset : STD_LOGIC := '0';
signal shex : STD_LOGIC_VECTOR (15 downto 0) := "0000000001000000";
signal san : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal sseg : STD_LOGIC_VECTOR (6 downto 0) := "0000000";

begin

 uut: decodificador port map (
           clk => sclk,
           reset => sreset,
           hex => shex,
           an => san,
           seg => sseg);

sclk <= not sclk after 5 ns;
sreset <= '0', '1' after 25 ns, '0' after 45 ns;

end Behavioral;
