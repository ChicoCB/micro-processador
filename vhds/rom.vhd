library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        address: in unsigned (6 downto 0);
        data: out unsigned (13 downto 0)
    );
end entity;

architecture rom_arch of rom is
    type mem is array (0 to 127) of unsigned(13 downto 0);
    constant conteudo_rom : mem := (
        -- caso endereco => conteudo
        0 => "01010110000101",
        1 => "01011000001000",
        2 => "01010010000000",
        3 => "00000010010110",
        4 => "00000010011000",
        5 => "01001010010000",
        6 => "01101011010000",
        7 => "11110000010100",
        8 => "00000000000000",
        9 => "00000000000000",
        11 => "00000000000000",
        20 => "01000111010000",
        21 => "11110000000010",
        -- abaixo: casos omissos => (zero em todos os bits)
        others => (others=>'0')
    );
    begin
        process(clk)
        begin
            if(rising_edge(clk)) then
                data <= conteudo_rom(to_integer(address));
            end if;
        end process;
end architecture;