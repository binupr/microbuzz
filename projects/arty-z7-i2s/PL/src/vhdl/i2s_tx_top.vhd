------------------------------------------------
-- i2s_tx_top.vhd
-- Top level entity of the i2s project
-- instantiates the below
-- 1. i2s_tx
-- 2. rom
-- 3. rom controller
-- 4. clock generator
------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library xil_defaultlib;
use xil_defaultlib.all;

library work;
use work.all;

entity i2s_tx_top is
  generic
  (
    g_ratio : integer := 8;
    g_data_width : integer := 16
  );
  port
  (
    i_sys_clk : in std_logic;
    i_sys_rst : in std_logic;
    -- CS4344 I2S interface --begin
    o_mclk   : out std_logic;
    o_lrclk  : out std_logic;
    o_sclk   : out std_logic;
    o_sd     : out std_logic;
    -- CS4344 I2S interface --end
    o_led    : out std_logic_vector(3 downto 0)
  );
end entity i2s_tx_top;

architecture struct of i2s_tx_top is

  -- IP component declarations
  component clk_wiz_0
    port (
    reset : in std_logic;
    clk_in1 : in std_logic;
    locked : out std_logic;
    clk_out1: out std_logic
    );
  end component;

  component i2s_rom
    port (
    clka : in std_logic;
    ena : in std_logic;
    addra : in std_logic_vector(6 downto 0);
    douta : out std_logic_vector(15 downto 0)
  );
  end component;

  -- Signal declarations
  signal s_mmcm_locked : std_logic :='0';
  signal s_mclk : std_logic :='0';
  signal s_lrclk : std_logic :='0';
  signal s_sclk_ratioed : std_logic:= '0';
  signal s_sclk : std_logic :='0';
  signal s_mclk_rst : std_logic :='0'; -- Synchronous reset wrt mclk
  signal s_tx_data : std_logic_vector(((2*g_data_width) -1) downto 0);
  signal s_rom_data : std_logic_vector(g_data_width-1 downto 0);
  signal s_ready : std_logic := '0';
  signal s_rom_addr : std_logic_vector(6 downto 0);
  signal s_sd : std_logic := '0';

begin
  -- -----------------------------------------
  -- clock wizard instantiation
  -- -----------------------------------------
  i_mmcm: clk_wiz_0
    port map (
      reset => i_sys_rst,
      clk_in1 => i_sys_clk,
      locked => s_mmcm_locked,
      clk_out1 => s_mclk
    );

  -- -----------------------------------------
  -- mclk to sclk instantiation
  -- -----------------------------------------
  i_i2s_mclk_2_sclk: entity work.i2s_mclk_2_sclk 
    generic map
    (
      g_ratio => g_ratio
    )
    port map
    (
      i_mclk => s_mclk,
      i_mclk_rst => s_mclk_rst,
      o_sclk_ratioed => s_sclk_ratioed
    );

  -- -------------------------------------------
  -- -- i2s transmitter block instantiation
  -------------------------------------------
  i_i2s_tx: entity work.i2s_tx
    generic map (
      g_data_width => g_data_width
    )
    port map (
      i_sclk_ratioed => s_sclk_ratioed,
      i_mclk_rst => s_mclk_rst,
      i_tx_data => s_tx_data,
      o_ready  => s_ready,
      o_lrclk  => s_lrclk,
      o_sclk   => s_sclk,
      o_sd     => s_sd
    );

  -------------------------------------------
  -- i2s rom controller block instantiation
  -------------------------------------------
  i_i2s_rom_controller: entity work.i2s_rom_controller
    generic map (
      g_data_width => g_data_width
    )
    port map (
      i_mclk     => s_mclk,
      i_mclk_rst  => s_mclk_rst,
      i_rom_data => s_rom_data,
      i_ready    => s_ready,
      o_rom_addr => s_rom_addr,
      o_tx_data  => s_tx_data
    );

  -------------------------------------------
  -- i2s rom block instantiation
  ---------------------------------------------
  i_i2s_rom: i2s_rom
    port map (
      clka => s_mclk,
      ena  => std_logic'('1'),
      addra => s_rom_addr,
      douta => s_rom_data
    );

  -- Concurrent/output assignments
  s_mclk_rst <= not s_mmcm_locked;
  o_mclk <= s_mclk;
  o_lrclk <= s_lrclk;
  o_sclk <= s_sclk;
  o_sd <= s_sd;

  -- Debug code
  o_led(3) <= s_lrclk;
  o_led(2) <= s_sd;
  o_led(1) <= s_mclk_rst;
  o_led(0) <= s_mmcm_locked;

end architecture struct;