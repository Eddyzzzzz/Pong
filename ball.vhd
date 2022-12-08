library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity ball is
port(

    p1pos : in unsigned (9 downto 0);
    p2pos : in unsigned (9 downto 0);
    xpos : out unsigned(9 downto 0);
    ypos : out unsigned(9 downto 0);
    state : in std_logic;
    scored: out std_logic_vector(1 downto 0);
    
    clk: in std_logic
);
end;

architecture synth of ball is
signal ballvel  : std_logic_vector(1 downto 0); --x, y
signal interset : std_logic;
signal delay    : unsigned(16 downto 0);
signal waitVal  : unsigned(16 downto 0);
begin
    
	process (clk) 
    begin
		if rising_edge(clk) then
			-- Do the reset
			interset <= '1' when (state = '1' or xpos < 10d"0" or xpos > 10d"640")
						 else '0';
			-- Slow down for humans
			if delay = 17b"0" then
				-- Choose which direction the ball goes
				ballvel(0) <= '0' when state else
				'1' when xpos < 10d"15" and ((ypos < p1pos + d"135") and (ypos > p1pos)) else
				'0' when xpos > 10d"625" and ((ypos < p2pos + d"135") and (ypos > p2pos)) else
				ballvel(0);
				ballvel(1) <= '0' when state else
				'1' when ypos = "0000000011" else
				'0' when ypos = 10d"477" else
				ballvel(1);
				
				-- Sets the x position of the ball
				xpos <= 10d"320" when interset or state else
					xpos+10d"1" when ballvel(0) = '1' else 
					xpos-10d"1";
				
				-- Sets the y position of the bal
				ypos <= 10d"240" when interset or state else
					ypos+10d"1" when ballvel(1) = '1' else
					ypos-10d"1";
					
				-- Constrols the speed up
				if (xpos < 10d"15" and ((ypos < p1pos + d"135") and (ypos > p1pos))) or (xpos > 10d"625" and ((ypos < p2pos + d"135") and (ypos > p2pos))) then
					waitVal <= waitVal - 17d"1";
				elsif xpos < 10d"0" or xpos > 10d"640" then
					waitVal <= "11111111111111111";
				end if;
				
				-- Check when someone scores
				scored <= "01" when xpos > 10d"480" else
				"10" when xpos < 10d"0" else
				"00";
			end if;
			-- Increases the speed
			delay <= delay + 17b"1" when delay < waitVal else 17b"0";
		end if;
	end process;

--b <= not a;

end;

