library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UnitAdder is
    port(
        data_in: in unsigned (11 downto 0);
        data_out: out unsigned (11 downto 0)
    );
end entity;

architecture UnitAdder_arch of UnitAdder is
    begin
        data_out <= data_in + "000000000001";

end architecture;