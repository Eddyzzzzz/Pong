library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity playground is
port(

    p1pos : out unsigned (9 downto 0);
    p2pos : out unsigned (9 downto 0);
    state : in std_logic;
    reset: in std_logic;
    score: out std_logic_vector(1 downto 0);
    
    clk: in std_logic
);
end;

architecture synth of playground is
signal ballvel : std_logic_vector(1 downto 0);
signal ballxpos : unsigned(9 downto 0);
signal ballypos : unsigned(9 downto 0);
signal interset : std_logic;

begin
    interset <= '1' when reset else
    '1' when not score = "00" else '0';
process (clk) 
    begin
    if rising_edge(clk) then
        ballvel(0) <= '0' when reset else
        '1' when ballxpos = d"15" and ((ballypos > p1pos - d"135") and (ballypos < p1pos)) else
        '0' when ballxpos = d"625" and ((ballypos > p2pos - d"135") and (ballypos < p2pos)) else
        ballvel(0);
        ballvel(1) <= '0' when reset else
        '1' when ballypos = "0000000000" else
        '0' when ballypos = 10d"480" else
        ballvel(1);
        
        ballxpos <= 10d"320" when interset or state else
            ballxpos+10d"1" when ballvel(0) else 
            ballxpos-10d"1";
        ballypos <= 10d"240" when interset or state else
            ballypos+10d"1" when ballvel(1) else
            ballypos-10d"1";
        
        score <= "01" when ballxpos = 10d"480" else
        "10" when ballxpos = 10d"0" else
        "00";
        
    end if;
end process;

end;
