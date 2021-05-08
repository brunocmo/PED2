library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bloco_operacional is
    Port ( clk: in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           lread,lcomp1,ldesl,lsoma,lcomp2 : in STD_LOGIC;
           cread,ccomp1,cdesl,csoma,ccomp2 : in STD_LOGIC;
           H : out STD_LOGIC_VECTOR (7 downto 0));
end bloco_operacional;

architecture Behavioral of bloco_operacional is

 -- Declaracao de registradores
signal regA, regB, regH, regX, regY : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal regT4, regT5, regT6 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

begin

    -- processo para leitura em A e B
    process(clk, cread)
    begin
        if cread='1' then
            regA <= (others=>'0');
            regB <= (others=>'0');
        elsif rising_edge(clk) then
            if lread='1' then
                regA <= A;
                regB <= B;
            end if;                
        end if;
    end process;
    
    -- processo para comparacao de A e B
    process(clk, ccomp1)
    begin
        if ccomp1='1' then
            regX <= (others=>'0');
            regY <= (others=>'0');
        elsif rising_edge(clk) then
            if lcomp1='1' then
                if regA > regB then
                    regX <= regA;
                    regY <= regB;
                else
                    regX <= regB;
                    regY <= regA;
                end if;
            end if;                
        end if;
    end process;
    
    -- processo para o deslocamento de regX e regY
    process(clk, cdesl)
    begin
        if cdesl='1' then
            regT5 <= (others=>'0');
            regT4 <= (others=>'0');
        elsif rising_edge(clk) then
            if ldesl='1' then
                regT5 <= std_logic_vector(unsigned(regX) - unsigned("000" & regX(7 downto 3)));
                regT4 <= '0' & regY(7 downto 1);
            end if;                
        end if;
    end process;
    
    -- processo para a soma de regT5  e regT6
    process(clk, csoma)
    begin
        if csoma='1' then
            regT6 <= (others=>'0');
        elsif rising_edge(clk) then
            if lsoma='1' then
                regT6 <= std_logic_vector(unsigned(regT4) + (unsigned(regT5)));
            end if;                
        end if;
    end process;
    
    -- processo para comparar regT6 com X
    process(clk, ccomp2)
    begin
        if ccomp2='1' then
            regH <= (others=>'0');
        elsif rising_edge(clk) then
            if lcomp2='1' then
                if regT6 > regX then
                    regH <= regT6;
                else
                    regH <= regX;
                end if;
            end if;                
        end if;
    end process;
    
    -- Saida do resultado do registrador H para o led H
    H <= regH;
    
end Behavioral;
