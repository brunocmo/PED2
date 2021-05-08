library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity bloco_controle is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk   : in STD_LOGIC;
           lread,lcomp1,ldesl,lsoma,lcomp2 : out STD_LOGIC;
           cread,ccomp1,cdesl,csoma,ccomp2 : out STD_LOGIC;
           ready : out STD_LOGIC);
end bloco_controle;

architecture Behavioral of bloco_controle is

 -- Definição do tipo de estados e o estados autal e proximo
type tipo_estado is (idle, read, comp1, desl, soma, comp2, result);
signal estado_atual : tipo_estado := idle;
signal estado_proximo : tipo_estado := idle;

 --============================================================================--
 --   O estado idle eh o inicial
 --   O estado read serve para a leitura dos inputs A e B
 --   O estado comp1 serve para fazer a comparacao se A > B, e o resultado eh
 -- jogado para X(maior) e Y(menor)
 --   O estado soma serve para somar os valores do registrador T5 e T4
 --   O estado comp2 serve para comparacao se registrador T6 > X, e o resultado
 -- eh jogado para o registrador H
 --   O estado result aciona o led ready juntamnete com os leds de H de 8 bits
 --============================================================================--

 -- Sinais que representão os fios de leitura, reset(clear) e ready. 
signal fioloadread,fioloadcomp1,fioloaddesl,fioloadsoma,fioloadcomp2: STD_LOGIC := '0';
signal fioclearread,fioclearcomp1,fiocleardesl,fioclearsoma,fioclearcomp2: STD_LOGIC := '0';
signal fioready : STD_LOGIC := '0';


begin

    -- Registro de estado
    process(clk, reset)
    begin
        if reset='1' then
            estado_atual <= idle;
        elsif rising_edge(clk) then
            estado_atual <= estado_proximo;
        end if;
    end process;
    
    -- Transicao de estados
    process(estado_atual,start)
    begin
        case estado_atual is
            when idle =>
                if start='1' then
                    estado_proximo <= read;
                else
                    estado_proximo <= idle;
                end if;
            when read =>
                    estado_proximo <= comp1;
            when comp1 =>
                    estado_proximo <= desl;
            when desl =>
                    estado_proximo <= soma;
            when soma =>
                    estado_proximo <= comp2;
            when comp2 =>
                    estado_proximo <= result;
            when result =>
                    estado_proximo <= idle;
            when others =>
                    estado_proximo <= idle;
        end case;
    end process;

    -- combinacional de saidas
    process(estado_atual)
    begin
        case estado_atual is
            when idle =>
                fioclearread <= '1'; fioclearcomp1 <= '1'; fiocleardesl <= '1'; fioclearsoma <= '1'; fioclearcomp2 <= '0';
                fioloadread <= '0'; fioloadcomp1 <= '0'; fioloaddesl <= '0'; fioloadsoma <= '0'; fioloadcomp2 <= '0'; 
                fioready <= '0';

            when read =>
                fioclearread <= '0'; fioclearcomp1 <= '0';  fiocleardesl <= '0'; fioclearsoma <= '0';  fioclearcomp2 <= '1'; 
                fioloadread <= '1'; fioloadcomp1 <= '0'; fioloaddesl <= '0'; fioloadsoma <= '0'; fioloadcomp2 <= '0'; 
                fioready <= '0';

            when comp1 =>
                fioclearread <= '0'; fioclearcomp1 <= '0';  fiocleardesl <= '0'; fioclearsoma <= '0'; fioclearcomp2 <= '0';  
                fioloadread <= '0'; fioloadcomp1 <= '1'; fioloaddesl <= '0'; fioloadsoma <= '0'; fioloadcomp2 <= '0'; 
                fioready <= '0';

            when desl =>
                fioclearread <= '0'; fioclearcomp1 <= '0'; fiocleardesl <= '0';  fioclearsoma <= '0'; fioclearcomp2 <= '0'; 
                fioloadread <= '0'; fioloadcomp1 <= '0'; fioloaddesl <= '1'; fioloadsoma <= '0'; fioloadcomp2 <= '0'; 
                fioready <= '0';

            when soma =>
                fioclearread <= '0'; fioclearcomp1 <= '0'; fiocleardesl <= '0'; fioclearsoma <= '0'; fioclearcomp2 <= '0'; 
                fioloadread <= '0'; fioloadcomp1 <= '0';  fioloaddesl <= '0'; fioloadsoma <= '1'; fioloadcomp2 <= '0';
                fioready <= '0';

            when comp2 =>
                fioclearread <= '0'; fioclearcomp1 <= '0'; fiocleardesl <= '0'; fioclearsoma <= '0'; fioclearcomp2 <= '0'; 
                fioloadread <= '0'; fioloadcomp1 <= '0'; fioloaddesl <= '0'; fioloadsoma <= '0'; fioloadcomp2 <= '1'; 
                fioready <= '0';

            when result =>
                fioclearread <= '0'; fioclearcomp1 <= '0'; fiocleardesl <= '0'; fioclearsoma <= '0'; fioclearcomp2 <= '0'; 
                fioloadread <= '0'; fioloadcomp1 <= '0'; fioloaddesl <= '0'; fioloadsoma <= '0'; fioloadcomp2 <= '0';  
                fioready <= '1';

            when others =>
                fioclearread <= '0'; fioclearcomp1 <= '0'; fiocleardesl <= '0'; fioclearsoma <= '0'; fioclearcomp2 <= '0'; 
                fioloadread <= '0'; fioloadcomp1 <= '0'; fioloaddesl <= '0'; fioloadsoma <= '0'; fioloadcomp2 <= '0'; 
                fioready <= '0';

        end case;
    end process;

    -- Saidas do componente
lread <= fioloadread; lcomp1 <= fioloadcomp1; ldesl <= fioloaddesl; lsoma <= fioloadsoma; lcomp2 <= fioloadcomp2;
cread <= fioclearread; ccomp1 <= fioclearcomp1; cdesl <= fiocleardesl; csoma <= fioclearsoma; ccomp2 <= fioclearcomp2;
ready <= fioready;

end Behavioral;
