library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipflopD12bits_tb is
end;

architecture flipflopD12bits_tb_arch of flipflopD12bits_tb is
    component flipflopD12bits
        port(
            clk, wrenable, reset: in std_logic;
            data_in: in unsigned (11 downto 0);
            data_out: out unsigned (11 downto 0)
        );
    end component;

	signal clk, reset, wrenable : std_logic;
    signal data_in : unsigned(11 downto 0);

    begin
        uut: flipflopD12bits port map(
            clk => clk,
            reset => reset,
            wrenable => wrenable,
            data_in => data_in
        );
        process
            begin
                wrenable <= '1';
                clk <= '0';
                reset <= '1';
                wait for 200 ns;
                reset <= '0';
                data_in <= "000000000001";
                wait for 200 ns;
                clk <= '1';
                wait for 200 ns;
                clk <= '0';
                data_in <= "000000000010";
                wait for 200 ns;
                clk <= '1';
                wait for 200 ns;
                clk <= '0';
                wait;
        end process;
end architecture;