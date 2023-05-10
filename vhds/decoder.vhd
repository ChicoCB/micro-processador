library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
    port(
        instruction: in unsigned (13 downto 0);
        opcode: out unsigned (3 downto 0);
        regA: out unsigned (2 downto 0);
        regB: out unsigned (2 downto 0);
        address, const: out unsigned (6 downto 0);
        jump_enable, bank_wrEnable: out std_logic
    );
end entity;

architecture decoder_arch of decoder is

    begin
        jump_enable <= '1' when instruction(13 downto 10) = "1111" else
        '0';
        
        bank_wrEnable <= '0' when instruction(13 downto 10) = "1111" else
        '1';

        opcode <= instruction(13 downto 10);
        regA <= instruction(9 downto 7);
        regB <= instruction(6 downto 4);

        const <= instruction(6 downto 0);
        address <= instruction(6 downto 0);

end architecture;