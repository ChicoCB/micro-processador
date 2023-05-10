library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        clk, wrenable, reset: in std_logic;
        data_in: in unsigned (6 downto 0);
        data_out: out unsigned (6 downto 0)
    );
end entity;

architecture PC_arch of PC is

    signal registro: unsigned (6 downto 0);

    begin
        process(clk, reset, wrenable)
        begin
            if(reset = '1') then
                registro <= "0000000";
            elsif wrEnable='1' then
                if rising_edge(clk) then
                    registro <= data_in;
                end if;
            end if;
        end process;

    data_out <= registro;

end architecture;