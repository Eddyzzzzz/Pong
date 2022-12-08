library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SevenSegDisplay is
port(
    clk     : in std_logic;
    p1Score : in unsigned(3 downto 0);
    p2Score : in unsigned(3 downto 0);
    
    segDisp : out std_logic_vector(6 downto 0);
    seg1    : out std_logic;
    seg2    : out std_logic
);
end;
    
architecture synth of SevenSegDisplay is
    signal counter   : unsigned(19 downto 0);
    signal dispScore : unsigned(3 downto 0);
    signal output   : std_logic_vector(6 downto 0);
    
    component sevenSeg is 
        port(
	        S        : in unsigned(3 downto 0);
	        segments : out std_logic_vector(6 downto 0)
        );
    end component;
    
begin
    -- Screen is a 640 x 480
    
    process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 20b"1";
        end if;
    end process;
    
    disp : sevenSeg
        port map (
            S        => dispScore,
            segments => output
        );
    
    dispScore <= p1Score when counter(17) = '0' else p2score;
    
    seg1 <= counter(17); -- Use seg1/2 to toggle anode/cathode; 
    seg2 <= not counter(17);
end;
