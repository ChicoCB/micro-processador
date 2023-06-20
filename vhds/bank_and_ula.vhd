library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank_and_ula is
	port (
		wrFlagZEnable: in std_logic;
		regA,regB,regDest : in unsigned(2 downto 0);
		wrEnable,reset,clk,immediate, ram_or_ula : in std_logic;
		flagZout : out std_logic;
		operation : in unsigned(3 downto 0);
		dataOut,dataA : out unsigned(15 downto 0);
		ramOut : in unsigned(15 downto 0);
		extConst : in unsigned(15 downto 0)
	);
end entity;


architecture bank_and_ula_arch of bank_and_ula is
	component ULA 
		port (
			A : in unsigned(15 downto 0);
			B : in unsigned(15 downto 0);
			C : in unsigned(3 downto 0);
			S : out unsigned(15 downto 0)
		);
	end component;
	
	component MUX_2x1
		port (
			E0,E1 : in unsigned(15 downto 0);
			C : in std_logic;
			S : out unsigned(15 downto 0)
		);
	end component;
	
	component bancoDeRegs 
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
	end component;
	 
	signal ulaInA, ulaInB, dataB, ulaResult, bankWrData : unsigned (15 downto 0);
	signal opcode: unsigned (3 downto 0);
	
	begin
		banco : bancoDeRegs port map (
			wrFlagZEnable => wrFlagZEnable,
			wrEnable => wrEnable,
			reset => reset,
			clk => clk,
			regA => regA,
			regB => regB,
			regDest => regDest,
			dataA => ulaInA,
			dataB => dataB,
			flagZout=>flagZout,
			wrData => bankWrData
		);
		
		ula1 : ULA port map (
			A => ulaInA,
			B => ulaInB,
			C => operation,
			S => ulaResult
		);
		
		--Decide se a entrada B da ula será uma constante da instrução ou valor de um reg do banco
		mux : MUX_2x1 port map (
			E0 => dataB,
			E1 => extConst,
			C => immediate,
			S => ulaInB
		);
		
		--Decide se vai ser escrito saída da ula ou da ram no banco
		mux2 : MUX_2x1 port map (
			E0 => ulaResult,
			E1 => ramOut,
			C => ram_or_ula,
			S => bankWrData
		);
	
		dataA <= ulaInA;
		dataOut <= ulaResult;
	
end architecture;