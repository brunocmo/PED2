library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity exer1top is
      Port (clk : in STD_LOGIC;
--           reset : in STD_LOGIC;
--           a    : in STD_LOGIC;
           led : out STD_LOGIC);
end exer1top;

architecture Behavioral of exer1top is

component exer1clk is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_div : out STD_LOGIC);
end component;

component exer1fsm is
    Port ( a : in STD_LOGIC;
           clk1 : in STD_LOGIC;
           reset : in STD_LOGIC;
           selclk : out STD_LOGIC;
           duty : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component exer1pwd is
    Port ( clk2 : in STD_LOGIC;
           reset : in STD_LOGIC;
           duty : in STD_LOGIC_VECTOR (3 downto 0);
           pwm_out : out STD_LOGIC);
end component;

component exer1mux is
    Port ( pwm_out : in STD_LOGIC;
           clk1hz : in STD_LOGIC;
           reset : in STD_LOGIC;
           selclk : in STD_LOGIC;
           led : out STD_LOGIC);
end component;

COMPONENT vio_fsmpwm
  PORT (
    clk : IN STD_LOGIC;
    probe_in0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;

signal wireclkdiv : STD_LOGIC := '0';
signal wireduty : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal wirereset : STD_LOGIC := '0';
signal wireA : STD_LOGIC := '0';
signal wirepwm_out : std_logic := '0';
signal wireseletor : std_logic := '0';
signal wireled : std_logic := '0';

begin

    pwm : exer1pwd port map(
        clk2 => clk,
        reset => wirereset,
        duty => wireduty,
        pwm_out => wirepwm_out
    );
    divclk : exer1clk port map(
        clk => clk,
        reset => wirereset,
        clk_div => wireclkdiv
    );
    fsm : exer1fsm port map(
        a => wireA,
        reset => wirereset,
        clk1 => wireclkdiv,
        selclk => wireseletor,
        duty => wireduty
    );
    
    mux: exer1mux port map(
        pwm_out => wirepwm_out,
        clk1hz => wireclkdiv,  
        reset => wirereset,
        selclk =>  wireseletor,
        led => wireled
        );
        
    vio_core : vio_fsmpwm PORT MAP (
        clk => clk,
        probe_in0(0) => wireled,
        probe_out0(0) => wirereset,
        probe_out1(0) => wireA
      );

  led <= wireled;

end Behavioral;
