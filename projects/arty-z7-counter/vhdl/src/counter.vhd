library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
  port (clk : in std_logic;
        rst : in std_logic;
        count : out std_logic_vector(63 downto 0));
end entity counter;

architecture rtl of counter is
  signal count_temp : std_logic_vector(63 downto 0) := (others => '0');
begin
  p_count: process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        count_temp <= (others => '0');
      else
        count_temp <= count_temp + 1;
      end if;
    end if;
  end process p_count;

  -- Drive output
  count <= count_temp;

end architecture rtl;