library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity hipotenusa is
    Port ( clk   : in STD_LOGIC;
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           H : out STD_LOGIC_VECTOR (7 downto 0);
           ready : out STD_LOGIC);
end hipotenusa;

architecture Behavioral of hipotenusa is

component bloco_controle is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk   : in STD_LOGIC;
           lread,lcomp1,ldesl,lsoma,lcomp2 : out STD_LOGIC;
           cread,ccomp1,cdesl,csoma,ccomp2 : out STD_LOGIC;
           ready : out STD_LOGIC);
end component;

component bloco_operacional is
    Port ( clk: in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           lread,lcomp1,ldesl,lsoma,lcomp2 : in STD_LOGIC;
           cread,ccomp1,cdesl,csoma,ccomp2 : in STD_LOGIC;
           H : out STD_LOGIC_VECTOR (7 downto 0));
end component;


signal slread, slcomp1, sldesl, slsoma, slcomp2 : STD_LOGIC;
signal scread, sccomp1, scdesl, scsoma, sccomp2 : STD_LOGIC;

begin


    -- Port map do bloco de controle com seus respectivos fios
    uut1: bloco_controle port map (
        clk => clk,
        start => start,
        reset => reset,
        lread => slread, lcomp1 => slcomp1, ldesl => sldesl, lsoma => slsoma, lcomp2 => slcomp2, 
        cread => scread, ccomp1 => sccomp1, cdesl => scdesl,  csoma => scsoma, ccomp2 => sccomp2,
        ready => ready 
        );
    -- Port map do bloco de operacional com seus respectivos fios
    uut2: bloco_operacional port map (
        clk => clk,
        A => A,
        B => B,
        lread => slread, lcomp1 => slcomp1, ldesl => sldesl, lsoma => slsoma, lcomp2 => slcomp2, 
        cread => scread, ccomp1 => sccomp1, cdesl => scdesl,  csoma => scsoma, ccomp2 => sccomp2,
        H => H 
        );
end Behavioral;
