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
    signal output1   : std_logic_vector(6 downto 0);
    signal output2   : std_logic_vector(6 downto 0);
    
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
    
    seg1Disp : sevenSeg
        port map (
            S        => p1Score,
            segments => output1
        );
    
    seg2Disp : sevenSeg
        port map (
            S        => p2Score,
            segments => output2
        );
    
    segDisp <= output1 when counter(19) = '0' else output2;
    seg1 <= counter(19);
    seg2 <= not counter(19);
end;
