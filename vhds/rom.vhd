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
		0 => "0111_011_0000000", --MOV R3,0
        1 => "0111_100_0000000", --MOV R4,0
		2 => "0110_001_100_1000", --MOV A,R4
		3 => "0000_001_011_1000", --ADD A,R3
		4 => "0110_100_001_1000", --MOV R4,A
		4 => "0100_011_0011000", --INC R3
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