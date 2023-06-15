library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
    port(
        instruction: in unsigned (13 downto 0);
        opcode: out unsigned (3 downto 0);
        regSrc: out unsigned (2 downto 0);
        regDest, readAdr, regA: out unsigned (2 downto 0);
        const: out unsigned (6 downto 0); 
        jump_enable_JMP,jump_enable_Z, bank_wrEnable, immediate, ram_wrEnable, ram_or_ula: out std_logic
    );
end entity;

architecture decoder_arch of decoder is

    begin
        jump_enable_JMP <= '1' when instruction(13 downto 10) = "1111" else
        '0';
		
		jump_enable_Z <= '1' when instruction(13 downto 10) = "1110" else
		'0';
        
        bank_wrEnable <= '0' when instruction(13 downto 10) = "1111" or instruction(13 downto 10) = "1001" else
        '1';

        immediate <= '1' when instruction(13 downto 10) = "0001" or instruction(13 downto 10) = "0011" or instruction(13 downto 10) = "0111" else 
        '0';

		ram_wrEnable <= '1' when instruction(13 downto 10) = "1001" else
		'0';
		
		--0: ula, 1:ram
		ram_or_ula <= '1' when instruction(13 downto 10) = "1000" else
		'0';

        opcode <= instruction(13 downto 10);
        regDest <= instruction(6 downto 4) when instruction(13 downto 10) = "1000" else instruction(9 downto 7);
		
		readAdr <= instruction(9 downto 7);
		
		regA <= instruction(9 downto 7) when instruction(13 downto 10) = "1000" else instruction(9 downto 7);
		
        regSrc <= instruction(6 downto 4);
        const <= instruction(6 downto 0);

end architecture;