--Salajan Madalina & Eric Toader

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity T_FF is
	port(T: in Std_logic; CLOCK: in Std_logic; Q: out Std_logic);
end entity;

architecture BEHAVIORAL of T_FF is
signal Qprev: Std_logic:= '0';
begin
	process(CLOCK, T, Qprev)
	begin
		if rising_edge(CLOCK) then
			if T = '1' then
				Qprev <= not Qprev;
				Q <= Qprev;
			elsif T = '0' then
				Q <= Qprev;
			end if;
		end if;
	end process;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity DIVIZOR_AFISOR is
port(CLOCK_in: in std_logic; CLOCK_out: out std_logic);
end entity;

architecture BEHAVIORAL of DIVIZOR_AFISOR is
signal CLK_sgn: std_logic:='0';
begin
process(CLOCK_in, CLK_sgn)
variable freq: integer := 0;
begin
    if rising_edge(CLOCK_in) then
        freq := freq + 1;
    end if;
    if freq = 25000 then
    CLK_sgn <= not CLK_sgn;
    freq := 0;
    end if;
    end process;
    CLOCK_out <= CLK_sgn;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity BCD_7SEGM is
	port(A: in Std_logic_vector(3 downto 0); Y: out Std_logic_vector(6 downto 0));
end entity;

architecture BEHAVIORAL of BCD_7SEGM is
type dcd_array is array (0 to 10) of Std_logic_vector(6 downto 0);
signal dcd_out: dcd_array := ("1000000", "1111001", "0100100", "0110000", "0011001", "0010010",
								"0000010", "1111000", "0000000", "0010000", "1111111");
begin
	process(A,dcd_out)
	begin
		case A is
			when "0000" => Y<=dcd_out(0);
			when "0001" => Y<=dcd_out(1);
			when "0010" => Y<=dcd_out(2);
			when "0011" => Y<=dcd_out(3);
			when "0100" => Y<=dcd_out(4);
			when "0101" => Y<=dcd_out(5);
			when "0110" => Y<=dcd_out(6);
			when "0111" => Y<=dcd_out(7);
			when "1000" => Y<=dcd_out(8);
			when "1001" => Y<=dcd_out(9);
			when others => Y<=dcd_out(10);
		end case;
	end process;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity MUX_ZECI_UNIT is
	port(A: in Std_logic_vector(3 downto 0); B: in Std_logic_vector(3 downto 0);
	S: in Std_logic;
	Y: out Std_logic_vector(3 downto 0));
end entity;

architecture BEHAVIORAL of MUX_ZECI_UNIT is
begin
	process(S,A,B)
	begin
		if S = '0' then
			Y <= A;
		elsif S = '1' then
			Y <= B;
		end if;
	end process;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity DCD_anod is
	port(A: in Std_logic;
	Y1: out Std_logic; Y2: out Std_logic);
end entity;

architecture BEHAVIORAL of DCD_anod is
begin
	process(A)
	begin
		if A = '0' then
			Y1 <= '1';
			Y2 <= '0';
		elsif A = '1' then
			Y1 <= '0';
			Y2 <= '1';
		end if;
	end process;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity AFISOR_7SEGMENTE is
	port(CLOCK: in Std_logic;
	UNIT, ZECI: in STd_logic_vector(3 downto 0); 
	ANOD: out Std_logic_vector(3 downto 0);
	CATOD: out STd_logic_vector(6 downto 0));
end entity;

architecture STRUCTURAL of AFISOR_7SEGMENTE is

component T_FF
	port(T: in Std_logic; CLOCK: in Std_logic; Q: out Std_logic);
end component;

component BCD_7SEGM
	port(A: in Std_logic_vector(3 downto 0); Y: out Std_logic_vector(6 downto 0));
end component;

component MUX_ZECI_UNIT
	port(A: in Std_logic_vector(3 downto 0); B: in Std_logic_vector(3 downto 0);
	S: in Std_logic;
	Y: out Std_logic_vector(3 downto 0));
end component;

component DIVIZOR_AFISOR
port(CLOCK_in: in std_logic; CLOCK_out: out std_logic);
end component;

component DCD_anod
	port(A: in Std_logic;
	Y1: out Std_logic; Y2: out Std_logic);
end component;

signal VCC: Std_logic := '1';
signal FF_out, CLOCK_sgn: Std_logic;
signal mux_out: Std_logic_vector(3 downto 0);
begin
	anod(3) <= '1';
	anod(2) <= '1';
	DIV_AF: DIVIZOR_AFISOR port map(CLOCK_in=>CLOCK, CLOCK_out=>CLOCK_sgn);
	FF: T_FF port map(T => VCC, CLOCK => CLOCK_sgn, Q => FF_out);
	MUX: MUX_ZECI_UNIT port map(A => ZECI, B => UNIT, S => FF_out, Y => mux_out);
	BCD_cifra: BCD_7SEGM port map(A => mux_out, Y => CATOD);
	Anod_select: DCD_anod port map(A => FF_out, Y1 => anod(0), Y2 => anod(1));
end architecture;