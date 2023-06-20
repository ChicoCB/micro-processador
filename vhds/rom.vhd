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
		0 => "0111" & "010" & "0000000", --MOV R2,0
        1 => "1001" & "010" & "010" & "0000", --MOV @R2,R2
        2 => "0100" & "010" & "0000000", --INC R2
        3 => "0110" & "001" & "010" & "0000", --MOV A,R2
        4 => "0011" & "001" & "0100001", --SUB A,30
        5 => "1110" & "000" & "1111100", --JNZ -4
		
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