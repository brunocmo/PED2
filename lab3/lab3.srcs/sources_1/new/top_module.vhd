library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_module is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end top_module;

architecture Behavioral of top_module is

component mergePBlaze is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           a : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (7 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           saida: out STD_LOGIC_VECTOR (15 downto 0));
end component;

component decodificador is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           hex : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

COMPONENT vio_core
  PORT (
    clk : IN STD_LOGIC;
    probe_in0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    probe_in1 : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    probe_in2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    probe_out2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

signal ssw : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
signal sa : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');
signal ssel : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');
signal sled : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
signal ssaida : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
signal san : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal sseg: STD_LOGIC_VECTOR (6 downto 0) := (others=>'0');
signal sreset: STD_LOGIC := '0';


begin

    uut1: mergePBlaze port map(
        clk => clk,
        reset => sreset,
        sw => ssw,
        a => sa,
        sel => ssel,
        led => sled,
        saida => ssaida);
        
    uut2: decodificador port map(
        clk => clk,
        reset => sreset,
        hex => ssaida,
        an => san,
        seg => sseg);
      
    uutVio : vio_core
      PORT MAP (
        clk => clk,
        probe_in0 => san,
        probe_in1 => sseg,
        probe_in2 => sled,
        probe_out0(0) => sreset,
        probe_out1 => ssw,
        probe_out2 => sa,
        probe_out3 => ssel
      );
    
    led <= sled;
    an <= san;
    seg <= sseg;

end Behavioral;
