--Eric Toader

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity NUMARATOR_STARE is
	port(EN_STARE, RESET, CLK: in Std_logic; S_STARE: in Std_logic_vector(1 downto 0);
	NUM_STARE: out STd_logic);
end entity;

architecture BEHAVIORAL of NUMARATOR_STARE is
signal num: std_logic_vector(4 downto 0);
begin
	process(EN_STARE, RESET, CLK)
	begin
		if EN_STARE = '1' then
			if RESET = '0' then
				if rising_edge(CLK) then
					num <= num + '1';
				end if;
			elsif RESET = '1' then
				num <= "00000";
			end if;
		else num <= "ZZZZZ";
		end if;
	end process;
	
	process(num, S_STARE)
	begin
		case S_STARE is
			when "00" =>
			if num = "01010" then
				NUM_STARE <= '1';
			else NUM_STARE <= '0';
			end if;
			when "01" =>
			if num = "10100" then
				NUM_STARE <= '1';
			else NUM_STARE <= '0';
			end if;
			when "10" =>
			if num = "00001" then
				NUM_STARE <= '1';
			else NUM_STARE <= '0';
			end if;
			when others => NUM_STARE <= '0';
		end case;
	end process;
end architecture;