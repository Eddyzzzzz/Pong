library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sevenseg is
  port(
	  S : in unsigned(3 downto 0);
	  segments : out std_logic_vector(6 downto 0)
  );
end sevenseg;

architecture synth of sevenseg is
begin
  segments <= "0000001" when S = 0 else
              "1001111" when S = 1 else
              "0010010" when S = 2 else
              "0000110" when S = 3 else
              "1001100" when S = 4 else
              "0100100" when S = 5 else
              "0100000" when S = 6 else
              "0001111" when S = 7 else
              "0000000" when S = 8 else
              "0000100" when S = 9 else
              "0001000" when S = 10 else
              "1100000" when S = 11 else
              "0110001" when S = 12 else
              "1000010" when S = 13 else
              "0110000" when S = 14 else
              "0111000" when S = 15 else
              "1111111"; 
end;
