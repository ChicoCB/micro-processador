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
        
		-- CARREGA A RAM
		0 => "0111" & "010" & "0000000", --MOV R2,0
		1 => "0111" & "011" & "0100001", --MOV R3,33
        2 => "1001" & "010" & "010" & "0000", --MOV @R2,R2
        3 => "0100" & "010" & "0000000", --INC R2
        4 => "1100" & "010" & "011" & "1110", --CJNE R2,R3,-2
		
		--EXCLUI OS NÃO PRIMOS
		5 => "0111" & "010" & "0000010", 			--MOV R2,2
		6 => "0110" & "001" & "010" & "0000", 		--MOV A,R2
		7 => "0000" & "001" & "010" & "0000",		--ADD A,R2
		8 => "1101" & "000" & "0000100", 			--JC 4
		9 => "1001" & "001" & "000" & "0000", 		--MOV @A,R0
		10 => "0000" & "001" & "010" & "0000", 		--ADD A,R2
		11 => "1100" & "011" & "001" & "1101",		--CJNE R3,A,-3
		12 => "0100" & "010" & "0000000", 			--INC R2
		13 => "1100" & "011" & "010" & "1001", 		--CJNE R3,R2,-7
		
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