-----------------------------------------------------------------------
-- Tufts University
-- Author       : Eddy Zhang
-- Create Date  : 11/12/2022
-- Project Name : Pong (2P)
-- Team Members : Alex, Jane, Matthew, Eddy
-- Dependency   : VHDL 2008
-- Description  : This is the code for running NES Nintendo Game
--                Controller on ES4 final project Pong
-- Note         : For all the outputs, press button -> '0', 
--                not press button -> '1'   
-----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all; use IEEE.numeric_std.all;

entity nes is 
  port(
	  
    latch1 : out std_logic;
    latch2 : out std_logic;
    
    clock1 : out std_logic;
    clock2 : out std_logic;
    
    data1 : in std_logic;
    data2 : in std_logic;
    
    --bit 1 : up; bit 2 : down
    nes1 : out std_logic_vector(1 downto 0); 
    nes2 : out std_logic_vector(1 downto 0);
    
    clk : in std_logic;
	  
    start : out std_logic
	  
  );
end nes;
  
architecture synth of nes is
	
--  -- if you want to use internal HSOSC clock instead of clock from other components
--  component HSOSC is generic (
--    CLKHF_DIV : String := "0b00"); port(
--    CLKHFPU : in std_logic := 'X'; CLKHFEN : in std_logic := 'X'; CLKHF : out std_logic := 'X');
--  end component;
  
--  signal clk : std_logic;

  -- nes controller must run on approximately this frequency:
  -- 48 MHz * 25ms = 1200000 = 2^20
  -- otherwise it's too fast for it to receive and send data
  signal counter : unsigned (19 downto 0) := 20d"0"; signal NESclk : std_logic;
  signal NEScount : unsigned (7 downto 0);

  signal output1 : std_logic_vector(7 downto 0):= 8d"0";
  signal output2 : std_logic_vector(7 downto 0):= 8d"0";

  signal start1 : std_logic;
  signal start2 : std_logic;

begin
  
--  clo : HSOSC
--  port map(
--  CLKHF => clk,
--  CLKHFEN => '1', CLKHFPU => '1'
--  );
    
  -- make nesclock
  process(clk) begin
    if rising_edge(clk) then
      counter <= counter + '1'; 
    end if;
  end process;
      
  NESclk <= counter(8);

  -- make nes counter
  NEScount <= counter(16 downto 9);
    
  -- make latch
  latch1 <= '1' when NEScount = "11111111" else '0';
  latch2 <= '1' when NEScount = "11111111" else '0';
  
  -- make clock to receive data
  clock1 <= NESclk when NEScount < "00001000" else '0';
  clock2 <= NESclk when NEScount < "00001000" else '0';
    
  -- make register that stores data
  process (clock1) begin
    if rising_edge(clock1) then
      output1(0) <= output1(1); output1(1) <= output1(2); output1(2) <= output1(3); output1(3) <= output1(4); output1(4) <= output1(5); output1(5) <= output1(6); output1(6) <= output1(7); output1(7) <= data1;
    end if; 
  end process;
      
  process (clock2) begin
    if rising_edge(clock2) then
      output2(0) <= output2(1); output2(1) <= output2(2); output2(2) <= output2(3); output2(3) <= output2(4); output2(4) <= output2(5); output2(5) <= output2(6); output2(6) <= output2(7); output2(7) <= data2;
    end if; 
  end process;
      
  -- send the bits (aka buttons) we want to the output
  process (latch1) begin
    if rising_edge(latch1) then
      nes1 <= output1(4) & output1(5); 
      start1 <= output1(3);
    end if;
  end process; 
 
  process (latch2) begin
    if rising_edge(latch2) then
      nes2 <= output2(4) & output2(5); 
      start2 <= output2(3);
    end if;
  end process; 
	   
  -- either player presses start the game will start
  start <= not (not start1 or not start2);
      
end;
