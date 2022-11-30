library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
  port(
	clock : in std_logic;
	row : out unsigned(9 downto 0);
	col : out unsigned(9 downto 0);
	HSYNC : out std_logic;
	VSYNC: out std_logic
  );
end vga;

architecture sim of vga is

signal curRow : unsigned(9 downto 0);
signal curCol : unsigned(9 downto 0);

begin

	process(clock)
	begin
		if rising_edge(clock) then
			if curCol = 10d"799" then
				curCol <= 10d"0";
				HSYNC <= '0';
				if curRow = 10d"524" then
					curRow <= 10d"0";
					VSYNC <= '0';
				elsif curCol < 10d"1" then
					curRow <= curRow + "1";
					VSYNC <= '0';
				else
					curRow <= curRow + "1";
					VSYNC <= '1';
				end if;
			elsif curCol < 10d"96" then
				curCol <= curCol + "1";
				HSYNC <= '0';
			else
				curCol <= curCol + "1";
				HSYNC <= '1';
			end if;
		end if;
	end process;
	
    row <= curRow;
    col <= curCol;
-- Good luck!

end;



