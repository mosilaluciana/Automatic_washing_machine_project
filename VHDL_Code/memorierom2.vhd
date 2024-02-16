								 library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use IEEE.numeric_std.all;

entity ROM2 is
	port( 	--clk:in std_logic; 
			C:in std_logic;
			P:in std_logic;
	        --cs:in Std_logic;
	        d:out Std_logic_vector(3 downto 0) 
			);
end entity ROM2;

architecture arh of ROM2 is
type memorie is array(0 to 3) of Std_logic_vector(3 downto 0)	  ;

signal rom: memorie := (
	"0100",
	"0101",
	"0101",
	"0110");
	 signal a: std_logic_vector(1 downto 0);	 
begin  

a(0)<=C;
a(1)<=P;
process(a)

begin 	
		d <= rom(to_integer(unsigned(a)));	
end process;
end arh ;
