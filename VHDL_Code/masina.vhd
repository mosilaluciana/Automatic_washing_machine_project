library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library ProiectPSN;
use ProiectPSN.all;

entity MASINA is
	port(ENABLE, MODE, USA, START, CLOCK, T0, T1, T2, T3, R0, R1, R2, PS, CS, CONFIRMARE: in Std_logic;
	LED: out Std_logic_vector(15 downto 0);
	 CATOD: out STd_logic_vector(6 downto 0);
	ANOD: out Std_logic_vector(3 downto 0));
end entity;

architecture Structural of MASINA is

component UNITATE_EXECUTIE
	port(USA: in sTd_logic; BLCK: in Std_logic; CLOCK: in STd_logic;
	T00: in Std_logic; T01: in sTd_logic; C: in std_logic; P: in std_logic;
	LOAD_NUM: in STD_logic; EN_STARE, R_STARE: in STd_logic; S_STARE: in STd_logic_vector(1 downto 0);
	SZ_USA: out STd_logic; NUM_STARE: out STd_logic;
	CATOD: out STd_logic_vector(6 downto 0);
	ANOD: out Std_logic_vector(3 downto 0));
end component;

component UNITATE_COMANDA
	port(ENABLE, START, PS, CS, MODE, T0, T1, T2, T3, R0, R1, R2, NUM_STARE, SZ_USA, CLOCK, CONFIRMARE: in STD_LOGIC;
	LOAD_NUM, BLCK, T00, T01, C, P, E_STARE, R_STARE: out STD_LOGIC;
	LED: out STD_LOGIC_vector(6 downto 0);
	S_STARE: out STD_LOGIC_VECTOR(1 downto 0));
end component;
signal num_stare_sgn,sz_usa_sgn,en_stare_sgn,blck_sgn,t00_sgn,t01_sgn,c_sgn,p_sgn,load_sgn,r_stare_sgn: STD_logic;
signal S_STARE_sgn: STd_logic_vector(1 downto 0);
begin

LED(15) <= num_stare_sgn;
LED(14) <= sz_usa_sgn;
LED(13) <= r_stare_sgn;
LED(12) <= en_stare_sgn;
LED(11) <= blck_sgn;
LED(10) <= t00_sgn;
LED(9) <= c_sgn;
LED(8) <= p_sgn;
LED(7) <= load_sgn;

	UC: UNITATE_COMANDA port map(ENABLE => ENABLE,START => START,PS => PS,CS => CS,MODE => MODE,T0 => T0,T1 => T1,T2 => T2,T3 => T3,R0 => R0,R1 => R1,R2 => R2,
										CLOCK => CLOCK, NUM_STARE => num_stare_sgn,SZ_USA => sz_usa_sgn,LOAD_NUM => load_sgn,E_STARE => en_stare_sgn, CONFIRMARE=>CONFIRMARE,
									R_STARE=>r_stare_sgn,BLCK => blck_sgn,T00 => t00_sgn,T01 => t01_sgn,C => c_sgn,P => p_sgn,LED => LED (6 downto 0),S_STARE => S_STARE_sgn);
	UE: UNITATE_EXECUTIE port map(USA => USA,BLCK => blck_sgn,CLOCK => CLOCK,T00 => t00_sgn,T01 => t01_sgn,C => c_sgn,P => p_sgn,LOAD_NUM => load_sgn,
								EN_STARE => en_stare_sgn,R_STARE=>r_stare_sgn,S_STARE => S_STARE_sgn,SZ_USA => sz_usa_sgn,NUM_STARE => num_stare_sgn,
									CATOD => CATOD, ANOD => ANOD);
end architecture;