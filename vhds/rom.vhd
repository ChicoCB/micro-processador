library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        address: in unsigned (11 downto 0);
        data: out unsigned (13 downto 0)
    );
end entity;

architecture rom_arch of rom is
    type mem is array (0 to 4095) of unsigned(13 downto 0);
    constant conteudo_rom : mem := (
        -- caso endereco => conteudo
        0 => "00000000001000",
        1 => "10000000000001",
        2 => "11000000001000",
        3 => "00000000000110",
        4 => "10000000000011",
        5 => "00000000001010",
        6 => "11111111111111",
        7 => "00000000001011",
        8 => "00000000001001",
        9 => "11000000000110",
        10 => "00000000000010",
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