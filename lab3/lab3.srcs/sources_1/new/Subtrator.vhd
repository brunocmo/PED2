library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Subtrator is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           saida8 : out STD_LOGIC_VECTOR (7 downto 0));
end Subtrator;

architecture Behavioral of Subtrator is

component kcpsm6 is
  generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                  interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
           scratch_pad_memory_size : integer := 64);
  port (                   address : out std_logic_vector(11 downto 0);
                       instruction : in std_logic_vector(17 downto 0);
                       bram_enable : out std_logic;
                           in_port : in std_logic_vector(7 downto 0);
                          out_port : out std_logic_vector(7 downto 0);
                           port_id : out std_logic_vector(7 downto 0);
                      write_strobe : out std_logic;
                    k_write_strobe : out std_logic;
                       read_strobe : out std_logic;
                         interrupt : in std_logic;
                     interrupt_ack : out std_logic;
                             sleep : in std_logic;
                             reset : in std_logic;
                               clk : in std_logic);
  end component;

component PicoBlaze1 is
  generic(             C_FAMILY : string := "S6"; 
              C_RAM_SIZE_KWORDS : integer := 1;
           C_JTAG_LOADER_ENABLE : integer := 0);
  Port (      address : in std_logic_vector(11 downto 0);
          instruction : out std_logic_vector(17 downto 0);
               enable : in std_logic;
                  rdl : out std_logic;                    
                  clk : in std_logic);
  end component;

    
    --
    -- Signals for connection of KCPSM6 and Program Memory.
    --
    signal         address : std_logic_vector(11 downto 0);
    signal     instruction : std_logic_vector(17 downto 0);
    signal     bram_enable : std_logic;
    signal         in_port : std_logic_vector(7 downto 0);
    signal        out_port : std_logic_vector(7 downto 0);
    signal         port_id : std_logic_vector(7 downto 0);
    signal    write_strobe : std_logic;
    signal  k_write_strobe : std_logic;
    signal     read_strobe : std_logic;
    signal       interrupt : std_logic;
    signal   interrupt_ack : std_logic;
    signal    kcpsm6_sleep : std_logic;
    signal    kcpsm6_reset : std_logic;
    
    --
    -- Some additional signals are required if your system also needs to reset KCPSM6. 
    --
    
    signal       cpu_reset : std_logic;
    signal             rdl : std_logic;
    
    --
    -- When interrupt is to be used then the recommended circuit included below requires 
    -- the following signal to represent the request made from your system.
    --
    
    signal     int_request : std_logic;
  
begin

  processor1: kcpsm6
    generic map (                 hwbuild => X"00", 
                         interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address,
               instruction => instruction,
               bram_enable => bram_enable,
                   port_id => port_id,
              write_strobe => write_strobe,
            k_write_strobe => k_write_strobe,
                  out_port => out_port,
               read_strobe => read_strobe,
                   in_port => in_port,
                 interrupt => interrupt,
             interrupt_ack => interrupt_ack,
                     sleep => kcpsm6_sleep,
                     reset => reset,
                       clk => clk);    

    interrupt <= '0';
    kcpsm6_sleep <= '0';


    rom_subtrator: PicoBlaze1
      generic map (   C_FAMILY => "7S",
                 C_RAM_SIZE_KWORDS => 1,
                 C_JTAG_LOADER_ENABLE => 0)
      Port map (      
              address => address,
          instruction => instruction,
               enable => bram_enable,
                  rdl => kcpsm6_reset,                   
                  clk => clk );

    -- process para INPORT
    process(clk,reset)
    begin
        if reset='1' then
            in_port <= (others=>'0');
        elsif rising_edge(clk) then
            if read_strobe='1' then
                if port_id = "00000001" then
                    in_port <= sw(7 downto 0);
                elsif port_id = "00000010" then
                    in_port <= sw(15 downto 8);
                end if;
            end if;
        end if;
    end process;
    
    -- process para OUTPORT
    process(clk,reset)
    begin
        if reset='1' then
            saida8 <= (others=>'0');
        elsif rising_edge(clk) then
            if write_strobe='1' then
                if port_id = "00000011" then
                    saida8 <= out_port;
                end if;
            end if;
        end if;
    end process;



end Behavioral;
