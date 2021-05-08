library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodificador is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           hex : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end decodificador;

architecture Behavioral of decodificador is

component hex2bcd is
    port ( hex_in  : in  std_logic_vector (11 downto 0) ;
           bcd_tho : out std_logic_vector (3 downto 0) ;
           bcd_hun : out std_logic_vector (3 downto 0) ;
           bcd_ten : out std_logic_vector (3 downto 0) ;
           bcd_uni : out std_logic_vector (3 downto 0) );
end component;

component clk_div256 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           seletorMux : out STD_LOGIC_VECTOR(1 DownTo 0));
end component;

component multi_an is
    Port ( seletorMux : in STD_LOGIC_VECTOR(1 DOWNTO 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component decoder is
    Port ( entradaBCD : in STD_LOGIC_VECTOR (3 downto 0);
           saidaSEG : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal wirehex_in  : std_logic_vector (11 downto 0) := (others => '0');
signal wirebcd_tho : std_logic_vector (3 downto 0) := (others => '0');
signal wirebcd_hun : std_logic_vector (3 downto 0) := (others => '0');
signal wirebcd_ten : std_logic_vector (3 downto 0) := (others => '0');
signal wirebcd_uni : std_logic_vector (3 downto 0) := (others => '0');
signal wirean : std_logic_vector (3 downto 0) := (others => '0');
signal wireseg : std_logic_vector (6 downto 0) := (others => '0');

signal wireBCDin : std_logic_vector (3 downto 0) := (others => '0');

signal wireseletorMux : STD_LOGIC_VECTOR(1 DownTo 0) := "00";


begin

wirehex_in <= hex(11 downto 0);

 decoHexBCD: hex2bcd port map (
           hex_in  => wirehex_in,
           bcd_tho => wirebcd_tho,
           bcd_hun => wirebcd_hun,
           bcd_ten => wirebcd_ten,
           bcd_uni => wirebcd_uni);
           
  div256Hz: clk_div256 port map (
           clk => clk,
           reset => reset,
           seletorMux => wireseletorMux);
            
  multAnodo: multi_an port map (
           seletorMux => wireseletorMux,
           an => wirean);
          
  decoBCD7seg: decoder port map (
          entradaBCD => wireBCDin,
          saidaSEG => wireseg);

WITH wireseletorMux SELECT
    wireBCDin <=  wirebcd_uni when "00",
                  wirebcd_ten when "01",
                  wirebcd_hun when "10",
                  wirebcd_tho when "11",
                  (others => '0') when others;

an <= wirean;
seg <= wireseg;

end Behavioral;
