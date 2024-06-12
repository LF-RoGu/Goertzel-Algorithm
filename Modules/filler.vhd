library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity filler is
    	Port ( 	rst : in  STD_LOGIC;
           	clk : in  STD_LOGIC;
           	input : in  STD_LOGIC_VECTOR (11 downto 0);
           	output : out  STD_LOGIC_VECTOR (19 downto 0));
end filler;

architecture Behavioral of filler is

begin
	process(clk, rst)
	begin
		if(rst = '0') then
			output <= (others => '0');
		elsif(clk = '1' and clk'event) then
			output <= (19 downto 12 => input(11)) & input(11 downto 0);
		end if;
	end process;

end Behavioral;