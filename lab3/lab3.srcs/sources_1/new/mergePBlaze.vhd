library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mergePBlaze is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           a : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (7 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           saida: out STD_LOGIC_VECTOR (15 downto 0));
end mergePBlaze;

architecture Behavioral of mergePBlaze is

component Subtrator is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           saida8 : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Multiplicador is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           entrada8 : in STD_LOGIC_VECTOR (7 downto 0);
           a : in STD_LOGIC_VECTOR (7 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component DeslTimer is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           led : in STD_LOGIC_VECTOR (15 downto 0);
           sel : in STD_LOGIC_VECTOR (7 downto 0);
           saida16 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

          signal wiresw   : STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');
          signal wirea    : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
          signal wiresel  : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
          signal wireled  : STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');
          signal wireinout: STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
          signal wiresaida: STD_LOGIC_VECTOR (15 downto 0):= "0000100110011001";
          

begin
 
 
 Sub : Subtrator port map (
           clk => clk,
           reset => reset,
           sw => wiresw,
           saida8 => wireinout);
           
 Mult : Multiplicador port map (
           clk => clk,
           reset => reset,
           entrada8 => wireinout,
           a => wirea,
           led => wireled);
 Desl : DeslTimer port map (
           clk => clk,
           reset => reset,
           led => wireled,
           sel => wiresel,
           saida16 => wiresaida);
  
  wiresw <= sw;
  wirea  <= a;
  wiresel <= sel;
  led <= wireled;
  saida <= wiresaida;         
 

end Behavioral;
