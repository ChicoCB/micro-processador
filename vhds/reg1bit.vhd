library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1bit is
	 port( clk : in std_logic;
	 reset : in std_logic;
	 wrEnable : in std_logic;
	 dIn : in std_logic;
	 dOut : out std_logic
 );
end entity;

architecture reg1bit_arch of reg1bit is
	signal registro: std_logic;
	begin
		 process(clk,reset,wrEnable) -- acionado se houver mudança em clk, reset ou wrEnable
		 begin
			 if reset='1' then
				registro <= '0';
			 elsif wrEnable='1' then
				if rising_edge(clk) then
					registro <= dIn;
				end if;
			 end if;
		 end process;

	dOut <= registro; -- conexao direta, fora do processo
end architecture;


	