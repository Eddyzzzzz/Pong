library IEEE;
use IEEE.std_logic_1164.all; use IEEE.numeric_std.all;
entity top is port(
latch : out std_logic;
clock : out std_logic;
data : in std_logic;
LEDs : out std_logic_vector(7 downto 0)
);
end top;
architecture synth of top is
component HSOSC is generic (
CLKHF_DIV : String := "0b00"); port(
CLKHFPU : in std_logic := 'X'; CLKHFEN : in std_logic := 'X'; CLKHF : out std_logic := 'X');
end component;
signal clk : std_logic;
-- 48 MHz * 25ms = 1200000 = 2^20
signal counter : unsigned (20 downto 0) := 21d"0"; signal NESclk : std_logic;
signal NEScount : unsigned (7 downto 0);
signal output : std_logic_vector(7 downto 0):= 8d"0";
begin
clo : HSOSC
port map(
CLKHF => clk,
CLKHFEN => '1', CLKHFPU => '1'
);
process(clk) begin
if rising_edge(clk) then
counter <= counter + '1'; end if;
end process;
NESclk <= counter(8);
NEScount <= counter(16 downto 9);
latch <= '1' when NEScount = "11111111" else '0';
clock <= NESclk when NEScount < "00001000" else '0';
process (clock) begin
if rising_edge(clock) then
output(0) <= output(1); output(1) <= output(2); output(2) <= output(3); output(3) <= output(4); output(4) <= output(5); output(5) <= output(6); output(6) <= output(7); output(7) <= data;
end if; end process;
process (latch) begin
if rising_edge(latch) then
LEDs <= output; end if;
end process; end;