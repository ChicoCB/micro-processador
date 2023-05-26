library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_16x1 is 
	port (
		E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15 : in unsigned(15 downto 0);
		C : in unsigned(3 downto 0);
		S : out unsigned(15 downto 0)
	);
end entity;

architecture MUX_16x1_arch of MUX_16x1 is 
	begin
		S <= E15 when C = "1111" else
		E14 when C = "1110" else
		E13 when C = "1101" else
		E12 when C = "1100" else
		E11 when C = "1011" else
		E10 when C = "1010" else
		E9 when C = "1001" else
		E8 when C = "1000" else
		E7 when C = "0111" else
		E6 when C = "0110" else
		E5 when C = "0101" else
		E4 when C = "0100" else
		E3 when C = "0011" else
		E2 when C = "0010" else
		E1 when C = "0001" else
		E0 when C = "0000" else
		"0000000000000000";
end architecture;