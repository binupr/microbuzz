----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/28/2021 10:33:51 PM
-- Design Name: 
-- Module Name: i2s_tx_top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.all;

entity i2s_tx_top_tb is
--  Port ( );
end i2s_tx_top_tb;

architecture Behavioral of i2s_tx_top_tb is

  constant c_clk_period : time := 10 ns; -- 100 MHz clock
  signal s_sys_clk : std_logic := '0';
  signal s_sys_rst : std_logic := '0';
  signal s_mclk, s_lrclk, s_sclk : std_logic;
  signal s_sd : std_logic;
  signal s_led : std_logic_vector(1 downto 0);
  

begin
  
  i_dut: entity work.i2s_tx_top
    port map (
      i_sys_clk => s_sys_clk,
      i_sys_rst => s_sys_rst,
      o_mclk => s_mclk,
      o_lrclk => s_lrclk,
      o_sclk => s_sclk,
      o_sd => s_sd,
      o_led => s_led
    );

  -- Generating testbench clock
  p_clk_tb :process
  begin
    s_sys_clk <= '0';
    wait for c_clk_period/2;
    s_sys_clk <= '1';
    wait for c_clk_period/2;
  end process;

  s_sys_rst <= '1', '0' after 200 ns;

end Behavioral;
