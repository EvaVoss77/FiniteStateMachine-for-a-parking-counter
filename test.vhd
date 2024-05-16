
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY test_tp3 IS
  
END test_tp3;

ARCHITECTURE behavior OF test_tp3 IS 

  -- Component declaration
          COMPONENT top_tp3
          PORT(						
						a : in std_logic;
						b : in std_logic;
						load : in std_logic;
						syn_clr : in std_logic;
						clk : in std_logic;
						d: in std_logic_vector(4-1 downto 0);
		
						q: out std_logic_vector(4-1 downto 0);
						min_tick: out std_logic;
						max_tick: out std_logic
						
                  );
          END COMPONENT;

          --Inputs
			signal a : std_logic := '0';
			signal b : std_logic:= '0';
			signal load : std_logic := '0';
			signal syn_clr : std_logic := '1';
			signal clk : std_logic := '0';
			signal d: std_logic_vector(4-1 downto 0) := "1001";
		
				--Outputs
			signal q: std_logic_vector(4-1 downto 0);
			signal min_tick: std_logic;
			signal max_tick: std_logic;


			-- Clock period definitions
			constant clk_period : time := 10 ns;
          
  BEGIN

          uut: top_tp3 PORT MAP(
                  a => a,
						b => b,
						load => load,
						syn_clr => syn_clr,
						clk => clk,
						d => d,
		
						q => q,
						
						max_tick => max_tick,
						min_tick => min_tick
          );


    -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

	
	 -- Stimulus process
   stim_proc: process
   begin		
	
	
		syn_clr <= '1';
		a <= '0';
		b <= '0';
      wait for 5*clk_period;
		syn_clr <= '0';
		a <= '0';
		b <= '0';
      wait for 5*clk_period;
		syn_clr <= '0';
		
		
		-----
		
		a <= '0';
		b <= '0';
      wait for 5*clk_period;
		
		a <= '0';
		b <= '0';
      wait for 5*clk_period;
		
		a <= '1';
		b <= '0';
      wait for 5*clk_period;
		
		---entra 2----
		a <= '1';
		b <= '1';
      wait for 5*clk_period;
		
		a <= '1';
		b <= '1';
      wait for 5*clk_period;
		
		a <= '1';
		b <= '1';
      wait for 5*clk_period;
		
		a <= '0';
		b <= '1';
      wait for 5*clk_period;
		
		a <= '0';
		b <= '0';
      wait for 5*clk_period;		
		---
		
		a <= '0';
		b <= '0';
      wait for 5*clk_period;
		
		a <= '0';
		b <= '0';
      wait for 5*clk_period;
		
		a <= '0';
		b <= '0';
      wait for 5*clk_period;
		
		

end process;

END;
