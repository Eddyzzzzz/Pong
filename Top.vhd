library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Top is
port(
    -- NES
    nesIn1  : in std_logic;
    nesIn2  : in std_logic;
    nesClk1 : out std_logic;
    nesClk2 : out std_logic;
    latch1  : out std_logic;
    latch2  : out std_logic;
    
    -- Segment
    seg1    : out std_logic;
    seg2    : out std_logic; 
    segDisp : out std_logic_vector(6 downto 0);
    
    -- Data
    HSYNC   : out std_logic;
    VSYNC   : out std_logic;
    rgb     : out std_logic_vector(5 downto 0)
);
end;
    
architecture synth of Top is
    component HSOSC is 
		generic (
			CLKHF_DIV : String := "0b00"); -- Divide 48MHz clk by 2^N (0-3)	
		port(
			CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
			CLKHFEN : in std_logic := 'X'; -- Set to 1 to enable output
			CLKHF : out std_logic := 'X'); -- clk output
	end component;

    component Ball is 
        port(
            clk   : in std_logic;
            state : in std_logic;
            p1pos : in unsigned(9 downto 0);
            p2pos : in unsigned(9 downto 0);
            xPos  : out unsigned(9 downto 0);
            yPos  : out unsigned(9 downto 0);
            scored: out std_logic_vector(1 downto 0)
        );
    end component;
    
    component NES is 
        port(
            latch1 : out std_logic;
            latch2 : out std_logic;
    
            clk1 : out std_logic;
            clk2 : out std_logic;
    
            data1 : in std_logic;
            data2 : in std_logic;
    
            nes1 : out std_logic_vector(1 downto 0); --bit 1 : up; bit 2 : down
            nes2 : out std_logic_vector(1 downto 0); --bit 1 : up; bit 2 : down
    
            isStart : out std_logic
        );
    end component;
    
    component PatternGen is 
        port(
            row : in unsigned(9 downto 0);  
            col : in unsigned(9 downto 0); 
            p1Pos : in unsigned(9 downto 0);
            p2Pos : in unsigned(9 downto 0);
            xPos : in unsigned(9 downto 0);
            yPos : in unsigned(9 downto 0);
            rgb : out std_logic_vector(5 downto 0)
        );
    end component;
    
    component Score is 
        port(
            clk : in std_logic;
      
            --   reset :in std_logic;
              
            scored : in std_logic_vector(1 downto 0);
            
            p1Score : out unsigned(3 downto 0);
            p2Score : out unsigned(3 downto 0);
            
            isWin : out std_logic
        );
    end component;
    
    component VGA is 
        port(
            clk : in std_logic;
        	row : out unsigned(9 downto 0);
        	col : out unsigned(9 downto 0);
        	HSYNC : out std_logic;
        	VSYNC: out std_logic
        );
    end component;
    
    component SevenSegDisplay is 
        port(
            clk     : in std_logic;
            p1Score : in unsigned(3 downto 0);
            p2Score : in unsigned(3 downto 0);
            
            segDisp : out std_logic_vector(6 downto 0);
            seg1    : out std_logic;
            seg2    : out std_logic
        );
    end component;
    
    component Paddle is 
        port(
            clk    : in std_logic;
            p1Move : in std_logic_vector(1 downto 0);
            p2Move : in std_logic_vector(1 downto 0);
            state  : in std_logic;
            
            p1Pos : out unsigned(9 downto 0);
            p2Pos : out unsigned(9 downto 0)
        );
    end component;
    
    component GameState is 
        port(
            clk     : in std_logic; -- shared clk
            isStart : in std_logic; -- Signal asserting if the isStart has been pressed
            isWin   : in std_logic; -- Signal asserting if someone has won a game
            
            state   : out std_logic -- 0 if playing, 1 if in game over
        );
    end component;
    
    signal p1Move  : std_logic_vector(1 downto 0);
    signal p2Move  : std_logic_vector(1 downto 0);
    signal p1Pos   : unsigned(9 downto 0);
    signal p2Pos   : unsigned(9 downto 0);
    signal xPos    : unsigned(9 downto 0);
    signal yPos    : unsigned(9 downto 0);
    signal scored  : std_logic_vector(1 downto 0);
    signal p1Score : unsigned(3 downto 0);
    signal p2Score : unsigned(3 downto 0);
    signal row     : unsigned(9 downto 0);
    signal col     : unsigned(9 downto 0);
    
    signal clk     : std_logic;
    signal isStart : std_logic;
    signal isWin   : std_logic;
    signal state   : std_logic;
    
    
begin
    clkModule : HSOSC
		port map (
			CLKHFPU => '1',
			CLKHFEN => '1',
			CLKHF   => clk
		);
    
    ballModule : Ball
        port map(
            clk => clk,
            p1Pos => p1Pos,
            p2Pos => p2Pos,
            state => state,
            xPos => xPos,
            yPos => yPos
        );
        
    scoreModule : Score
        port map(
            clk => clk,
            scored => scored,
            p1Score => p1Score,
            p2Score => p2Score,
            isWin => isWin
        );
    
    segDispModule : SevenSegDisplay
        port map(
            clk => clk,
            p1Score => p1Score,
            p2Score => p2Score,
            segDisp => segDisp,
            seg1 => seg1,
            seg2 => seg2
        );
        
    nesModule : NES 
        port map (
            data1 => nesIn1,
            data2 => nesIn2,
            clk1 => nesClk1,
            clk2 => nesClk2,
            latch1 => latch1,
            latch2 => latch2,
            nes1   => p1Move,
            nes2   => p2Move,
            isStart  => isStart
        );
    
    padModule : Paddle
        port map(
            clk => clk,
            p1Move => p1Move,
            p2Move => p2Move,
            p1Pos => p1Pos, 
            p2Pos => p2Pos,
            state  => state
        );
    
    gameStateModule : GameState
        port map(
            clk => clk,
            isWin => isWin,
            isStart => isStart,
            state => state
        );
    
    patternGenModule : PatternGen
        port map(
            p1Pos => p1Pos,
            p2Pos => p2Pos,
            xPos => xPos,
            yPos => yPos,
            row => row,
            col => col,
            rgb => rgb
        );
    
    VGAModule : VGA
        port map(
            clk => clk,
            HSYNC => HSYNC,
            VSYNC => VSYNC,
            row => row,
            col => col
        );
end;
