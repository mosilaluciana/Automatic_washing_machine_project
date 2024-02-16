--Eric Toader

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SENZOR_USA is
	port(USA: in STD_logic; BLCK: in STD_logic;
	SZ_USA: out STd_logic);
end entity;

architecture FLUX_USA of SENZOR_USA is
begin
	SZ_USA <= not(USA) and not(BLCK);
end architecture;