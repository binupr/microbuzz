library ieee;
use ieee.std_logic_1164.all;

library binulib;

entity tb_counter is
end tb_counter;

architecture behav of tb_counter is
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
begin
  -- Instantiate DUT
  counter_inst: entity binulib.counter port map (clk   => clk,
                                rst   => rst,
                                count => open);
                              
  -- Generate clock with 100 MHz frequency
  p_clock: process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;

  -- Drive stimulus to DUT
  p_stimulus: process
  begin
    -- Reset is initialised to 1 with declaration
    -- De-assert reset for a little while, before asserting and de-asserting later
    wait for 20 ns;
    rst <= '0';
    wait for 80 ns;
    rst <= '1';
    wait for 50 ns;
    rst <= '0';
    -- Finish stimulus after 200 ns (i.e. another 50 ns)
    wait for 50 ns;
    wait;
  end process;

end behav;