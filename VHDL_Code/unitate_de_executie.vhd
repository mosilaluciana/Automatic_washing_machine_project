library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library ProiectPSN;
use ProiectPSN.all;

entity UNITATE_EXECUTIE is
	port(USA: in sTd_logic; BLCK: in Std_logic; CLOCK: in STd_logic;
	T00: in Std_logic; T01: in sTd_logic; C: in std_logic; P: in std_logic;
	LOAD_NUM: in STD_logic; EN_STARE, R_STARE: in STd_logic; S_STARE: in STd_logic_vector(1 downto 0);
	SZ_USA: out STd_logic; NUM_STARE: out STd_logic;
	CATOD: out STd_logic_vector(6 downto 0);
	ANOD: out Std_logic_vector(3 downto 0));
end entity;

architecture STRUCTURAL of UNITATE_EXECUTIE is

component SENZOR_USA
	port(USA: in STD_logic; BLCK: in STD_logic;
	SZ_USA: out STd_logic);
end component;

component ROM
	port(T00: in Std_logic; T01: in STd_logic; C: in STd_logic; P: in STd_logic;
	d: out STd_logic_vector(3 downto 0));
end component;

component ROM2
	port(C: in STd_logic; P: in STd_logic;
	d: out STd_logic_vector(3 downto 0));
end component;

component DIVIZOR
	port(CLOCK: in Std_logic; CLOCK_1sec: out Std_logic);
end component;

component NUMARATOR_STARE
	port(EN_STARE, RESET, CLK: in Std_logic; S_STARE: in Std_logic_vector(1 downto 0);
	NUM_STARE: out STd_logic);
end component;

component NUMARATOR_INVERS_8_BIT 
	port(LOAD, ENABLE, CLK: in STD_LOGIC;
	CIFRA_UNIT, CIFRA_ZECI: in STD_LOGIC_VECTOR( 3 downto 0 );
	DCD_UNIT, DCD_ZECI: out STD_LOGIC_VECTOR( 3 downto 0));
end component;

component AFISOR_7SEGMENTE
	port(CLOCK: in Std_logic;
	UNIT, ZECI: in STd_logic_vector(3 downto 0); 
	ANOD: out Std_logic_vector(3 downto 0);
	CATOD: out STd_logic_vector(6 downto 0));
end component;

signal CLK_div: STd_logic;
signal GND: Std_logic:= '0';
signal DCD_UNIT_sgn, DCD_ZECI_sgn : Std_logic_vector (3 downto 0);
signal ROM1_out, ROM2_out : Std_logic_vector (3 downto 0);
begin

	SZ: SENZOR_USA port map(USA => USA,BLCK => BLCK,SZ_USA => SZ_USA);
	
	DIV1: DIVIZOR port map(CLOCK => CLOCK, CLOCK_1sec => CLK_div); 
	
	NMSTR: NUMARATOR_STARE port map(EN_STARE => EN_STARE, RESET => R_STARE, CLK => CLK_div,S_STARE => S_STARE, NUM_STARE => NUM_STARE);

	ROM16 : ROM port map(T00 => T00,T01 => T01,C => C,P => P,d => ROM1_out);
	
	ROM4 :ROM2  port map(C => C,P => P,d => ROM2_out);
	
	NMINV: NUMARATOR_INVERS_8_BIT port map(LOAD => LOAD_NUM,ENABLE => BLCK,CLK => CLK_div,CIFRA_UNIT => ROM1_out,CIFRA_ZECI => ROM2_out,DCD_UNIT => DCD_UNIT_sgn,DCD_ZECI => DCD_ZECI_sgn);
	
	AFISOR: AFISOR_7SEGMENTE port map(CLOCK => CLOCK, UNIT => DCD_UNIT_Sgn, ZECI => DCD_ZECI_sgn, ANOD => ANOD, CATOD => CATOD); 
	
end architecture;