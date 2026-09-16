-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk      : in  std_logic; --50mhz
    reset    : in  std_logic;
    HEX0     : out std_logic_vector(6 downto 0)
	);
end entity top;

architecture beh of top is

-- Component 1: Generic Counter 
component generic_counter is
  generic (
    max_count       : integer := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;  

-- Component 2: Generic Adder 
component generic_adder_beh is 
	generic(
		bits : integer := 4
	);
	port(
		a    : in std_logic_vector(bits-1 downto 0);
		b    : in std_logic_vector(bits-1 downto 0);
		cin  : in std_logic;
		sum  : out std_logic_vector(bits-1 downto 0);
		cout : out std_logic
	);
end component;

-- Component 3: seven_seg 
component seven_seg is 
	port(
		bcd : in std_logic_vector(3 downto 0);
		hex : out std_logic_vector(6 downto 0)
	);
end component;

signal enable_sig   : std_logic;
signal next_sum     : std_logic_vector(3 downto 0);
signal sum_sig      : std_logic_vector(3 downto 0);
signal sum_register : std_logic_vector(3 downto 0);
signal cout_sig     : std_logic;

begin
-- UUT Generic Counter
uut: generic_counter
	generic map(
		max_count =>  3 --50000000 -- for 1Hz
		)
	port map(
		clk => clk,
		reset => reset,
		output => enable_sig
		);

-- UUT Generic Adder
uut2: generic_adder_beh
	generic map(
		bits => 4
	)
	port map(
		a    => sum_register, -- The current count value
		b    => "0001",       -- +1 constant
		cin  => '0',
		sum  => next_sum,          -- sum_register + 1
		cout => cout_sig
	);
--Register 
process(clk, reset)
begin
	if reset = '1' then
		sum_sig <= "0000";
	elsif rising_edge(clk) then 
		if enable_sig = '1' then
			sum_sig <= next_sum;
		end if;
	end if;
end process;

-- UUT Seven Seg
uut3: seven_seg 
  port map(
    bcd => sum_register,
	hex => HEX0
  );
end architecture beh;