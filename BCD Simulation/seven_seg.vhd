-- Britney Guillen

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg is
  port (
    clk             : in std_logic; 
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
 end entity seven_seg;
 
 architecture beh of seven_seg is 
 begin
	process(bcd)
	begin
		case bcd is 
			when "0000" => seven_seg_out <= "1000000"; -- This is 0
			when "0001" => seven_seg_out <= "1111001"; -- This is 1
			when "0010" => seven_seg_out <= "0100100"; -- This is 2
			when "0011" => seven_seg_out <= "0110000"; -- This is 3
			when "0100" => seven_seg_out <= "0011001"; -- This is 4
			when "0101" => seven_seg_out <= "0010010"; -- This is 5
			when "0110" => seven_seg_out <= "0000010"; -- This is 6
			when "0111" => seven_seg_out <= "1111000"; -- This is 7
			when "1000" => seven_seg_out <= "0000000"; -- This is 8
			when "1001" => seven_seg_out <= "0011000"; -- This is 9
			when others => seven_seg_out <= "1111111"; -- Off
		end case;
	end process;
end architecture beh;
	