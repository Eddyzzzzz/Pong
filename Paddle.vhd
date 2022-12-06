library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Paddle is
port(
    clk    : in std_logic;
    p1Move : in std_logic_vector(1 downto 0);
    p2Move : in std_logic_vector(1 downto 0);
    state  : in std_logic;
    
    p1Pos : out unsigned(9 downto 0);
    p2Pos : out unsigned(9 downto 0)
);
end;
    
architecture synth of Paddle is
    signal delay   : unsigned(17 downto 0);
    signal pad1    : unsigned(9 downto 0);
    signal pad2    : unsigned(9 downto 0);
begin
    -- Screen is a 640 x 480
    process(clk)
    begin
        
        if rising_edge(clk) then
            if state = '1' then
                pad1  <= 10b"10100010";
                pad2  <= 10b"10100010";
                delay <= 19b"0";
            else
                if delay = 18b"0" then
                    if p1Move(0) = '0' then
                        pad1 <= pad1 + 10b"1" when pad1 < 345 else pad1;
                    elsif p1Move(1) = '0' then
                        pad1 <= pad1 - 10b"1" when pad1 > 0 else pad1;
					 else 
						pad1 <= pad1;
                    end if;
                    
                    if p2Move(0) = '0' then
                        pad2 <= pad2 + 10b"1" when pad2 < 345 else pad2;
                    elsif p2Move(1) = '0' then
                        pad2 <= pad2 - 10b"1" when pad2 > 0 else pad2;
                    else 
					 	pad2 <= pad2;
					end if;
					
                end if;
                delay <= delay + 18b"1";
            end if;
                
        end if;
    end process;
    
    p1Pos <= pad1;
    p2Pos <= pad2;

end;
