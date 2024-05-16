library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top_tp3 is
	generic(N: integer:=4);
	port(
		a: in std_logic;
		b: in std_logic;
		load: in std_logic;
		syn_clr: in std_logic;
		clk: in std_logic;
		d: in std_logic_vector(N-1 downto 0);
		
	--	disp: out std_logic_vector(6 downto 0);
	--	en_display: out std_logic_vector(3 downto 0);
		q: out std_logic_vector(N-1 downto 0);
		min_tick: out std_logic;
		max_tick: out std_logic
		
		
		);
end top_tp3;

architecture Behavioral of top_tp3 is
	signal en, up: std_logic;
	--signal q: std_logic_vector(N-1 downto 0);
begin
	
	FSM: entity work.FSM(tarea_FSM)
	port map(a => a, b => b, clk => clk, en => en, up => up);
	
	cont: entity work.contador(tarea_cont)
	port map(en => en, up => up, d=>d, syn_clr=>syn_clr, load=>load, 
	clk=>clk, q=>q, min_tick=>min_tick, max_tick=>max_tick);
	
--	dpy: entity work.display(tarea_dpy)
--	port map(q=>q, disp=>disp, en_display=>en_display);


end Behavioral;