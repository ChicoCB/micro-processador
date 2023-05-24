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
		0 => "01110110000000", --MOV R3,0
        1 => "01111000000000", --MOV R4,0
		2 => "01100011001000", --MOV A,R4
		3 => "00000010111000", --ADD A,R3
		4 => "01101000011000", --MOV R4,A
		5 => "01000110011000", --INC R3
		6 => "01100010110000", --MOV A,R3
		7 => "00110010011110", --SUB A,30
		8 => "11100001111010", --JNZ -6
		9 => "01101011000000", --MOV R5,R4
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