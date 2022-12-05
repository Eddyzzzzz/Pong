library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GameState is
port(
    clk     : in std_logic; -- shared clk
    isStart : in std_logic; -- Signal asserting if the start has been pressed
    isWin   : in std_logic; -- Signal asserting if someone has won a game
    
    state   : out std_logic -- 0 if playing, 1 if in game over
);
end;
    
architecture synth of GameState is
    signal currentState : std_logic;
	signal initial : std_logic;
begin
    -- Screen is a 640 x 480
    process(clk)
    begin
        if rising_edge(clk) then
			if initial = '0' then
				currentState <= '1';
				initial <= '1';
            elsif currentState = '1' then
                currentState <= '0' when isStart = '1' else currentState;
            else 
                currentState <= '1' when isWin   = '1' else currentState;
            end if;
        end if;
    end process;
    
    state <= currentState;
    
end;

