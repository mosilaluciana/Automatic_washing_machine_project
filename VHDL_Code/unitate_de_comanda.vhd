--Pinciuc Darius-Eduard
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity UNITATE_COMANDA is
	port(ENABLE, START, PS, CS, MODE, T0, T1, T2, T3, R0, R1, R2, NUM_STARE, SZ_USA, CLOCK, CONFIRMARE: in STD_LOGIC;
	LOAD_NUM, BLCK, T00, T01, C, P, E_STARE, R_STARE: out STD_LOGIC;
	LED: out STD_LOGIC_vector(6 downto 0);
	S_STARE: out STD_LOGIC_VECTOR(1 downto 0));	
end entity;									

architecture BEHAVIORAL of UNITATE_COMANDA is
type STARE_T is (A, B, C00, C0, C1, D, D0, D1, E, F, G, H, I, J, K, L, M, N, O, P0, R);
signal NEXT_STARE: STARE_T;
signal STARE: STARE_T :=A;
signal CC,PP: STD_LOGIC;

begin
	
ACTUALIZEAZA_STARE: process (STARE, NEXT_STARE, CLOCK)
begin
	if (CLOCK'EVENT and CLOCK='1') then
		STARE <= NEXT_STARE;
	end if;
end process ACTUALIZEAZA_STARE;	


PROGRAM: process (STARE, ENABLE, START, PS, CS, MODE, T0, T1, T2, T3, R0, R1, R2, NUM_STARE, SZ_USA, CONFIRMARE, CC, PP)
begin	
	NEXT_STARE <= STARE;
	case STARE is
		when A => 
			if ENABLE='1' then 
				E_STARE <= '1';
				R_STARE <= '1';
				NEXT_STARE <= B; 
			end if;
		
		when B => 
			if SZ_USA='1' then 
				LED(0) <= '1';
				NEXT_STARE <= B;
			else
				LED(0) <= '0';
				NEXT_STARE <= C00;
			end if;	
		
		when C00 => 
		if MODE='1' then
            if CONFIRMARE = '1' then
                    NEXT_STARE <= C1;
            end if;
            else
            if CONFIRMARE = '1' then
                  NEXT_STARE <= C0;
            end if;
         end if;
		
		
		when C1 =>
			if T0='1' then 
				T01 <= '0';
				T00 <= '0';
				PP <= '0';
				CC <= '0';	
				NEXT_STARE <= D;
			else
				if T1='1' then
					T01 <= '0';
					T00 <= '0';
					PP <= '0';
					CC <= '0';	  
					NEXT_STARE <= D;
				else
					if T2='1' then
						T01 <= '0';
						T00 <= '1';
						PP <= '0';
						CC <= '1';
						NEXT_STARE<=D;
					else
						if T3='1' then
							T01<='0';
							T00<='1';
							PP<='1';
							CC<='0';
							NEXT_STARE<=D; 
						else
							if R0='1' then
								T01<='1';
								T00<='1';
								PP<='0';
								CC<='1';
								NEXT_STARE <= D;
							end if;
						end if;
					end if;
				end if;
				C <= CC;
				P <= PP;
			end if;
			
		when C0 =>
			if T0='1' then
				T01<='0';
				T00<='0'; 
				NEXT_STARE<=D0;
			else
				if T1='1' then
					T01<='0';
					T00<='1';
					NEXT_STARE <= D0;
				else
					if T2='1' then
						T01<='1';
						T00<='0';
						NEXT_STARE <= D0;
					else
						if T3='1' then
							T01<='1';
							T00<='1'; 
							NEXT_STARE <= D0;
						end if;
					end if;
				end if;
			end if;
			
		when D0 =>
		
		if PS='1' then
		  if CONFIRMARE = '1' then
				PP<='1';
				P<=PP;
				NEXT_STARE <= D1;
			else
			    NEXT_STARE <= D1;
			end if;
		end if;
			
		when D1=>
		if CS='1' then
		  if CONFIRMARE = '1' then
			
				CC<='1'; 
				C<=CC;
				NEXT_STARE <= D;
		  end if;
		else 
		 if CONFIRMARE = '1' then
			    NEXT_STARE <= D;
		 end if;
		end if;
		
		when D => 
			if START='1' then 
			if CONFIRMARE='1' then
				LOAD_NUM <= '1';
				BLCK<='1';
				NEXT_STARE <= E;
			end if;
			end if;
		
		when E =>
			if PP='1' then 
			    BLCK <= '1';
				LED(1)<='1';
				S_STARE<="00";
				R_STARE<='0';
				LOAD_NUM <= '0';
				NEXT_STARE<= F;	  
			else
			    BLCK <= '1'; 
				LOAD_NUM <= '0';
				NEXT_STARE<=G;
			end if;	
		
		when F =>
			if NUM_STARE='1' then
				LED(1)<='0';
				R_STARE <='1';
				NEXT_STARE<=G;
			else
			    LED(1)<='1';
				NEXT_STARE<=F;
			end if;
		
		when G =>
			LED(2)<='1';  
			S_STARE<="01";
			R_STARE<='0';
			NEXT_STARE<=H;
		
		when H =>
			if NUM_STARE='1' then
				LED(2) <= '0';
				R_STARE <= '1';
				NEXT_STARE <= I;
			else
			    LED(2)<='1';
				NEXT_STARE <= H;
			end if;
		
		when I =>
			LED(3)<='1';
			S_STARE<="00";
			R_STARE<='0';
			NEXT_STARE<=J;
		
		when J =>
			if NUM_STARE='1' then 
				LED(3)<='0';
				R_STARE<='1';
				NEXT_STARE<=K;
			else
				LED(3)<='1';
				NEXT_STARE<=J;
			end if;
		
		when K =>
			if CC='1' then
				LED(4)<='1';
				S_STARE<="00";
				R_STARE<='0';
				NEXT_STARE <= L;
			else
				NEXT_STARE <= M;
			end if;
		
		when L =>
			if NUM_STARE='1' then
				LED(4) <= '0';
				R_STARE <= '1';
				NEXT_STARE <= M;
			else
				LED(4) <= '1';
				NEXT_STARE <= L;
			end if;
		
		when M =>
			LED(5)<='1';
			S_STARE<="00";
			R_STARE<='0';	  
			NEXT_STARE<=N;
		
		when N =>
			if NUM_STARE='1' then
				LED(5) <= '0';
				R_STARE <= '1';
				NEXT_STARE <= O;
			else
				LED(5) <= '1';
				NEXT_STARE <= N;
			end if;
		
		when O =>
			S_STARE <= "10";
			R_STARE <= '0';
			LED(6) <= '1';
			NEXT_STARE <= P0;
		
		when P0 =>
			if NUM_STARE='1' then
				R_STARE <= '1';
				E_STARE <= '0';
				BLCK <= '0';
				NEXT_STARE <= R;
			end if;
		
		when R =>
			if SZ_USA='1' then
				LED(6) <= '0';
				NEXT_STARE <= A;
			end if;	 
		end case;
	end process PROGRAM;
end architecture;