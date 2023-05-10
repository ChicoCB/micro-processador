library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is 
end;

architecture ula_tb_arch of ula_tb is
	component ULA 
		port (
			A : in unsigned(15 downto 0);
			B : in unsigned(15 downto 0);
			C : in unsigned(1 downto 0);
			S : out unsigned(15 downto 0)
		);
	end component;
	signal EntradaA,EntradaB,Saida : unsigned(15 downto 0);
	signal Controle : unsigned(1 downto 0);
	
	begin
		ula_tb1: ULA port map (
			A=>EntradaA,
			B=>EntradaB,
			S=>Saida,
			C=>Controle
		);
		
	process 
		begin
			Controle <= "00";
			EntradaA <= "0000000000000011";
			EntradaB <= "0000000000000001";
			wait for 10 ns;
			Controle <= "01";
			EntradaA <= "0000000000000011";
			EntradaB <= "0000000000000001";
			wait for 10 ns;
			Controle <= "10";
			EntradaA <= "0000000000000011";
			EntradaB <= "0000000000000001";
			wait for 10 ns;
			Controle <= "11";
			EntradaA <= "0000000000000011";
			EntradaB <= "0000000000000001";
			wait for 10 ns;
			Controle <= "10";
			EntradaA <= "0000000000000001";
			EntradaB <= "0000000000000001";
			wait for 10 ns;
			Controle <= "11";
			EntradaA <= "0000000000000011";
			EntradaB <= "0000000001000001";
			wait for 10 ns;
			wait;
	end process;
	
end architecture;