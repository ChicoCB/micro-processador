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
        0 => "01110110000101", --MOV R3,5
        1 => "01111000001000", --MOV R4,8
        2 => "01100010110000", --MOV A,R3
        3 => "00000011000000", --ADD A,R4
        4 => "01101010010000", --MOV R5,A
        5 => "01011010000000", --DEC R5
        6 => "11110000010100", --JMP 0x010100
        20 => "01100011010000", --MOV A,R5
        21 => "01100110010000", --MOV R3,A
		22 => "11110000000010", --JMP 0x0000010
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