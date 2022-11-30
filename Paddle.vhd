library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Paddle is
port(
    clk     : in std_logic;
    p1Delta : in std_logic_vector(1 downto 0);
    p2Delta : in std_logic_vector(1 downto 0);
    restart : in std_logic;
    
    pad1Pos : out unsigned(9 downto 0);
    pad2Pos : out unsigned(9 downto 0)
);
end;
    
architecture synth of Paddle is
    signal pad1    : unsigned(9 downto 0);
    signal pad2    : unsigned(9 downto 0);
begin
    -- Screen is a 640 x 480
    process(clk)
    begin
        
        if rising_edge(clk) then
            if restart = '0' then
                pad1 <= 10b"11110000";
                pad2 <= 10b"11110000";
            else
                if p1Delta(1) = '1' then
                    pad1 <= pad1 + 10b"1" when pad1 < 413 else pad1;
                elsif p1Delta(0) = '1' then
                    pad1 <= pad1 + 10b"1111111111" when pad1 > 67 else pad1;
                end if;
                
                if p2Delta(1) = '1' then
                    pad2 <= pad2 + 10b"1" when pad2 < 413 else pad2;
                elsif p2Delta(0) = '1' then
                    pad2 <= pad2 + 10b"1111111111" when pad2 > 67 else pad2;
                end if;
            end if;
            
        end if;
    end process;
    
    pad1Pos <= pad1;
    pad2Pos <= pad2;
    
end;

