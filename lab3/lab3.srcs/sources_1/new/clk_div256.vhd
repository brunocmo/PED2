library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_div256 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           seletorMux : out STD_LOGIC_VECTOR(1 DownTo 0));
end clk_div256;

architecture Behavioral of clk_div256 is

signal clock256 : STD_LOGIC := '0';
signal selMux: STD_LOGIC_VECTOR(1 DownTo 0) := "00";


begin

--processo para dividir a frequência 256 Hz (100MHz / 256 Hz = 390625 iterações)
process(clk,reset)
   variable divisor: integer := 0;
begin
    if reset = '1' then
        clock256 <= '0';
        divisor := 0;
    elsif rising_edge(clk) then
            divisor := divisor+1;              -- 195312
            if divisor = 195312 then
                clock256 <= not clock256;
                divisor := 0;
            end if;
        end if;
 end process;
 
 process(clock256,reset)
 begin
   if reset = '1' then
        selMux <= "00";
   elsif rising_edge(clock256) then
        selMux <= std_logic_vector(unsigned(selMux) + 1);
    end if;
 
 end process;

seletorMux <= selMux;

end Behavioral;
