-------------------------------------------------------------------------------
-- Britney Guillen
-- single bit full adder [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity full_adder_single_bit_arch is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_arch;

architecture beh of full_adder_single_bit_arch is

signal axorb : std_logic;
signal term1 : std_logic;
signal term2 : std_logic;
signal cinv  : std_logic;

begin
  axorb <= a xor b;
  term1 <= axorb and cin;
  term2 <= a and b;
  
  sum  <= axorb xor cin;
  cout <= term1 or term2;
end beh; 