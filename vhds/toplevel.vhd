library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
	port (
		clk, reset: in std_logic
	);
end entity;

architecture toplevel_arch of toplevel is
	component decoder
		port(
			instruction: in unsigned (13 downto 0);
			opcode: out unsigned (3 downto 0);
			regA: out unsigned (2 downto 0);
			regB: out unsigned (2 downto 0);
			address, const: out unsigned (6 downto 0);
			jump_enable, bank_wrEnable: out std_logic
		);
	end component;

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

    component reg14bits
        port(
            clk : in std_logic;
            reset : in std_logic;
            wrEnable : in std_logic;
            dIn : in unsigned(13 downto 0);
            dOut : out unsigned(13 downto 0)
        );
    end component;

	component bancoDeRegs
		port(
			wrEnable: in std_logic;
			clk: in std_logic;
			reset: in std_logic;
			regA, regB, regDest: in unsigned (2 downto 0);
			dataA, dataB : out unsigned(15 downto 0);
			wrData : in unsigned(15 downto 0)
			);
	end component;

    signal pc_to_adder, adder_to_mux, mux_to_pc, jump_address: unsigned (6 downto 0);
    signal rom_to_reg, reg_to_decoder: unsigned (13 downto 0);
    signal opcode: unsigned (3 downto 0);
    signal jump_enable, pc_wrEnable, instReg_wrEnable: std_logic;
	signal state : unsigned (1 downto 0);

	begin
		dec1 : decoder port map(
			instruction => reg_to_decoder,
			jump_enable => jump_enable,
			address => jump_address
		);

		maq_estados1 : maq_estados port map(
			clk=>clk,
			rst=>reset,
			estado => state
		);

        rom1: rom port map(
            clk => clk,
            address => pc_to_adder,
            data => rom_to_reg
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
            data_B => jump_address,
            data_out => mux_to_pc
        );

        regInstruction: reg14bits port map(
            clk => clk,
            reset => reset,
            wrEnable => instReg_wrEnable,
            dIn => rom_to_reg,
            dOut => reg_to_decoder
        );
		
		pc_wrEnable <= '1' when state = "10" else '0';
	
end architecture;