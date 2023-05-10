library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UnitAdder_tb is
end;

architecture UnitAdder_tb_arch of UnitAdder_tb is
    component UnitAdder
        port(
            data_in: in unsigned (11 downto 0);
            data_out: out unsigned (11 downto 0)
        );
    end component;

    signal data_in : unsigned(11 downto 0);

    begin
        uut: UnitAdder port map(
            data_in => data_in
        );
        process
            begin
                data_in <= "000000000000";
                wait for 200 ns;
                data_in <= "001000000000";
                wait for 200 ns;
                data_in <= "000000001111";
                wait for 200 ns;
                wait;
        end process;
end architecture;