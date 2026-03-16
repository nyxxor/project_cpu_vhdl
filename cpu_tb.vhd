
library ieee;
use ieee.std_logic_1164.all;

entity cpu_tb is
end;

architecture sim of cpu_tb is

signal clk : std_logic := '0';
signal reset : std_logic := '0';

component cpu_top
port(
    clk : in std_logic;
    reset : in std_logic
);
end component;

begin

UUT : cpu_top port map(clk,reset);

clk_process : process
begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
end process;

stim : process
begin

reset <= '1';
wait for 50 ns;

reset <= '0';

wait for 500 ns;

wait;

end process;

end sim;
