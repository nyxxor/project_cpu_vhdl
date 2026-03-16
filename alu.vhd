
-- ============================================================
-- ALU - Arithmetic Logic Unit
-- Implements 16 operations selected by S_ALU
-- Based on laboratory specification diagram
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
port(
    BB : in  signed(15 downto 0);
    BC : in  signed(15 downto 0);
    S_ALU : in std_logic_vector(3 downto 0);
    clk : in std_logic;

    Y : out signed(15 downto 0);
    C : out std_logic;
    Z : out std_logic;
    S : out std_logic
);
end ALU;

architecture rtl of ALU is
signal result : signed(16 downto 0);
begin

process(BB,BC,S_ALU)
begin
    case S_ALU is

        when "0000" => result <= resize(BB,17);
        when "0001" => result <= resize(BC,17);

        when "0010" => result <= resize(BB,17) + resize(BC,17);
        when "0011" => result <= resize(BB,17) - resize(BC,17);

        when "0100" => result <= resize(BB or BC,17);
        when "0101" => result <= resize(BB and BC,17);

        when "0110" => result <= resize(BB xor BC,17);
        when "0111" => result <= resize(not(BB xor BC),17);

        when "1000" => result <= resize(not BB,17);
        when "1001" => result <= resize(-BB,17);

        when "1010" => result <= (others=>'0');

        when "1011" => result <= resize(BB + BC + 1,17);
        when "1100" => result <= resize(BB - BC - 1,17);

        when "1101" => result <= resize(BB + 1,17);

        when "1110" => result <= resize(shift_left(BB,1),17);
        when "1111" => result <= resize(shift_right(BB,1),17);

        when others => result <= (others=>'0');

    end case;
end process;

Y <= result(15 downto 0);
C <= result(16);
Z <= '1' when result(15 downto 0)=0 else '0';
S <= result(15);

end rtl;
