library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use IEEE.numeric_std.all;

entity ROM is
	port( 	T00,T01,C,P:in std_logic;
	        d:out Std_logic_vector(3 downto 0) 
			);
end entity ROM;

architecture arh of ROM is
type memorie is array(0 to 15) of Std_logic_vector(3 downto 0)	  ;
signal rom: memorie := ( 
	"0001",
	"0001",
	"0010",
	"0011",
	"0001",
	"0010",
	"0011",
	"0101",
	"0001",
	"0001",
	"0010",
	"0011",
	"0001",
	"0010",	
	"0011",
	"0101");
signal a: std_logic_vector(3 downto 0);
begin
a(3)<=T00;
a(2)<=T01;
a(1)<=C;
a(0)<=P;
process(a)
begin
		d <= rom(to_integer(unsigned(a)));	
end process;
end arh ;
