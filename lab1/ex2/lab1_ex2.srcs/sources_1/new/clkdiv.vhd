library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity clkdiv is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clkdiv1s : out STD_LOGIC;
           clkdiv4s : out STD_LOGIC);
end clkdiv;

architecture Behavioral of clkdiv is

signal saidaclock1s : std_logic := '0';
signal saidaclock4s : std_logic := '0';

begin

-- DIVISOR DE CLOCK 1HZ
process(clk, reset)
variable count : integer range 0 to 2 := 0; -- ATENÇÃO: MUDAR range PARA 50_000_00 para bitstream
begin
    if reset='1' then
        count := 0;
        saidaclock1s <= '0';
    elsif rising_edge(clk) then
            count := count + 1;        
        if count = 2 then                   -- ATENÇÃO: MUDAR COUNT PARA 50_000_00 para bitstream
            saidaclock1s <= not saidaclock1s;
            count := 0;
        end if;
    end if;            
end process;

-- CONTADOR DE 4 SEGUNDOS
process(saidaclock1s, reset)
variable count4s : integer range 0 to 5 := 0;
begin
    if reset='1' then
        count4s := 0;
        saidaclock4s <= '0';
    elsif rising_edge(saidaclock1s) then
            saidaclock4s <= '0';  
        if count4s = 5 then
            saidaclock4s <= '1';
            count4s := 0;
        end if;
            count4s := count4s + 1;
    end if;            
end process;

clkdiv4s <= saidaclock4s;
clkdiv1s <= saidaclock1s;

end Behavioral;
