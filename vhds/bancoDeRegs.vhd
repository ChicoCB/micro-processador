library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoDeRegs is
	port(
		wrFlagZEnable: in std_logic;
		wrEnable: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		regA, regB, regDest: in unsigned (2 downto 0);
		dataA, dataB : out unsigned(15 downto 0);
		flagZout : out std_logic;
		wrData : in unsigned(15 downto 0)
		);
		
end entity;

architecture bancoDeRegs_arch of bancoDeRegs is
	component reg16bits
		port( clk : in std_logic;
			 reset : in std_logic;
			 wrEnable : in std_logic;
			 dIn : in unsigned(15 downto 0);
			 dOut : out unsigned(15 downto 0)
		);
	end component;
	
	component MUX_8x1 
	port (
		E0,E1,E2,E3,E4,E5,E6,E7 : in unsigned(15 downto 0);
		C : in unsigned(2 downto 0);
		S : out unsigned(15 downto 0)	
	);
	end component;
	
	component reg1bit
		port( clk : in std_logic;
			 reset : in std_logic;
			 wrEnable : in std_logic;
			 dIn : in std_logic;
			 dOut : out std_logic
		);
	end component;
	
	signal r0out,r1out,r2out,r3out,r4out,r5out,r6out,r7out: unsigned (15 downto 0); --Saídas de cada reg
	signal wrEnableR1,wrEnableR2,wrEnableR3,wrEnableR4,wrEnableR5,wrEnableR6,wrEnableR7 : std_logic; --wrEnable de cada reg
	signal dInZ, wrZ : std_logic; --Sinais flag Z

	begin
	
		--Habilita a escrita apenas do registrador de destino escolhido
		wrEnableR1 <= '1' when regDest = "001" and wrEnable = '1' else '0';
		wrEnableR2 <= '1' when regDest = "010" and wrEnable = '1' else '0';
		wrEnableR3 <= '1' when regDest = "011" and wrEnable = '1' else '0';
		wrEnableR4 <= '1' when regDest = "100" and wrEnable = '1' else '0';
		wrEnableR5 <= '1' when regDest = "101" and wrEnable = '1' else '0';
		wrEnableR6 <= '1' when regDest = "110" and wrEnable = '1' else '0';
		wrEnableR7 <= '1' when regDest = "111" and wrEnable = '1' else '0';
	
		reg0: reg16bits port map (
			dIn => "0000000000000000",
			clk => '0',
			reset=>'1',
			dOut => r0out,
			wrEnable=> '0'
		);
		reg1: reg16bits port map (
			dIn => wrData,
			clk => clk,
			reset=>reset,
			dOut => r1out,
			wrEnable=>wrEnableR1
		);
		reg2: reg16bits port map (
			dIn => wrData,
			clk => clk,
			reset=>reset,
			dOut => r2out,
			wrEnable=>wrEnableR2
		);
		reg3: reg16bits port map (
			dIn => wrData,
			clk => clk,
			reset=>reset,
			dOut => r3out,
			wrEnable=>wrEnableR3
		);
		reg4: reg16bits port map (
			dIn => wrData,
			clk => clk,
			reset=>reset,
			dOut => r4out,
			wrEnable=>wrEnableR4
		);
		reg5: reg16bits port map (
			dIn => wrData,
			clk => clk,
			reset=>reset,
			dOut => r5out,
			wrEnable=>wrEnableR5
		);
		reg6: reg16bits port map (
			dIn => wrData,
			clk => clk,
			reset=>reset,
			dOut => r6out,
			wrEnable=>wrEnableR6
		);
		reg7: reg16bits port map (
			dIn => wrData,
			clk => clk,
			reset=>reset,
			dOut => r7out,
			wrEnable=>wrEnableR7
		);
		flagZ: reg1bit port map (
			dIn => dInZ,
			clk => clk,
			reset=>reset,
			dOut => flagZout,
			wrEnable=>wrZ
		);
		
		muxA: MUX_8x1 port map ( --Mux que decide a saída dataA
			E0 => r0out,
			E1 => r1out,
			E2 => r2out,
			E3 => r3out,
			E4 => r4out,
			E5 => r5out,
			E6 => r6out,
			E7 => r7out,
			C => regA,
			S => dataA
		);
		muxB: MUX_8x1 port map ( --Mux que decide a saída dataB
			E0 => r0out,
			E1 => r1out,
			E2 => r2out,
			E3 => r3out,
			E4 => r4out,
			E5 => r5out,
			E6 => r6out,
			E7 => r7out,
			C => regB,
			S => dataB
		);
		
		wrZ <= '1' when wrFlagZEnable = '1' and wrEnable = '1' else '0';
		dInZ <= '1' when wrData = "0000000000000000" else '0'; --Seta flagZ
	
end architecture;