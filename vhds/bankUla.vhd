library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bankUla is
    port(
        extConst: in unsigned (15 downto 0);
        ulaOut: out unsigned (15 downto 0);
        operation: in unsigned (1 downto 0);
        wrEnable, clk, reset, muxControl: in std_logic;
        regA, regB, regDest: in unsigned (2 downto 0)
    );
end entity;

architecture bankUla_arch of bankUla is
    component ULA
        port (
            A : in unsigned(15 downto 0);
            B : in unsigned(15 downto 0);
            C : in unsigned(1 downto 0);
            S : out unsigned(15 downto 0)
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

    component MUX_2x1
        port (
            E0,E1 : in unsigned(15 downto 0);
            C : in std_logic;
            S : out unsigned(15 downto 0)
        );
    end component;

    signal dataReturn, ulaInA, ulaInB, muxInA: unsigned (15 downto 0);

    begin
        ula1: ULA port map(
            S => dataReturn,
            A => ulaInA,
            C => operation,
            B => ulaInB
        );

        bank: bancoDeRegs port map(
            wrEnable => wrEnable,
            wrData => dataReturn,
            dataA => ulaInA,
            dataB => muxInA,
            clk => clk,
            reset => reset,
            regA => regA,
            regB => regB,
            regDest => regDest
        );

        mux: MUX_2x1 port map(
            C => muxControl,
            E0 => muxInA,
            E1 => extConst,
            S => ulaInB
        );

        ulaOut <= dataReturn;
    
end architecture;