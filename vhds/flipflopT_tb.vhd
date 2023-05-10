library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipflopT_tb is
end;

architecture flipflopT_tb_arch of flipflopT_tb is
	component flipflopT 
		port (
			Toggle: in std_logic;
			data_out: out std_logic;
			clk: in std_logic;
			reset: in std_logic
		);
	end component;
	signal Toggle,data_out,clk,reset : std_logic;
	
	begin
		uut : flipflopT port map (
			Toggle => Toggle,
			data_out => data_out,
			clk => clk,
			reset => reset
		);
		
		process 
			begin
			clk <= '0';
			reset <= '1';
			wait for 80 ns;
			reset <= '0';
			Toggle <= '1';
			clk <= '1';
			wait for 80 ns;
			clk <= '0';
			wait for 80 ns;
			clk <= '1';
			wait for 80 ns;
			clk <= '0';
			wait for 80 ns;
			clk <= '1';
			wait for 80 ns;
			clk <= '0';
			wait for 80 ns;
			Toggle <= '0';
			wait for 80 ns;
			clk <= '1';
			wait for 80 ns;
			clk <= '0';
			wait for 80 ns;
			clk <= '1';
			wait for 80 ns;
			clk <= '0'; 
			wait for 80 ns;
			clk <= '1';
			wait for 80 ns;
			clk <= '0';
			wait for 80 ns;
			wait;
	end process;
end architecture;
		