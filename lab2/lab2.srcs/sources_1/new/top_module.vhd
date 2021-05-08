library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top_module is
    Port ( clk : in STD_LOGIC;
           H : out STD_LOGIC_VECTOR (7 downto 0);
           ready : out STD_LOGIC);
end top_module;

architecture Behavioral of top_module is

component hipotenusa is
    Port ( clk   : in STD_LOGIC;
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           H : out STD_LOGIC_VECTOR (7 downto 0);
           ready : out STD_LOGIC);
end component;

 --########################## VIO #############################--

COMPONENT vio_fsm_op
  PORT (
    clk : IN STD_LOGIC;
    probe_in0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_in1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

 --########################## ILA #############################--

COMPONENT ila_fsm_op

PORT (
	clk : IN STD_LOGIC;
	probe0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	probe1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0)
);
END COMPONENT  ;

 --############################################################--

-- Declaracao de sinais que se comportam como os fios dentro do top_module

signal wirestart : STD_LOGIC;
signal wirereset : STD_LOGIC;
signal wireready : STD_LOGIC;
signal wireA, wireB : STD_LOGIC_VECTOR(7 downto 0);
signal wireH : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Ligacao dos sinais de saida
    H <= wireH;
    ready <= wireready;

    -- Port map do bloco hipotenusa com seus fios
    uut: hipotenusa port map(
        clk => clk,
        start => wirestart,
        reset => wirereset,
        A => wireA,
        B => wireB,
        H => wireH,
        ready => wireready
        );

    -- Port map do vio com seus respectivos fios de estimulação        
    vio_core : vio_fsm_op
      PORT MAP (
        clk => clk,
        probe_in0 => wireH,
        probe_in1(0) => wireready,
        probe_out0(0) => wirestart,
        probe_out1(0) => wirereset,
        probe_out2 => wireA,
        probe_out3 => wireB
      );
    -- Port map do ila com seus respectivos fios de estimulação  
    ila_core : ila_fsm_op
    PORT MAP (
        clk => clk,
        probe0 => wireH,
        probe1(0) => wireready
    );


end Behavioral;
