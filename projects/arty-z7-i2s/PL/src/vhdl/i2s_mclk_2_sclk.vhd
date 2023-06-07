------------------------------------------------
-- i2s_mclk_2_sclk.vhd
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2s_mclk_2_sclk is
  generic
  (
    g_ratio : integer := 8
  );
  port
  (
    i_mclk : in std_logic;
    i_mclk_rst : in std_logic;
    o_sclk_ratioed : out std_logic
  );
end entity i2s_mclk_2_sclk;

architecture rtl of i2s_mclk_2_sclk is
  -- Signal declarations
  signal s_sclk_ratioed : std_logic:= '0';

begin

  -----------------------------------------
  -- p_mclk_2_sclk: process to generate
  -- sclk from mclk based on g_ratio
  -----------------------------------------
  p_mclk_2_sclk: process(i_mclk)
    variable v_counter : integer := 0;
  begin
    if rising_edge(i_mclk) then
      if i_mclk_rst = '1' then
        v_counter := 0;
        s_sclk_ratioed <= '0';
      else
        if (v_counter < ((g_ratio / 2) - 1)) then
          v_counter := v_counter + 1;
        else
          v_counter := 0;
          s_sclk_ratioed <= not s_sclk_ratioed;
        end if;
      end if;
    end if;
  end process p_mclk_2_sclk;

  -- Output assignments
  o_sclk_ratioed <= s_sclk_ratioed;


end architecture rtl;
