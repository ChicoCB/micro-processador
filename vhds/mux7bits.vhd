library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux7bits is
    port(
        control: in std_logic;
        data_A: in unsigned (6 downto 0);
        data_B: in unsigned (6 downto 0);
        data_out: out unsigned (6 downto 0)
    );
end entity;

architecture mux7bits_arch of mux7bits is
    begin
        data_out <= data_A when control = '0' else
        data_B when control = '1' else
        "0000000";
end architecture;