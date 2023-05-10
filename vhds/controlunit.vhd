library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
    port(
        clk, reset: in std_logic;
        data_out: out unsigned (13 downto 0)
    );
end entity;

architecture ControlUnit_arch of ControlUnit is
    component PCounter
        port(
            clk, wrenable, reset: in std_logic;
            data_out: out unsigned (11 downto 0)
        );
    end component;

    component flipflopT
        port(
            data_in: in std_logic;
            data_out: out std_logic;
            clk: in std_logic;
            reset: in std_logic
        );
    end component;

    component rom 
        port(
            clk: in std_logic;
            address: in unsigned (11 downto 0);
            data: out unsigned (13 downto 0)
        );
    end component;

    component mux12bits
        port(
            control: in std_logic;
            data_A: in unsigned (11 downto 0);
            data_B: in unsigned (11 downto 0);
            data_out: out unsigned (11 downto 0)
        );
    end component;

    component flipflopD12bits
        port(
            clk, wrenable, reset: in std_logic;
            data_in: in unsigned (11 downto 0);
            data_out: out unsigned (11 downto 0)
        );
    end component;

    component UnitAdder
        port(
            data_in: in unsigned (11 downto 0);
            data_out: out unsigned (11 downto 0)
        );
    end component;

    signal ffD_to_adder, adder_to_mux, mux_to_ffD, instruction_address: unsigned (11 downto 0);
    signal rom_out: unsigned (13 downto 0);
    signal opcode: unsigned (11 downto 10);
    signal state, jump_enable: std_logic;

    begin
        
        ffT: flipflopT port map(
            clk => clk,
            reset => reset,
            data_in => '1',
            data_out => state
        );

        rom1: rom port map(
            clk => clk,
            address => ffD_to_adder,
            data => rom_out
        );

        ffD: flipflopD12bits port map(
            clk => clk,
            wrenable => state,
            reset => reset,
            data_in => mux_to_ffD,
            data_out => ffD_to_adder
        );

        unit: UnitAdder port map(
            data_in => ffD_to_adder,
            data_out => adder_to_mux
        );

        mux: mux12bits port map(
            control => jump_enable,
            data_A => adder_to_mux,
            data_B => instruction_address,
            data_out => mux_to_ffD
        );

        data_out <= rom_out;

        opcode <= rom_out (13 downto 12);

        jump_enable <= '1' when opcode = "11" else
        '0';

        instruction_address <= rom_out (11 downto 0);

end architecture;