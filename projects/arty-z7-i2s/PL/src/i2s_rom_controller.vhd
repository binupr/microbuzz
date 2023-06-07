------------------------------------------------
-- i2s_rom_controller.vhd
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library work;
use work.i2s_pkg.all;

entity i2s_rom_controller is
  generic
  (
    g_data_width : integer := 16
  );
  port
  (
    i_mclk : in std_logic;
    i_mclk_rst : in std_logic;
    i_rom_data : in std_logic_vector(g_data_width-1 downto 0);
    i_ready  : in std_logic;
    o_rom_addr  : out std_logic_vector(6 downto 0);
    o_tx_data   : out std_logic_vector(((2*g_data_width) -1) downto 0)
  );
end entity i2s_rom_controller;

architecture rtl of i2s_rom_controller is
  -- Signal declarations
  signal s_i2srom_fsm : t_i2srom_fsm := t_i2srom_idle;
  signal s_rom_addr  : std_logic_vector(6 downto 0) := (others => '0'); -- need to address 100 locations
  signal s_tx_data   : std_logic_vector(((2*g_data_width) -1) downto 0) := (others => '0');

begin

  -----------------------------------------
  -- p_i2srom_fsm: process with FSM
  -- to control the ROM address and data
  -----------------------------------------
  p_i2srom_fsm: process(i_mclk)
    variable v_word_count : integer := 0;
  begin
    if rising_edge(i_mclk) then
      if i_mclk_rst = '1' then
        v_word_count := 0;
        s_i2srom_fsm <= t_i2srom_idle;
      else
        case s_i2srom_fsm is
          when t_i2srom_idle =>
            v_word_count := 0;
            s_i2srom_fsm <= t_i2srom_wait_for_ready;
          when t_i2srom_wait_for_ready =>
            if i_ready = '1' then
              s_i2srom_fsm <= t_i2srom_wait_for_start;
            end if;
          when t_i2srom_wait_for_start =>
            s_rom_addr <= std_logic_vector(to_unsigned(v_word_count, s_rom_addr'length));
            s_tx_data <= x"0000" & i_rom_data;
            if i_ready ='0' then
              s_i2srom_fsm <= t_i2srom_incr_addr;
            end if;
          when t_i2srom_incr_addr =>
            if v_word_count < 99 then
              v_word_count := v_word_count + 1;
            else
              v_word_count := 0;
            end if;
            s_i2srom_fsm <= t_i2srom_wait_for_ready;
        end case;
      end if;
    end if;
  end process p_i2srom_fsm;

  -- Output assignments
  o_rom_addr <= s_rom_addr;
  o_tx_data  <= s_tx_data;


end architecture rtl;
