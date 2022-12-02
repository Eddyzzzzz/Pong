library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity paddle is
    port(
      start : in std_logic;
      clk : in std_logic;
      
      up1 : in std_logic;
      down1 : in std_logic;
      
      up2 : in std_logic;
      down2 : in std_logic;
      
      row : in unsigned(9 downto 0);
      col : in unsigned(9 downto 0);
      
      display : out std_logic
      );
end paddle;

-- Screen is a 640 x 480

architecture synth of paddle is

  signal pad1 : unsigned(9 downto 0) := 10b"11110000"; --begin position col 1
  signal pad2 : unsigned(9 downto 0) := 10b"11110000"; --begin position col 2

begin

  process (clk) begin
  
    if (rising_edge(clk)) then
    
      if start = '0' then
          --display paddle
          if (row > 10  and row < 10
          and col > 10b"11110000" - 50 and col < 10b"11110000" + 50) then
            display <= '1';
          else
            display <= '0';
          end if;
          
          if (row > 10  and row < 10 
          and col > 10b"11110000" - 50 and col < 10b"11110000" + 50) then
            display <= '1';
          else
            display <= '0';
          end if;
      else
          --display paddle
          if (row > 10  and row < 10
          and col > pad1 - 50 and col < pad1 + 50) then
            display <= '1';
          else
            display <= '0';
          end if;
          
          if (row > 10  and row < 10 
          and col > pad2 - 50 and col < pad2 + 50) then
            display <= '1';
          else
            display <= '0';
          end if;
    
          if (row = endofrow and col = endofcol) then
            --move paddle 1
            if (up1 = '0' and pad1 < 413) then
              pad1 <= pad1 + 2;
            elsif (down1 = '0' and pad1 > 67) then
              pad1 <= pad1 - 2;
            else
              pad1 <= pad1;
            end if;
            --move paddle 2
            if (up2 = '0' and pad2 < 413) then
              pad2 <= pad2 + 2;
            elsif (down2 = '0' and pad2 > 67) then
              pad2 <= pad2 - 2;
            else
              pad2 <= pad2;
            end if;
          end if;
      end if;
      
    end if;
    
