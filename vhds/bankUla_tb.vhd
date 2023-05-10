library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bankUla_tb is
end;

architecture bankUla_tb_arch of bankUla_tb is
    component bankUla
        port(
            extConst: in unsigned (15 downto 0);
            ulaOut: out unsigned (15 downto 0);
            operation: in unsigned (1 downto 0);
            wrEnable, clk, reset, muxControl: in std_logic;
            regA, regB, regDest: in unsigned (2 downto 0)
        );
    end component;

    constant period_time : time := 100 ns;
	signal finished : std_logic := '0';
	signal clk, reset : std_logic;
	signal wrEnable, muxControl : std_logic;
	signal dataA, dataB, wrData, extConst, ulaOut : unsigned(15 downto 0);
	signal regA, regB, regDest : unsigned(2 downto 0);
    signal operation: unsigned(1 downto 0);

    begin
        uut: bankUla port map(
            extConst => extConst,
            ulaOut => ulaOut,
            operation => operation, 
            wrEnable => wrEnable,
            clk => clk,
            reset => reset,
            muxControl => muxControl,
            regA => regA,
            regB => regB,
            regDest => regDest
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
			begin -- Gera clock até que sim_time_proc termine
				 while finished /= '1' loop
				 clk <= '0';
				 wait for period_time/2;
				 clk <= '1';
				 wait for period_time/2;
				 end loop;
				 wait;
		end process clk_proc;
		
		process -- Sinais dos casos de teste
			 begin
				
				---------- addi $reg1,$reg0,0xFF00  ------------

				operation <= "00"; -- sum operation
				regA <= "000"; -- reads from reg_0 that is always zero
				regB <= "001"; -- reads from reg_1 that is zero AT THE MOMENT

				-- IMPORTANT: During this test the ULA SRC MUX is set to 1, so it will get from data-in
				muxControl <= '1';

				extConst <= "1111111100000000";
				regDest <= "001"; -- sets the value of data_in to reg_1
				
				wait for period_time*2;
				
				wait;
		end process;

end architecture;