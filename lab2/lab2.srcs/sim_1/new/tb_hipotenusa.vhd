library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_hipotenusa is
--  Port ( );
end tb_hipotenusa;

architecture Behavioral of tb_hipotenusa is

component hipotenusa is
    Port ( clk   : in STD_LOGIC;
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           H : out STD_LOGIC_VECTOR (7 downto 0);
           ready : out STD_LOGIC);
end component;

signal simuclk : STD_LOGIC := '0';
signal simustart : STD_LOGIC := '0';
signal simureset : STD_LOGIC := '0';
signal simuready : STD_LOGIC := '0';
signal simuA : STD_LOGIC_VECTOR (7 downto 0) := "00110000";
signal simuB : STD_LOGIC_VECTOR (7 downto 0) := "01000000";
signal simuH : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

begin

    -- Port map do bloco hipotenusa com seus fios
    uut: hipotenusa port map(
        clk => simuclk,
        start => simustart,
        reset => simureset,
        A => simuA,
        B => simuB,
        H => simuH,
        ready => simuready
        );


simuclk <= not simuclk after 5 ns;
simureset <= '0', '1' after 25 ns, '0' after 35 ns;
simustart <= '0', '1' after 45 ns, '0' after 55 ns, '1' after 145 ns, '0' after 155 ns, '1' after 245 ns, '0' after 255 ns;
simuA <= "01110100" after 100 ns, "00110111" after 200 ns;
simuB <= "10011110" after 100 ns, "00101100" after 200 ns;

end Behavioral;
