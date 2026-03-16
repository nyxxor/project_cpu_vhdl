
-- ============================================================
-- Register File
-- Contains general purpose registers A,B,C,D,E,F
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
port(
    clk : in std_logic;

    DI : in signed(15 downto 0);

    Sba : in std_logic_vector(2 downto 0);
    Sbb : in std_logic_vector(2 downto 0);
    Sbc : in std_logic_vector(2 downto 0);

    BB : out signed(15 downto 0);
    BC : out signed(15 downto 0)
);
end;

architecture rtl of register_file is

type reg_array is array(0 to 5) of signed(15 downto 0);
signal R : reg_array := (others => (others=>'0'));

begin

-- write port
process(clk)
begin
if rising_edge(clk) then
    case Sba is
        when "000" => R(0) <= DI;
        when "001" => R(1) <= DI;
        when "010" => R(2) <= DI;
        when "011" => R(3) <= DI;
        when "100" => R(4) <= DI;
        when "101" => R(5) <= DI;
        when others => null;
    end case;
end if;
end process;

-- read ports
BB <= R(to_integer(unsigned(Sbb)));
BC <= R(to_integer(unsigned(Sbc)));

end rtl;
