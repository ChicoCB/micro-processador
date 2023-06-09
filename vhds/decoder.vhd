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
		const4bits: out unsigned (3 downto 0);
        jump_enable_JMP,jump_enable_Z, jump_enable_C, jump_enable_CNJZ, bank_wrEnable, immediate, ram_wrEnable, ram_or_ula, wrFlagZEnable, wrFlagCEnable: out std_logic
    );
end entity;

architecture decoder_arch of decoder is

	signal constCNJE : unsigned (6 downto 0);

    begin
	
        jump_enable_JMP <= '1' when instruction(13 downto 10) = "1111" else
        '0';
		
		jump_enable_Z <= '1' when instruction(13 downto 10) = "1110" else
		'0';
		
		jump_enable_C <= '1' when instruction(13 downto 10) = "1101" else
		'0';
        
		jump_enable_CNJZ <= '1' when instruction(13 downto 10) = "1100" else
		'0';
		
        bank_wrEnable <= '0' when instruction(13 downto 10) = "1111" or instruction(13 downto 10) = "1001" or instruction(13 downto 10) = "1100" else
        '1';

        immediate <= '1' when instruction(13 downto 10) = "0001" or instruction(13 downto 10) = "0011" or instruction(13 downto 10) = "0111" else 
        '0';

		ram_wrEnable <= '1' when instruction(13 downto 10) = "1001" else
		'0';
		
		--0: ula, 1:ram
		ram_or_ula <= '1' when instruction(13 downto 10) = "1000" else
		'0';

        wrFlagZEnable <= '1' when instruction(13 downto 10) = "0000" or instruction(13 downto 10) = "0001" or instruction(13 downto 10) = "0010"
        or instruction(13 downto 10) = "011" else
        '0';
		
		wrFlagCEnable <= '1' when instruction(13 downto 10) = "1100" else '0';

        opcode <= instruction(13 downto 10);
        regDest <= instruction(6 downto 4) when instruction(13 downto 10) = "1000" else instruction(9 downto 7);
		
		readAdr <= instruction(9 downto 7);
		
		regA <= instruction(9 downto 7) when instruction(13 downto 10) = "1000" else instruction(9 downto 7);
		
        regSrc <= instruction(6 downto 4);
		
		constCNJE <= ("111" & instruction(3 downto 0)) when instruction(3) = '1' else ("000" & instruction(3 downto 0));
		
        const <= constCNJE when instruction(13 downto 10) = "1100" else instruction(6 downto 0);

end architecture;