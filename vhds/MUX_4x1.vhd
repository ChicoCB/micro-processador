library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_4x1 is 
	port (
		E0,E1,E2,E3 : in unsigned(15 downto 0);
		C : in unsigned(1 downto 0);
		S : out unsigned(15 downto 0)
	);
end entity;

architecture MUX_4x1_arch of MUX_4x1 is 
	begin
		S <= E3 when C = "11" else
		E2 when C = "10" else
		E1 when C = "01" else
		E0 when C = "00" else
		"0000000000000000";
end architecture;