library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
    port(
        instruction: in unsigned (13 downto 0);
        opcode: out unsigned (3 downto 0);
        regSrc: out unsigned (2 downto 0);
        regDest: out unsigned (2 downto 0);
        const: out unsigned (6 downto 0);
        jump_enable, bank_wrEnable, immediate: out std_logic
    );
end entity;

architecture decoder_arch of decoder is

    begin
        jump_enable <= '1' when instruction(13 downto 10) = "1111" else
        '0';
        
        bank_wrEnable <= '0' when instruction(13 downto 10) = "1111" else
        '1';

        immediate <= '1' when instruction(13 downto 10) = "0001" or instruction(13 downto 10) = "0011" or instruction(13 downto 10) = "0111" else 
        '0';


        opcode <= instruction(13 downto 10);
        regDest <= instruction(9 downto 7);
        regSrc <= instruction(6 downto 4);
        const <= instruction(6 downto 0);

end architecture;