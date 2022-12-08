library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity score is
    port(
	clk : in std_logic;
		  
	--   reset :in std_logic;
		  
	scored : in std_logic_vector(1 downto 0);

	p1Score : out unsigned(3 downto 0);
	p2Score : out unsigned(3 downto 0);

	isWin : out std_logic
      );
end score;

-- Screen is a 640 x 480

architecture synth of score is

signal s1  : unsigned(3 downto 0);
signal s2  : unsigned(3 downto 0);
signal reset : std_logic := '0';

begin
  process (clk) begin
    if (rising_edge(clk)) then

		if scored = "10" then		
			if (reset = '1') then
				s1 <= s1;
			else      	
                s1 <= s1 + '1';
			reset <= '1';
			end if;
		    
        elsif scored = "01" then
			if (reset = '1') then
				s2 <= s2;
			else      	
                s2 <= s2 + '1';
			reset <= '1';
			end if;
		  
        else 
			reset <= '0';  
        end if;
        
        if s1 = "1010" or s2 = "1010" then -- reset when either player reach 10 points
            isWin <= '1';
            s1 <= "0000";
            s2 <= "0000";
        else
            isWin <= '0';
        end if;
        
    end if;
  end process;
  p1Score <= s1;
  p2Score <= s2;
end;
