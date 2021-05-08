library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_ex2top is

end tb_ex2top;

architecture Behavioral of tb_ex2top is

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

signal wirereset : STD_LOGIC := '0';
signal wireA : STD_LOGIC_VECTOR(7 DOWNTO 0) := "10001000";
signal wireload_stop : STD_LOGIC := '0';
signal wireclk4s : STD_LOGIC := '0';
signal wireclk1s : STD_LOGIC := '0';
signal wirestart : STD_LOGIC := '0';
signal wiredir : STD_LOGIC := '0';
signal wireled : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal sclk: std_logic := '0';

begin

    u1 : clkdiv port map(
        clk => sclk,
        reset => wirereset,
        clkdiv1s => wireclk1s,
        clkdiv4s => wireclk4s
    );
    
    u2 : ex2fsm port map(
        a => wireA,
        clk1s => wireclk1s,
        clk4s => wireclk4s,
        reset => wirereset,
        load_stop => wireload_stop,
        dir => wiredir,
        start => wirestart,
        led => wireled       
    );



sclk <= not sclk after 5 ns;
wirereset <= '1', '0' after 25 ns; 
wireload_stop <= '0', '1' after 35 ns, '0' after 75 ns;
wirestart <= '0', '1' after 145 ns, '0' after 165 ns;
wiredir <= '1', '0' after 2 us;



end Behavioral;
