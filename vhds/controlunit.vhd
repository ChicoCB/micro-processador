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
	component maq_estados
		port (
			clk,rst: in std_logic;
			estado: out unsigned(1 downto 0)
		);
	end component;
		
    component PC
        port(
            clk, wrenable, reset: in std_logic;
			data_in: in unsigned (6 downto 0);
			data_out: out unsigned (6 downto 0)
        );
    end component;

    component rom 
        port(
            clk: in std_logic;
            address: in unsigned (6 downto 0);
            data: out unsigned (13 downto 0)
        );
    end component;

    component mux7bits
        port(
            control: in std_logic;
            data_A: in unsigned (6 downto 0);
            data_B: in unsigned (6 downto 0);
            data_out: out unsigned (6 downto 0)
        );
    end component;

    component UnitAdder
        port(
            data_in: in unsigned (6 downto 0);
            data_out: out unsigned (6 downto 0)
        );
    end component;

    signal pc_to_adder, adder_to_mux, mux_to_pc, instruction_address: unsigned (6 downto 0);
    signal rom_out: unsigned (13 downto 0);
    signal opcode: unsigned (3 downto 0);
    signal jump_enable: std_logic;
	signal state : unsigned (1 downto 0);
	signal pc_wrEnable : std_logic;

    begin
        
        maq_estados1 : maq_estados port map(
			clk=>clk,
			rst=>reset,
			estado => state
		);

        rom1: rom port map(
            clk => clk,
            address => pc_to_adder,
            data => rom_out
        );

        pc1: PC port map(
            clk => clk,
            wrenable => pc_wrEnable,
            reset => reset,
            data_in => mux_to_pc,
            data_out => pc_to_adder
        );

        unit: UnitAdder port map(
            data_in => pc_to_adder,
            data_out => adder_to_mux
        );

        mux: mux7bits port map(
            control => jump_enable,
            data_A => adder_to_mux,
            data_B => instruction_address,
            data_out => mux_to_pc
        );

        data_out <= rom_out;

        opcode <= rom_out (13 downto 10);
		
		pc_wrEnable <= '1' when state = "10" else '0';

        jump_enable <= '1' when opcode = "1111" else
        '0';

        instruction_address <= rom_out (6 downto 0);

end architecture;