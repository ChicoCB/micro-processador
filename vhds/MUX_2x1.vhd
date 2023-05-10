library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_2x1 is 
	port (
		E0,E1 : in unsigned(15 downto 0);
		C : in std_logic;
		S : out unsigned(15 downto 0)
	);
end entity;

architecture MUX_2x1_arch of MUX_2x1 is 
	begin
		S <= E1 when C = '1' else
		E0 when C = '0' else
		"0000000000000000";
end architecture;