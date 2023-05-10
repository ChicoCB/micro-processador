library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit_tb is
end;

architecture ControlUnit_tb_arch of ControlUnit_tb is
    component ControlUnit
        port(
            clk, reset: in std_logic;
            data_out: out unsigned (13 downto 0)
        );
    end component;

    signal clk, reset: std_logic;
    constant period_time : time := 100 ns;
	signal finished : std_logic := '0';

    begin
        uut: ControlUnit port map(
            clk => clk,
            reset => reset
        );

        reset_global: process
			begin
				 reset <= '1';
				 wait for 20 ns; -- espera 2 clocks, pra garantir
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
end architecture;