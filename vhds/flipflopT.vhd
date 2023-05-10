library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipflopT is
    port(
        Toggle: in std_logic;
        data_out: out std_logic;
        clk: in std_logic;
        reset: in std_logic
    );
end entity;

architecture flipflopT_arch of flipflopT is
	signal registro : std_logic;
    begin
        process(clk, reset)
		begin
            if(reset = '1') then
                registro <= '0';
            elsif(rising_edge(clk)) then
                if(Toggle = '1') then
                    registro <=  not registro;
                end if;
            end if;
        end process;

	data_out <= registro;
        
end architecture;