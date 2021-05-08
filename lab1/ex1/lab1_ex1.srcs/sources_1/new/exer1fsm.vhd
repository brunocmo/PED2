library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity exer1fsm is
    Port ( a : in STD_LOGIC;
           clk1 : in STD_LOGIC;
           reset : in STD_LOGIC;
           selclk : out STD_LOGIC;
           duty : out STD_LOGIC_VECTOR(3 downto 0));
end exer1fsm;

architecture Behavioral of exer1fsm is

type maquina_estado is (e0, e1, e2, e3, e4);

signal estado_atual : maquina_estado := e0;
signal estado_proximo : maquina_estado := e0;

signal saidaduty : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal saidaseletor : STD_LOGIC:= '0';

begin

process (clk1, reset)
begin
    if reset='1' then
        estado_atual <= e0;
    elsif rising_edge(clk1) then
        estado_atual <= estado_proximo;
    end if;
end process;

process (a, estado_atual)
begin
    case estado_atual is
         when e0 =>
            if a='1' then
                estado_proximo <= e1;
                saidaduty <= "0010";
                saidaseletor <= '0';
            else
                estado_proximo <= e0;
            saidaduty <= "0000";
            saidaseletor <= '0';
            end if;
         when e1 =>

            if a='1' then
                estado_proximo <= e2;
                saidaduty <= "0101";
                saidaseletor <= '0';
            else
                estado_proximo <= e1;
                saidaduty <= "0010";
                saidaseletor <= '0';
            end if;
         when e2 =>

            if a='1' then
                estado_proximo <= e3;
                saidaduty <= "1001";
                saidaseletor <= '0';
            else
                estado_proximo <= e2;
                saidaduty <= "0101";
                saidaseletor <= '0';
            end if;
         when e3 =>

            if a='1' then
                estado_proximo <= e4;
                saidaduty <= "1010";
                saidaseletor <= '1';
            else
                estado_proximo <= e3;
                saidaduty <= "1001";
                saidaseletor <= '0';
            end if;
         when e4 =>
            if a='1' then
                estado_proximo <= e0;
                saidaduty <= "0000";
                saidaseletor <= '0';
            else
                estado_proximo <= e4;
                saidaduty <= "1010";
                saidaseletor <= '1';
            end if;
         when others => estado_proximo <= e0;
    end case;
end process;

duty <= saidaduty;
selclk <= saidaseletor;


end Behavioral;
