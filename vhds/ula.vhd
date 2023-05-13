library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
	port (
		A : in unsigned(15 downto 0);
		B : in unsigned(15 downto 0);
		C : in unsigned(3 downto 0);
		S : out unsigned(15 downto 0)
	);
end entity;

architecture ULA_arch of ULA is
	component operations 
	 port (
		A : in unsigned(15 downto 0);
		B : in unsigned(15 downto 0);
		Soma: out unsigned(15 downto 0);
		Sub: out unsigned(15 downto 0);
		Inc: out unsigned(15 downto 0);
		Dec: out unsigned(15 downto 0);
		Mov: out unsigned(15 downto 0)
	 );
	end component;
	
	component MUX_10x1
		port (
			E0,E1,E2,E3,E4,E5,E6,E7,E8,E9 : in unsigned(15 downto 0);
			C : in unsigned(3 downto 0);
			S : out unsigned(15 downto 0)
		);
	end component;
	signal Soma,Sub,Inc,Dec,Mov,E7,E8,E9 : unsigned(15 downto 0);
	begin
		
		op: operations port map (
			A=>A,
			B=>B,
			Soma=>Soma,
			Sub=>Sub,
			Inc=>Inc,
			Dec => Dec,
			Mov=>Mov
		);
		
		mux: MUX_10x1 port map (
			E0 => Soma,
			E1 => Soma,
			E2 => Sub,
			E3 => Sub,
			E4 => Inc,
			E5 => Dec,
			E6 => Mov,
			E7 => Mov,
			E8 => E8,
			E9 => E9,
			C=>C,
			S=>S
		);
		E8 <= "0000000000000000";
		E9 <= "0000000000000000";
		
end architecture;