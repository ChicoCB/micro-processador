library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operations is
	port (
		A : in unsigned(15 downto 0);
		B : in unsigned(15 downto 0);
		Soma: out unsigned(15 downto 0);
		Sub: out unsigned(15 downto 0);
		Inc: out unsigned(15 downto 0);
		Dec: out unsigned(15 downto 0);
		Mov: out unsigned(15 downto 0);
		A_menor_B: out unsigned(15 downto 0)
	);
end entity;


architecture operations_arch of operations is
	begin
		Soma <= A+B;
		Sub <= A-B;
		Inc <= A + 1;
		Dec <= A - 1;
		Mov <= B;
		A_menor_B <= "0000000000000001" when (A < B) else "0000000000000000";
end architecture;