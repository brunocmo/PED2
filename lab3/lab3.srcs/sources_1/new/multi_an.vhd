library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multi_an is
    Port ( seletorMux : in STD_LOGIC_VECTOR(1 DOWNTO 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end multi_an;

architecture Behavioral of multi_an is

begin

WITH seletorMux SELECT
    an <= "0111" when "00",
          "1011" when "01",
          "1101" when "10",
          "1110" when "11",
          "0000" when others;



end Behavioral;
