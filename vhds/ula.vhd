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
	
	component MUX_16x1
		port (
			E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15 : in unsigned(15 downto 0);
			C : in unsigned(3 downto 0);
			S : out unsigned(15 downto 0)
		);
	end component;
	signal Soma,Sub,Inc,Dec,Mov,E7,E8,E9,E10,E11,E12,E13,E14,E15 : unsigned(15 downto 0);
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
		
		mux: MUX_16x1 port map (
			E0 => Soma, --0000
			E1 => Soma, --0001
			E2 => Sub, --0010
			E3 => Sub, --0011
			E4 => Inc, --0100
			E5 => Dec, --0101
			E6 => Mov, --0110
			E7 => Mov, --0111 MOV R, #immediate
			E8 => Mov, --1000 MOV R, @R - read (invertido)
			E9 => Mov, --1001 MOV @R, R - write
			E10 => E10, --1010
			E11 => E11, --1011
			E12 => E12, --1100
			E13 => E13, --1101
			E14 => E14, --1110 JNZ
			E15 => E15, --1111 jump
			
			C=>C,
			S=>S
		);
		E10 <= "0000000000000000";
		E11 <= "0000000000000000";
		E12 <= "0000000000000000";
		E13 <= "0000000000000000";
		E14 <= "0000000000000000";
		E15 <= "0000000000000000";
		
end architecture;