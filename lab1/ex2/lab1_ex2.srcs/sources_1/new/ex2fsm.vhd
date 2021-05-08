library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity ex2fsm is
    Port ( clk1s : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR(7 downto 0);
           load_stop : in STD_LOGIC;
           clk4s : in STD_LOGIC;
           start : in STD_LOGIC;
           dir : in STD_LOGIC;
           reset : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (7 downto 0));
end ex2fsm;

architecture Behavioral of ex2fsm is

type maquinaestado is (carrega, pisca, rotacao, desloca);


signal estado_atual : maquinaestado := carrega;
signal estado_proximo : maquinaestado := carrega;
signal currentled : std_logic_vector(7 downto 0) := "00000000";
signal piscatmp : std_logic := '0';
signal piscaled : std_logic := '0';

begin

-- MUDANÇA DE ESTADO ATUAL PARA PROXIMO POR CLOCK 1HZ
process(clk1s, reset)
begin
    if reset='1' then
        estado_atual <= carrega;
    elsif rising_edge(clk1s) then
        estado_atual <= estado_proximo;     
    end if;
end process;

-- MUDANÇA DE ESTADO
process(estado_atual, start, load_stop, clk4s, dir)
begin
    case estado_atual is
        when carrega =>
            if load_stop = '1' then
                currentled <= A;
            elsif start = '0' then
                estado_proximo <= carrega;
            else 
                estado_proximo <= pisca;
                piscatmp <= '1';
            end if;
        when pisca =>
            if clk4s = '0' then
                estado_proximo <= pisca;
            else 
                estado_proximo <= rotacao;
                piscatmp <= '0';
                if dir = '1' then
                    currentled <= currentled(6 downto 0) & currentled(7);
                else
                    currentled <= currentled(0) & currentled(7 downto 1);
                end if;
            end if;
        when rotacao =>
            if clk4s = '0' then
                estado_proximo <= rotacao;
            else 
                estado_proximo <= desloca;
                if dir = '1' then
                    currentled <= currentled(6 downto 0) & '0';
                else
                    currentled <= '0' & currentled(7 downto 1);
                end if;
            end if;
 
        when desloca =>
            if load_stop = '1' then
                estado_proximo <= carrega;
            elsif clk4s = '0' then
                estado_proximo <= desloca;
            else 
                estado_proximo <= pisca;
                piscatmp <= '1';
            end if;
        when others => 
                estado_proximo <= carrega;

    end case;
end process;

-- BLINK DO LED OU LED ESTAVEL
process (clk1s, reset)
begin
    if reset = '1' then
        led <= "00000000";
    elsif rising_edge(clk1s) then
        if piscatmp = '1' then
            if piscaled = '0' then
                led <= "00000000";
            else
                led <= currentled;
            end if;
            piscaled <= not piscaled;
        else
            led <= currentled;
        end if;
    end if;
        
end process;

end Behavioral;
