--Salajan Madalina

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DIVIZOR is
	port(CLOCK: in Std_logic; CLOCK_1sec: out Std_logic);
end entity;

architecture BEHAVIORAL of DIVIZOR is
begin
	process(CLOCK)
	variable sec: STd_logic_vector(26 downto 0) := (others => '0');
	begin
		if rising_edge(CLOCK) then
			sec := sec + '1';
		end if;
		if sec = "101111101011110000100000000" then 
			CLOCK_1sec <= '1';
			sec := (others => '0');
		else CLOCK_1sec <= '0';
		end if;
	end process;
end architecture;