--------------------------------------------------------------------------
-- Britney Guillen
-- add_sub
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity add_sub is 
	port(
		clk          : in  std_logic;
		reset        : in  std_logic;
		sw_a         : in  std_logic_vector(3 downto 0);
		sw_b         : in  std_logic_vector(3 downto 0);
		add_sub_flag : in  std_logic;
		result       : out std_logic_vector(3 downto 0)
	);
end entity add_sub;

architecture beh of add_sub is 
begin
	process(clk, reset)
		variable  a       : unsigned(3 downto 0);
		variable  b       : unsigned(3 downto 0);
		variable  sum_out : unsigned(3 downto 0);
		
	begin
		if reset = '1' then 
			result <= (others => '0');
		elsif rising_edge(clk) then	
			a := unsigned(sw_a);
			b := unsigned(sw_b);
			
			if add_sub_flag = '1' then
				sum_out := a - b;
			else 
				sum_out := a + b;
			end if;
			result <= std_logic_vector(sum_out);
		end if;
	end process;
end architecture beh;

