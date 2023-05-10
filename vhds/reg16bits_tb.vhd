library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits_tb is
end;

architecture reg16bits_tb_arch of reg16bits_tb is
	component reg16bits 
		port (
			 clk : in std_logic;
			 reset : in std_logic;
			 wrEnable : in std_logic;
			 dIn : in unsigned(15 downto 0);
			 dOut : out unsigned(15 downto 0)
		);
	end component;
	constant period_time : time := 100 ns;
	signal finished : std_logic := '0';
	signal clk, reset : std_logic;
	signal wrEnable : std_logic;
	signal dIn,dOut : unsigned(15 downto 0);
	
	begin
		uut: reg16bits port map (
			clk => clk,
			reset => reset,
			wrEnable => wrEnable,
			dIn => dIn,
			dOut => dOut
		);
	
	
		reset_global: process
			begin
				 reset <= '1';
				 wait for period_time*2; -- espera 2 clocks, pra garantir
				 reset <= '0';
				 wait;
		end process reset_global;

		sim_time_proc: process
			begin
				 wait for 10 us; -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
				 finished <= '1';
				 wait;
		end process sim_time_proc;
		
		clk_proc: process
			begin -- gera clock até que sim_time_proc termine
				 while finished /= '1' loop
				 clk <= '0';
				 wait for period_time/2;
				 clk <= '1';
				 wait for period_time/2;
				 end loop;
				 wait;
		end process clk_proc;
		
		
		process -- sinais dos casos de teste (p.ex.)
			 begin
				 wait for 200 ns;
				 wrEnable <= '1';
				 dIn <= "1111111111111111";
				 wait for period_time*10;
				 dIn <= "0000000000000000";
				 wait for period_time*10;
				 dIn <= "1000000000000001";
				 wait for period_time*10;
				 dIn <= "1000011100000001";
				 wait; -- <== OBRIGATÓRIO TERMINAR COM WAIT; !!!
		end process;

end architecture;	

		
		