library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is
  port(
    row : in unsigned(9 downto 0);  
    col : in unsigned(9 downto 0); 
	p1Pos : in unsigned(9 downto 0);
	p2Pos : in unsigned(9 downto 0);
	xPos : in unsigned(9 downto 0);
	yPos : in unsigned(9 downto 0);
    rgb : out std_logic_vector(5 downto 0)
  );
end pattern_gen;


architecture sim of pattern_gen is

-- For testing screen. Remove inputs and us this.
--signal p1Pos : unsigned(9 downto 0);
--signal p2Pos : unsigned(9 downto 0);
--signal xPos : unsigned(9 downto 0);
--signal yPos : unsigned(9 downto 0);

begin
	-- For Testing screen.
--	p1Pos <= 10d"180";
--	p2Pos <= 10d"180";
--	xPos <= 10d"320";
--	yPos <= 10d"240";
	
	-- Make sure to minus 150 to any column calculation and 9 from any row calculation
	rgb <= "000000" when (col < 150 or col > 795 or row < 10 or row > 489) else --Out of bounds area = black
		"111111" when ((col-150 < 15 and row-9 >= p1Pos  and row-9 < p1Pos+135) -- Left Paddle (all following = white)
		or (col-150 > 629 and row-9 >= p2Pos and row-9 < p2Pos + 135) -- Right Paddle
		or (col-150 > xPos - 8 and col-150 < xPos + 8  and row-9 > yPos - 8 and row-9 < yPos + 8) -- Ball
		or (col-150 > 318 and col-150 < 322 and row mod 6 < 3) -- Dotted Center Line
		or (row < 11 or row > 488)) else "000000"; -- Top and bottom edges, else black

-- Good luck!
	

end;



