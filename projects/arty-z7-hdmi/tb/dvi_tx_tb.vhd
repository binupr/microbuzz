LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dvi_tx_tb IS
END dvi_tx_tb;

ARCHITECTURE testbench OF dvi_tx_tb IS
    -- Signals
    SIGNAL clk   : std_logic := '0';
    SIGNAL rst   : std_logic := '1';

    -- DUT Component Declaration
    COMPONENT dvi_tx
        PORT (
            clk_i         : IN  std_logic;
            rst_i         : IN  std_logic;
            dvi_clk_p_o   : OUT std_logic;
            dvi_clk_n_o   : OUT std_logic;
            dvi_tx0_p_o   : OUT std_logic;
            dvi_tx0_n_o   : OUT std_logic;
            dvi_tx1_p_o   : OUT std_logic;
            dvi_tx1_n_o   : OUT std_logic;
            dvi_tx2_p_o   : OUT std_logic;
            dvi_tx2_n_o   : OUT std_logic
        );
    END COMPONENT;

BEGIN
    -- Clock generation: 125 MHz (8 ns period)
    clk_process : PROCESS
    BEGIN
        WAIT FOR 4 ns;
        clk <= NOT clk;
    END PROCESS;

    -- DUT instantiation
    dut : dvi_tx
        PORT MAP (
            clk_i         => clk,
            rst_i         => rst,
            dvi_clk_p_o   => OPEN,
            dvi_clk_n_o   => OPEN,
            dvi_tx0_p_o   => OPEN,
            dvi_tx0_n_o   => OPEN,
            dvi_tx1_p_o   => OPEN,
            dvi_tx1_n_o   => OPEN,
            dvi_tx2_p_o   => OPEN,
            dvi_tx2_n_o   => OPEN
        );

    -- Reset sequence
    stimulus : PROCESS
    BEGIN
        -- Hold reset for 20 ns, then release
        WAIT FOR 20 ns;
        rst <= '0';

        -- Run simulation for 500 ns
        WAIT FOR 500 ns;
        -- Stop simulation
        REPORT "Simulation Complete" SEVERITY NOTE;
        WAIT;
    END PROCESS;

END ARCHITECTURE testbench;
