library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux12bits_tb is
end entity;

architecture mux12bits_tb_arch of mux12bits_tb is

    component mux12bits
        port(
            control: in std_logic;
            data_A: in unsigned (11 downto 0);
            data_B: in unsigned (11 downto 0);
            data_out: out unsigned (11 downto 0)
        );
    end component;

    signal control: std_logic;
    signal E0: unsigned (11 downto 0);
    signal E1: unsigned (11 downto 0);

    begin
        uut: mux12bits port map(
            control => control,
            data_A => E0,
            data_B => E1
        );
        
        process
            begin
                E0 <= "000011110000";
                E1 <= "010010010001";
                control <= '0';
                wait for 200 ns;
                control <= '1';
                wait for 200 ns;
                wait;
        end process;
end architecture;