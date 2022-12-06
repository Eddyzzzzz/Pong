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
signal p1 : unsigned (3 downto 0);

begin
	-- For Testing screen.
--	p1Pos <= 10d"180";
--	p2Pos <= 10d"180";
--	xPos <= 10d"320";
--	yPos <= 10d"240";
	p1 <= 4b"0";
	
	-- Make sure to minus 150 to any column calculation and 9 from any row calculation
	rgb <= "000000" when (col < 150 or col > 795 or row < 10 or row > 489) else --Out of bounds area = black
		"111111" when ((col-150 < 15 and row-9 >= p1Pos  and row-9 < p1Pos+135) -- Left Paddle (all following = white)
		or (col-150 > 629 and row-9 >= p2Pos and row-9 < p2Pos + 135) -- Right Paddle
		or (col-150 > xPos - 8 and col-150 < xPos + 8  and row-9 > yPos - 8 and row-9 < yPos + 8) -- Ball
		or (col-150 > 318 and col-150 < 322 and row mod 6 < 3) -- Dotted Center Line
		or (row < 11 or row > 488) -- Top and bottom edges, else black
		
		-- NUMBERS: Start at Row > 15, Row < 21, col < 306 for right pixel (p1), col > 337 for left pixel (p2), 5 per pixel, 
		or (row-9 > 15 and row-9 < 21 and ((p1 = 0 or p1= 10)and col-150 < 301 and col-150 > 275))
		or (row-9 > 20 and row-9 < 26 and ((p1 = 0 or p1= 10)and col-150 < 306 and col-150 > 270))
		or (row-9 > 25 and row-9 < 31 and ((p1 = 0 or p1= 10)and ((col-150 < 306 and col-150 > 295) or (col-150 < 281 and col-150 > 270))))
		or (row-9 > 30 and row-9 < 36 and ((p1 = 0 or p1= 10)and ((col-150 < 306 and col-150 > 295) or (col-150 < 281 and col-150 > 270))))
		or (row-9 > 35 and row-9 < 41 and ((p1 = 0 or p1= 10)and ((col-150 < 306 and col-150 > 295) or (col-150 < 281 and col-150 > 270))))
		or (row-9 > 40 and row-9 < 46 and ((p1 = 0 or p1= 10)and ((col-150 < 306 and col-150 > 295) or (col-150 < 281 and col-150 > 270))))
		or (row-9 > 45 and row-9 < 51 and ((p1 = 0 or p1= 10)and ((col-150 < 306 and col-150 > 295) or (col-150 < 281 and col-150 > 270))))
		or (row-9 > 50 and row-9 < 56 and ((p1 = 0 or p1= 10)and ((col-150 < 306 and col-150 > 295) or (col-150 < 281 and col-150 > 270))))
		or (row-9 > 55 and row-9 < 61 and ((p1 = 0 or p1= 10)and ((col-150 < 306 and col-150 > 295) or (col-150 < 281 and col-150 > 270))))
		or (row-9 > 60 and row-9 < 66 and ((p1 = 0 or p1= 10)and col-150 < 306 and col-150 > 270))
		or (row-9 > 65 and row-9 < 71 and ((p1 = 0 or p1= 10)and col-150 < 301 and col-150 > 275))) else "000000";

-- Good luck!
	

end;



