library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity score is
    port(
      clk : in std_logic;
      
    --   reset :in std_logic;
      
      input : in std_logic_vector(1 downto 0);
      
      seven1 : out unsigned(3 downto 0);
      seven2 : out unsigend(3 downto 0);
      
      iswin : out std_logic
      );
end score;

-- Screen is a 640 x 480

architecture synth of score is

signal s1 : unsigned(3 downto 0) := "0000";
signal s2 : unsigned(3 downto 0) := "0000";

begin
  process (clk) begin
    if (rising_edge(clk)) then
        if input = "10" then
            s1 <= s1 + '1';
        elsif input = "01" then
            s2 <= s2 + '1';
        else 
            s1 <= s1;
            s2 <= s2;
        end if;
        
        if s1 = "1010" or s2 = "1010" then -- reset when either player reach 10 points
            iswin <= '1';
            s1 <= "0000";
            s2 <= "0000";
        else
            iswin <= '0';
        end if;
        
    end if;
  end process;
  seven1 <= s1(3) & s1(2) & s1(1) & s1(0);
  seven2 <= s2(3) & s2(2) & s2(1) & s2(0);
end;
