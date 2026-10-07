-------------------------------------------------------------------------------
-- Britney Guillen
-- Counter Sim Top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
	port (
		clk      : in  std_logic; --50mhz
		reset    : in  std_logic;
		sw_a     : in  std_logic_vector(2 downto 0);
		sw_b     : in  std_logic_vector(2 downto 0);
		add_btn  : in  std_logic;
		sub_btn  : in  std_logic;
		HEX0     : out std_logic_vector(6 downto 0);
		HEX2     : out std_logic_vector(6 downto 0);
		HEX4     : out std_logic_vector(6 downto 0)
	);
end entity top;

architecture structural of top is 

	component synchronizer_3bit is 
		port(
			clk               : in std_logic;
			reset             : in std_logic;
			async_in          : in std_logic_vector(2 downto 0);
			sync_out          : out std_logic_vector(2 downto 0)
		);
	end component synchronizer_3bit;
	
	component add_sub is 
		port(
			clk          : in  std_logic;
			reset        : in  std_logic;
			sw_a         : in  std_logic_vector(3 downto 0);
			sw_b         : in  std_logic_vector(3 downto 0);
			add_sub_flag : in  std_logic;
			result       : out std_logic_vector(3 downto 0)
		);
	end component add_sub;
	
	component seven_seg is 
		port(
			hex_dig   : in std_logic_vector(3 downto 0);
			seg_out   : out std_logic_vector(6 downto 0)
		);
	end component seven_seg;
	
	signal sync_a       : std_logic_vector(2 downto 0);
	signal sync_b       : std_logic_vector(2 downto 0);
	signal sub_flag_reg : std_logic := '0';
	
	signal a_4bit       : std_logic_vector(3 downto 0);
	signal b_4bit       : std_logic_vector(3 downto 0);
	signal calc_result  : std_logic_vector(3 downto 0);
	
begin
	sw_a_sync : synchronizer_3bit
		port map(
			clk      => clk,
			reset    => reset,
			async_in => sw_a,
			sync_out => sync_a
		);
			
	sw_b_sync : synchronizer_3bit
		port map(
			clk      => clk,
			reset    => reset,
			async_in => sw_b,
			sync_out => sync_b
		);
	process(clk, reset)
	begin
		if reset = '1' then
			sub_flag_reg <= '0';
		elsif rising_edge(clk) then 
			if sub_btn = '0' then
				sub_flag_reg <= '0';
			elsif add_btn = '0' then 
				sub_flag_reg <= '1';
			end if;
		end if;
	end process;
	
	a_4bit <= "0" & sync_a;
	b_4bit <= "0" & sync_b;
	
	add_sub_inst : add_sub
		port map(
			clk          => clk,
			reset        => reset,
			sw_a         => a_4bit,
			sw_b         => b_4bit,
			add_sub_flag => sub_flag_reg,
			result       => calc_result
		);
		
	hex_a_inst : seven_seg
		port map(
			hex_dig => a_4bit,
			seg_out => HEX4
		);
		
	hex_b_inst : seven_seg
		port map(
			hex_dig => b_4bit,
			seg_out => HEX2
		);
		
	hex_c_inst : seven_seg
		port map(
			hex_dig => calc_result,
			seg_out => HEX0
		);
	
end architecture structural;
		
			

	

