library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoDeRegs_tb is 
end;


architecture bancoDeRegs_tb_arch of bancoDeRegs_tb is
	component bancoDeRegs
	port(
		wrEnable: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		regA, regB, regDest: in unsigned (2 downto 0);
		dataA, dataB : out unsigned(15 downto 0);
		flagZout : out std_logic;
		wrData : in unsigned(15 downto 0)
		);
	end component;
	constant period_time : time := 100 ns;
	signal finished : std_logic := '0';
	signal clk, reset : std_logic;
	signal wrEnable,flagZout : std_logic;
	signal dataA,dataB,wrData : unsigned(15 downto 0);
	signal regA,regB,regDest : unsigned(2 downto 0);
	
	begin
		uut: bancoDeRegs port map (
			clk => clk,
			reset => reset,
			wrEnable => wrEnable,
			dataA => dataA,
			dataB => dataB,
			regA => regA,
			regB=> regB,
			regDest=>regDest,
			flagZout=>flagZout,
			wrData=>wrData
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
				--Registra valores em cada reg
				wait for period_time*3;
				wrEnable <= '1';
				wrData <= "0000000000000000";
				wait for period_time*2;
				wrData <= "0000000000010000";
				wait for period_time*2;
				wrData <= "0000000000000000";
				wait for period_time*2;
				wrData <= "0000000000010010";
				wait for period_time*2;
				wrData <= "0000000000000000";
				wait for period_time*2;
				
				wait for period_time*3;
				wrEnable <= '1';
				wrData <= "0000000000000001";
				regDest <= "001";
				wait for period_time*2;
				wrData <= "0000000000000010";
				regDest <= "010";
				wait for period_time*2;
				wrData <= "0000000000000100";
				regDest <= "011";
				wait for period_time*2;
				wrData <= "0000000000001000";
				regDest <= "100";
				wait for period_time*2;
				wrData <= "0000000000010000";
				regDest <= "101";
				wait for period_time*2;
				wrData <= "0000000000100000";
				regDest <= "110";
				wait for period_time*2;
				wrData <= "0000000001000000";
				regDest <= "111";
				wait for period_time*2;
				--Muda as saídas para mostrar cada reg (muda dataA e dataB de acordo com cada reg)
				wrEnable <= '0';
				regA <= "000";
				regB <= "001";
				wait for period_time*2;
				regA <= "010";
				regB <= "011";
				wait for period_time*2;
				regA <= "100";
				regB <= "101";
				wait for period_time*2;
				regA <= "110";
				regB <= "111";
				wait for period_time*2;
				
				wait; -- <== OBRIGATÓRIO TERMINAR COM WAIT; !!!
		end process;
		
end architecture;