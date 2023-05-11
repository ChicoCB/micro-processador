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
		Igual: out unsigned(15 downto 0);
		A_maior_B : out unsigned(15 downto 0);
		RetornaA: out unsigned(15 downto 0);
		RetornaConst : out unsigned(15 downto 0);
		Dec: out unsigned(15 downto 0)
	 );
	end component;
	
	component MUX_10x1
		port (
			E0,E1,E2,E3,E4,E5,E6,E7,E8,E9 : in unsigned(15 downto 0);
			C : in unsigned(3 downto 0);
			S : out unsigned(15 downto 0)
		);
	end component;
	signal Soma,Sub,Igual,A_maior_B,RetornaA, Dec, RetornaConst,E7,E8 : unsigned(15 downto 0);
	begin
		
		op: operations port map (
			A=>A,
			B=>B,
			Soma=>Soma,
			Sub=>Sub,
			Igual=>Igual,
			A_maior_B=>A_maior_B,
			RetornaA => RetornaA,
			RetornaConst => RetornaConst,
			Dec => Dec
		);
		
		mux: MUX_10x1 port map (
			E0 => Soma,
			E1 => Sub,
			E2 => Igual,
			E3 => A_maior_B,
			E4 => RetornaA,
			E5 => RetornaConst,
			E6 => Dec,
			E7=>E7,
			E8=>E8,
			E9=>Soma,
			C=>C,
			S=>S
		);
		E7 <= "0000000000000000";
		E8 <= "0000000000000000";
		
end architecture;