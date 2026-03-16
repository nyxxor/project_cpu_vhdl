
-- ============================================================
-- CPU TOP MODULE
-- Connects ALU, Registers, RAM and Control Unit
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu_top is
port(
    clk : in std_logic;
    reset : in std_logic
);
end;

architecture struct of cpu_top is

signal BB,BC,Y : signed(15 downto 0);
signal S_ALU : std_logic_vector(3 downto 0);

signal IR : std_logic_vector(15 downto 0) := (others=>'0');

component ALU
port(
BB : in signed(15 downto 0);
BC : in signed(15 downto 0);
S_ALU : in std_logic_vector(3 downto 0);
clk : in std_logic;
Y : out signed(15 downto 0);
C : out std_logic;
Z : out std_logic;
S : out std_logic
);
end component;

component register_file
port(
clk : in std_logic;
DI : in signed(15 downto 0);
Sba : in std_logic_vector(2 downto 0);
Sbb : in std_logic_vector(2 downto 0);
Sbc : in std_logic_vector(2 downto 0);
BB : out signed(15 downto 0);
BC : out signed(15 downto 0)
);
end component;

component control_fsm
port(
clk : in std_logic;
reset : in std_logic;
IR : in std_logic_vector(15 downto 0);
S_ALU : out std_logic_vector(3 downto 0);
state_out : out std_logic_vector(2 downto 0)
);
end component;

signal state_dbg : std_logic_vector(2 downto 0);

begin

U1: register_file port map(clk,Y,"000","000","001",BB,BC);

U2: ALU port map(BB,BC,S_ALU,clk,Y,open,open,open);

U3: control_fsm port map(clk,reset,IR,S_ALU,state_dbg);

end struct;
