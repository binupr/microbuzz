library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package i2s_pkg is
  -- i2s outputs from FPGA
  type t_to_cs4344 is record
    mclk : std_logic;
    lrclk : std_logic;
    sclk : std_logic;
    sd : std_logic;
  end record t_to_cs4344;
  -- FSM type
  type t_i2stx_fsm is (t_i2stx_idle, t_i2stx_load_buffer, t_i2stx_serialise_n_send);
  type t_i2srom_fsm is (t_i2srom_idle, t_i2srom_wait_for_ready, t_i2srom_wait_for_start, t_i2srom_incr_addr);

end package i2s_pkg;

package body i2s_pkg is
end package body i2s_pkg;
