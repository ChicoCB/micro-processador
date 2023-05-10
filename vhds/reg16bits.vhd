library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits is
	 port( clk : in std_logic;
	 reset : in std_logic;
	 wrEnable : in std_logic;
	 dIn : in unsigned(15 downto 0);
	 dOut : out unsigned(15 downto 0)
 );
end entity;

architecture reg16bits_arch of reg16bits is
	signal registro: unsigned(15 downto 0);
	begin
		 process(clk,reset,wrEnable) -- acionado se houver mudança em clk, reset ou wrEnable
		 begin
			 if reset='1' then
				registro <= "0000000000000000";
			 elsif wrEnable='1' then
				if rising_edge(clk) then
					registro <= dIn;
				end if;
			 end if;
		 end process;

	dOut <= registro; -- conexao direta, fora do processo
end architecture;


	