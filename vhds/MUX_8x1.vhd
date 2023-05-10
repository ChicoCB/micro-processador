library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_8x1 is 
	port (
		E0,E1,E2,E3,E4,E5,E6,E7 : in unsigned(15 downto 0);
		C : in unsigned(2 downto 0);
		S : out unsigned(15 downto 0)
	);
end entity;

architecture MUX_8x1_arch of MUX_8x1 is 
	begin
		S <= E7 when C = "111" else
		E6 when C = "110" else
		E5 when C = "101" else
		E4 when C = "100" else
		E3 when C = "011" else
		E2 when C = "010" else
		E1 when C = "001" else
		E0 when C = "000" else
		"0000000000000000";
end architecture;