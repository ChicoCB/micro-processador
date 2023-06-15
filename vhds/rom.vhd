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
		0 => "01110100001000", --MOV R2,8
		1 => "01110110000101", --MOV R3,5
		2 => "10010100110000", --MOV @R2,R3 (write)
		3 => "10000101000000", --MOV R4,@R2 (read)
		4 => "10010110100000", --MOV @R3,R2 (write)
		5 => "10000111110000", --MOV R7,@R3 (read)
		6 => "01111101000000", --MOV R6,64
		7 => "10011101000000", --MOV @R6,R4
		8 => "10011001110000", --MOV @R6,R7
		
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