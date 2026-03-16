
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
port(
    clk : in std_logic;
    we  : in std_logic;
    addr : in integer range 0 to 255;
    data_in : in std_logic_vector(15 downto 0);
    data_out : out std_logic_vector(15 downto 0)
);
end;

architecture rtl of ram is

type mem_type is array(0 to 255) of std_logic_vector(15 downto 0);
signal memory : mem_type := (others => (others=>'0'));

begin

process(clk)
begin
if rising_edge(clk) then

    if we='1' then
        memory(addr) <= data_in;
    end if;

    data_out <= memory(addr);

end if;
end process;

end rtl;
