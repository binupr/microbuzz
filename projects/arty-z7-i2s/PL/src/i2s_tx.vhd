------------------------------------------------
-- i2s_tx.vhd
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.i2s_pkg.all;


entity i2s_tx is
  generic
  (
    g_data_width : integer := 16
  );
  port
  (
    i_sclk_ratioed : in std_logic;
    i_mclk_rst : in std_logic;
    i_tx_data : in std_logic_vector(((2*g_data_width) -1) downto 0);
    o_ready  : out std_logic;
    o_lrclk  : out std_logic;
    o_sclk   : out std_logic;
    o_sd     : out std_logic
  );
end entity i2s_tx;

architecture rtl of i2s_tx is

  -- Signal declarations
  signal s_i2stx_fsm : t_i2stx_fsm := t_i2stx_idle;
  signal s_ready : std_logic := '0';
  signal s_lrclk : std_logic :='1';
  signal s_enable : std_logic := '0';
  signal s_sclk : std_logic :='0';
  signal s_tx_buffer : std_logic_vector(((2*g_data_width) -1) downto 0);
  signal s_sd : std_logic := '0';

begin

  -----------------------------------------
  -- p_i2stx_fsm: process with FSM
  -- to send tx data serially out of the PL
  -----------------------------------------
  p_i2stx_fsm: process(i_sclk_ratioed)
    variable v_bit_counter : integer := 0;
  begin
    if falling_edge(i_sclk_ratioed) then
      if i_mclk_rst = '1' then
        s_i2stx_fsm <= t_i2stx_idle;
        s_ready <= '0';
        s_lrclk <= '1';
        s_enable <= '1';
        s_tx_buffer <= (others => '0');
        s_sd <= '0';
      else
        case s_i2stx_fsm is
          when t_i2stx_idle =>
            s_i2stx_fsm <= t_i2stx_load_buffer;
            s_ready <= '0';
            s_lrclk <= '1';
            s_enable <= '1';
            s_tx_buffer <= (others => '0');
            s_sd <= '0';
          when t_i2stx_load_buffer =>
            v_bit_counter := 0;
            s_i2stx_fsm <= t_i2stx_serialise_n_send;
            s_lrclk <= '0';
            s_tx_buffer <= i_tx_data;
            s_sd <= '0';
          when t_i2stx_serialise_n_send =>
            v_bit_counter := v_bit_counter + 1;
            if v_bit_counter > (g_data_width - 1) then
              s_lrclk <= '1';
            end if;
            if v_bit_counter <((2 * g_data_width) - 1) then
              s_ready <= '0';
            else
              s_ready <= '1';
              s_i2stx_fsm <= t_i2stx_load_buffer;
            end if;
            s_tx_buffer <= s_tx_buffer(((2 * g_data_width) -2) downto 0) & "0";
            s_sd <= s_tx_buffer((2*g_data_width)-1);
        end case;
      end if;
    end if;
  end process p_i2stx_fsm;

-- Concurrent/output assignments
o_ready <= s_ready;
o_lrclk <= s_lrclk;
o_sclk <= i_sclk_ratioed and s_enable;
o_sd <= s_sd;

end architecture rtl;
