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
			regSrc: out unsigned (2 downto 0);
			regDest: out unsigned (2 downto 0);
			const: out unsigned (6 downto 0);
			jump_enable, bank_wrEnable, immediate: out std_logic
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

	component bank_and_ula
		port(
			regA,regB,regDest : in unsigned(2 downto 0);
			wrEnable,reset,clk,immediate : in std_logic;
			operation : in unsigned(3 downto 0);
			dataOut : out unsigned(15 downto 0);
			extConst : in unsigned(15 downto 0)
		);
	end component;

    signal pc_to_adder, adder_to_mux, mux_to_pc, const: unsigned (6 downto 0);
	signal extConst: unsigned (15 downto 0);
    signal rom_to_reg, reg_to_decoder: unsigned (13 downto 0);
    signal opcode: unsigned (3 downto 0);
    signal jump_enable, pc_wrEnable, bank_wrEnableDec, instReg_wrEnable, bank_wrEnable, immediate: std_logic;
	signal regSrc, regDest: unsigned (2 downto 0);
	signal state : unsigned (1 downto 0);

	begin
		dec1 : decoder port map(
			instruction => reg_to_decoder,
			jump_enable => jump_enable,
			const => const,
			bank_wrEnable => bank_wrEnableDec,
			regSrc => regSrc,
			regDest => regDest,
			immediate => immediate,
			opcode => opcode
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
            data_B => const,
            data_out => mux_to_pc
        );

        regInstruction: reg14bits port map(
            clk => clk,
            reset => reset,
            wrEnable => instReg_wrEnable,
            dIn => rom_to_reg,
            dOut => reg_to_decoder
        );

		core1: bank_and_ula port map(
			clk => clk,
			reset => reset,
			immediate => immediate,
			extConst => extConst,
			wrEnable => bank_wrEnable,
			regA => regDest,
			regB => regSrc,
			regDest => regDest,
			operation => opcode
		);
		
		pc_wrEnable <= '1' when state = "10" else '0';
		instReg_wrEnable <= '1' when state = "01" else '0';
		bank_wrEnable <= '1' when state = "10" and bank_wrEnableDec = '1' else '0';
		extConst <= "000000000" & const;
	
end architecture;