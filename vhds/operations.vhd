library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operations is
	port (
		A : in unsigned(15 downto 0);
		B : in unsigned(15 downto 0);
		Soma: out unsigned(15 downto 0);
		Sub: out unsigned(15 downto 0);
		Igual: out unsigned(15 downto 0);
		A_maior_B : out unsigned(15 downto 0)
	);
end entity;


architecture operations_arch of operations is
	begin
		Soma <= A+B;
		Sub <= A-B;
		Igual <= "0000000000000001" when A=B else "0000000000000000";
		A_maior_B <= "0000000000000000" when A<B else "0000000000000001";
end architecture;