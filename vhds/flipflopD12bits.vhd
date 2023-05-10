library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipflopD12bits is
    port(
        clk, wrenable, reset: in std_logic;
        data_in: in unsigned (11 downto 0);
        data_out: out unsigned (11 downto 0)
    );
end entity;

architecture flipflopD12bits_arch of flipflopD12bits is

    signal registro: unsigned (11 downto 0);

    begin
        process(clk, reset, wrenable)
        begin
            if(reset = '1') then
                registro <= "000000000000";
            elsif wrEnable='1' then
                if rising_edge(clk) then
                    registro <= data_in;
                end if;
            end if;
        end process;

    data_out <= registro;

end architecture;