library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity FSM is
	port(
			clk: in std_logic;
			a: in std_logic;
			b: in std_logic;
			
			en: out std_logic;
			up: out std_logic
			);
end FSM;

architecture tarea_FSM of FSM is
	type state_type is (idle, oo, oozo, oooz, salio, entro);
	signal state_reg, state_next: state_type;
	signal ab: std_logic_vector(1 downto 0);
begin

	ab <= (a & b);

--state register 
	process(clk)
	begin
		if (clk'event and clk='1') then
			state_reg <= state_next;
		end if;
	end process;
	
--next-state logic
	process(state_reg, ab)
	begin 
		state_next <= idle;
		case state_reg is
			when oo =>
				if ab="11" then 
					state_next <= oo;
				elsif ab="01" then
					state_next <= oozo;
				elsif ab="10" then
					state_next <= oooz;
				end if;
			when oozo =>
				if ab="11" then 
					state_next <= oo;
				elsif ab="01" then
					state_next <= oozo;
				elsif ab="00" then
					state_next <= entro;
				end if;
			when oooz =>
				if ab="11" then 
					state_next <= oo;
				elsif ab="10" then
					state_next <= oooz;
				elsif ab="00" then
					state_next <= salio;
				end if;
			when idle => 
				if ab="11" then 
					state_next <= oo;
				end if;
			when others =>
				state_next <= idle;
		end case;
	end process;

--output logic
	
	process(state_reg, ab)
	begin 
		en <= '0';
		up <= '0';
		case state_reg is
			when entro =>
				en <= '1';
				up <= '1';
			when salio =>
				en <= '1';
				up <= '0';
			when others =>
				en <= '0';
				up <= '0';
		end case;
	end process;

end tarea_FSM;

