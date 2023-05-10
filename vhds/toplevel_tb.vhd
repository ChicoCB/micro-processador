library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_tb is
end;

architecture toplevel_tb_arch of toplevel_tb is
	component toplevel
		port (
			regA,regB,regDest : in unsigned(2 downto 0);
			wrEnable,reset,clk,muxControl : in std_logic;
			operation : in unsigned(1 downto 0);
			dataOut : out unsigned(15 downto 0);
			extConst : in unsigned(15 downto 0)
		);
	end component;
	
	constant period_time : time := 100 ns;
	signal finished : std_logic := '0';
	signal wrEnable,reset,clk,muxControl :  std_logic;
	signal regA,regB,regDest :  unsigned(2 downto 0);
	signal operation :  unsigned(1 downto 0);
	signal dataOut :  unsigned(15 downto 0);
	signal extConst :  unsigned(15 downto 0);
	
	begin
		uut: toplevel port map (
			clk => clk,
			reset => reset,
			wrEnable => wrEnable,
			regA=>regA,
			regB=>regB,
			regDest=>regDest,
			operation=>operation,
			dataOut=>dataOut,
			extConst=>extConst,
			muxControl=>muxControl
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
		
		process
			begin 
			wait for period_time*2;
			--addi $reg1,$reg0,0000000000000001
			operation <= "00"; --Soma
			muxControl <= '1'; --Constante externa
			extConst <= "0000000000100000"; --Constante
		
			regA <= "000";
			regDest <= "001";
			
			wait for period_time;
			
			
			wrEnable <= '1'; --Escreve
			wait for period_time;
			
			
			wrEnable <= '0'; --Desliga escrita
			
			wait for period_time*10;
			
			--add $reg5,$reg1,$reg1
			
			regA <= "001";
			regB <= "001";
			regDest <= "101";
			muxControl <= '0'; --Recebe registrador 
			
			wait for period_time;
			
			wrEnable <= '1'; --Escreve
			wait for period_time;
			
			
			wrEnable <= '0'; --Desliga escrita
			
			wait for period_time*10;
			
			--subi $reg6,$reg5,0000000000000101
			operation <= "01";
			regA <= "101";
			regDest <= "110";
			muxControl <= '1'; --Recebe constante
			extConst <= "0000000000000101";
			
			wait for period_time;
			
			wrEnable <= '1'; --Escreve
			wait for period_time;
			
			
			wrEnable <= '0'; --Desliga escrita
			
			wait for period_time;
			wait;
			
		end process;

end architecture;