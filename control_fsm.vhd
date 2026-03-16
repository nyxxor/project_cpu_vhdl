
-- ============================================================
-- Control Unit FSM
-- Implements FETCH - DECODE - EXECUTE cycle
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_fsm is
port(
    clk : in std_logic;
    reset : in std_logic;

    IR : in std_logic_vector(15 downto 0);

    S_ALU : out std_logic_vector(3 downto 0);
    state_out : out std_logic_vector(2 downto 0)
);
end;

architecture rtl of control_fsm is

type state_type is (FETCH, DECODE, EXECUTE);
signal state : state_type;

signal opcode : std_logic_vector(4 downto 0);

begin

opcode <= IR(15 downto 11);

process(clk,reset)
begin

if reset='1' then
    state <= FETCH;

elsif rising_edge(clk) then

    case state is

        when FETCH =>
            state <= DECODE;

        when DECODE =>
            state <= EXECUTE;

        when EXECUTE =>
            state <= FETCH;

    end case;

end if;

end process;

-- ALU control decode
process(opcode)
begin

case opcode is

    when "00010" => S_ALU <= "0010";
    when "00011" => S_ALU <= "0011";
    when "00100" => S_ALU <= "1101";
    when "00101" => S_ALU <= "1100";
    when "00110" => S_ALU <= "1001";

    when "00111" => S_ALU <= "0101";
    when "01000" => S_ALU <= "0100";

    when "01001" => S_ALU <= "0110";
    when "01010" => S_ALU <= "0111";

    when "01011" => S_ALU <= "1000";

    when "01100" => S_ALU <= "1110";
    when "01101" => S_ALU <= "1111";

    when others => S_ALU <= "0000";

end case;

end process;

state_out <= "000" when state=FETCH else
             "001" when state=DECODE else
             "010";

end rtl;
