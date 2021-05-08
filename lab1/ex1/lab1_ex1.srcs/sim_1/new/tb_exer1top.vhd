library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_exer1top is

end tb_exer1top;

architecture Behavioral of tb_exer1top is

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

signal sclk : std_logic := '0';
signal wireclkdiv : STD_LOGIC := '0';
signal wireduty : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal wirereset : STD_LOGIC := '0';
signal wireA : STD_LOGIC := '0';
signal wirepwm_out : STD_LOGIC := '0';
signal wireseletor : STD_LOGIC := '0';
signal wireled : STD_LOGIC := '0';

begin

    u1 : exer1pwd port map(
        clk2 => wireclkdiv,
        reset => wirereset,
        duty => wireduty,
        pwm_out => wirepwm_out
    );
    u2 : exer1clk port map(
        clk => sclk,
        reset => wirereset,
        clk_div => wireclkdiv
    );
    u3 : exer1fsm port map(
        a => wireA,
        reset => wirereset,
        clk1 => wireclkdiv,
        duty => wireduty,
        selclk => wireseletor
    );    
    
    u4: exer1mux port map(
        pwm_out => wirepwm_out,
        clk1hz => wireclkdiv,  
        reset => wirereset,
        selclk =>  wireseletor,
        led => wireled
        );
    
    sclk <= not sclk after 5 ns;
    wireA <= '0', '1' after 55 ns, '0' after 75 ns, '1' after 135 ns, '0' after 155 ns, '1' after 175 ns, '0' after 195 ns,
                  '1' after 255 ns, '0' after 275 ns, '1' after 335 ns, '0' after 355 ns;
                --, '1' after 18600 ns, '0' after 18620 ns, '1' after 24800 ns, '0' after 24820 ns;
    wirereset <= '0', '1' after 15 ns, '0' after 45 ns;

end Behavioral;
