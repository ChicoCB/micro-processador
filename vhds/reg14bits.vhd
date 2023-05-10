library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg14bits is
	 port( clk : in std_logic;
	 reset : in std_logic;
	 wrEnable : in std_logic;
	 dIn : in unsigned(13 downto 0);
	 dOut : out unsigned(13 downto 0)
 );
end entity;

architecture reg14bits_arch of reg14bits is
	signal registro: unsigned(13 downto 0);
	begin
		 process(clk,reset,wrEnable) -- acionado se houver mudança em clk, reset ou wrEnable
		 begin
			 if reset='1' then
				registro <= "00000000000000";
			 elsif wrEnable='1' then
				if rising_edge(clk) then
					registro <= dIn;
				end if;
			 end if;
		 end process;

	dOut <= registro; -- conexao direta, fora do processo
end architecture;


	