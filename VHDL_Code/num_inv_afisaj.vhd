--Salajan Madalina

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity NUMARATOR_INVERS_ZECIMAL is
	port(LOAD, ENABLE, CLK: in STD_LOGIC;
	BORROW: out STD_LOGIC;
	D: in STD_LOGIC_VECTOR( 3 downto 0 );
	Q: out STD_LOGIC_VECTOR( 3 downto 0));
end entity;

architecture COMPORTAMENTALA of NUMARATOR_INVERS_ZECIMAL is
begin
	process(CLK,ENABLE,LOAD,D)
	variable AUX: STD_LOGIC_VECTOR( 3 downto 0 ):="0000";
	begin
		if ENABLE='1' then
			if LOAD='1' then
				AUX:=D;
			else
				if(	CLK'EVENT and CLK='1') then
					if AUX="0000" then
						BORROW<='1';
						AUX:="1010";
					else
						BORROW<='0';
					end if;
						
					AUX:=AUX-1;
				end if;
			end if;
		else
			Q<="ZZZZ";
		end if;
		Q<=AUX;
	end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity NUMARATOR_INVERS_8_BIT is 
	port(LOAD, ENABLE, CLK: in STD_LOGIC;
	CIFRA_UNIT, CIFRA_ZECI: in STD_LOGIC_VECTOR( 3 downto 0 );
	DCD_UNIT, DCD_ZECI: out STD_LOGIC_VECTOR( 3 downto 0));
end entity;

architecture STRUCTURAL of NUMARATOR_INVERS_8_BIT is

component NUMARATOR_INVERS_ZECIMAL
	port(LOAD, ENABLE, CLK: in STD_LOGIC;
	BORROW: out STD_LOGIC;
	D: in STD_LOGIC_VECTOR( 3 downto 0 );
	Q: out STD_LOGIC_VECTOR( 3 downto 0));
end component;

signal N1: STD_logic := '0';
signal N2: Std_logic;
begin
	UNIT: NUMARATOR_INVERS_ZECIMAL port map (LOAD => LOAD,ENABLE => ENABLE,CLK => CLK,BORROW => N1,D => CIFRA_UNIT,Q => DCD_UNIT);
	ZECI: NUMARATOR_INVERS_ZECIMAL port map (LOAD => LOAD,ENABLE => ENABLE,CLK => N1,BORROW => N2,D => CIFRA_ZECI,Q => DCD_ZECI);
	
end architecture;