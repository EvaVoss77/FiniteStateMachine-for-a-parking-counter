
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador is
	generic(N: integer:=4);
	port(
		
		load: in std_logic;
		syn_clr: in std_logic;
		en: in std_logic;
		up: in std_logic;
		clk: in std_logic;
		d: in std_logic_vector(N-1 downto 0);
		
		q: out std_logic_vector(N-1 downto 0);
		min_tick: out std_logic;
		max_tick: out std_logic
		
		);
end contador;

architecture tarea_cont of contador is
	signal r_reg: unsigned(N-1 downto 0);
	signal r_next: unsigned(N-1 downto 0);
begin
	
	process(clk)
	begin 
		if(clk'event and clk='1') then 
			r_reg <= r_next;
		end if;
	end process;
	
--next state 
	r_next <= (others => '0') when (syn_clr='1') else
				 unsigned(d) when load='1' else
				 r_reg + 1 when (en='1' and up='1') else 
				 r_reg - 1 when (en='1' and up='0') else 
				 r_reg;
			

--output logic

	q <= std_logic_vector(r_reg);
	min_tick <= '1' when to_integer(r_reg)=0 else
					'0';
	max_tick <= '1' when to_integer(r_reg)=(2**N-1) else
					'0';

end tarea_cont;

