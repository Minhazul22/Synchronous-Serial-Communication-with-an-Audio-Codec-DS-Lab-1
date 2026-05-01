library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity PAR_TO_SER_LR is
generic(W : integer := 16);
port(
	CLK, SRESETN: in std_logic;
	PAR_IN_L, PAR_IN_R: in std_logic_vector(W-1 downto 0);
	 -- control signals for shifting bit out
	SHIFT_OUT	: in std_logic;
	 -- control signals for load in parallel word
    SAVE_R_LOAD_L, SAVE_L_LOAD_R   : in std_logic;        
	SER_OUT: out std_logic
	);
end PAR_TO_SER_LR;

architecture BEHAVIORAL of PAR_TO_SER_LR is

-- single shift reg for both channels
signal SHIFT_REG_NEXT,SHIFT_REG : std_logic_vector( W-1 downto 0);

begin

-- process defining one shift reg
P2S_REGS: process(CLK)
begin
	if CLK = '1' and CLK'event then
		if SRESETN = '0' then
			SHIFT_REG <= (others=>'0') after 2 ns;
        else
			if SHIFT_OUT='1' then
				SHIFT_REG <= SHIFT_REG_NEXT after 2 ns;
			end if;
		end if;
	end if;
end process;

--------------------------------------------------------------------
-- insert your code in the process below for next-state logic 
-- and output logic
--------------------------------------------------------------------  
P2S_COMBIN: process(SHIFT_REG) -- modify sensitivity list as needed
begin

   -- delete the two dummy lines and replace section by your code --
   SHIFT_REG_NEXT <= not SHIFT_REG after 2 ns;		
   SER_OUT <= SHIFT_REG(0) after 2 ns;
   -----------------------------------------------------------------
   
end process;

end BEHAVIORAL;