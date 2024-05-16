library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity display is
	generic(N: integer:=4);
	port(
		q: in std_logic_vector(N-1 downto 0);
		
		disp: out std_logic_vector(6 downto 0);
		en_display: out std_logic_vector(3 downto 0)
	);
end display;

architecture tarea_dpy of display is
begin
	en_display <= "0000";
	process(q)
	begin
		case q is 
			when "0000" => disp<="1000000"; --0
			when "0001" => disp<="1111001"; --1
			when "0010" => disp<="0100100"; --2
			when "0011" => disp<="0110000"; --3
			when "0100" => disp<="0011001"; --4
			when "0101" => disp<="0010010"; --5
			when "0110" => disp<="0000010"; --6
			when "0111" => disp<="1111000"; --7
			when "1000" => disp<="0000000"; --8
			when "1001" => disp<="0010000"; --9
			when "1010" => disp<="0100000"; --a
			when "1011" => disp<="0000011"; --b
			when "1100" => disp<="1000110"; --c
			when "1101" => disp<="0100001"; --d
			when "1110" => disp<="0000100"; --e
			when others => disp<="0001110"; --f	
		end case;
	end process;
	
end tarea_dpy;

