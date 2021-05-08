library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity ex2top is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (7 downto 0));
end ex2top;

architecture Behavioral of ex2top is

component clkdiv is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clkdiv1s : out STD_LOGIC;
           clkdiv4s : out STD_LOGIC);
end component;

component ex2fsm is
    Port ( clk1s : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR(7 downto 0);
           load_stop : in STD_LOGIC;
           clk4s : in STD_LOGIC;
           start : in STD_LOGIC;
           dir : in STD_LOGIC;
           reset : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (7 downto 0));
end component;

COMPONENT vio_ex2
  PORT (
    clk : IN STD_LOGIC;
    probe_in0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out2 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out3 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

signal wirereset : STD_LOGIC;
signal wireload_stop : STD_LOGIC;
signal wireclk4s : STD_LOGIC;
signal wireclk1s : STD_LOGIC;
signal wirestart : STD_LOGIC;
signal wiredir : STD_LOGIC;
signal wireled : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal wirea : STD_LOGIC_VECTOR(7 DOWNTO 0);

begin

    u1 : clkdiv port map(
        clk => clk,
        reset => wirereset,
        clkdiv1s => wireclk1s,
        clkdiv4s => wireclk4s
    );
    
    u2 : ex2fsm port map(
        A => wirea,
        clk1s => wireclk1s,
        clk4s => wireclk4s,
        reset => wirereset,
        load_stop => wireload_stop,
        dir => wiredir,
        start => wirestart,
        led => wireled       
    );
    
    vio_core : vio_ex2
  PORT MAP (
    clk => clk,
    probe_in0 => wireled,
    probe_out0(0) => wireload_stop,
    probe_out1(0) => wiredir,
    probe_out2(0) => wirestart,
    probe_out3(0) => wirereset,
    probe_out4 => wirea
  );
  
  led <= wireled;

end Behavioral;
