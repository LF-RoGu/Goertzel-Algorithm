library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use NUMERIC_STD for unsigned and signed types

entity filler is
    Port (
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        input : in  signed(11 downto 0);
        output : out  signed(19 downto 0)
    );
end filler;

architecture Behavioral of filler is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            output <= (others => '0');  -- Reset output to 0
        elsif rising_edge(clk) then
            -- Sign extend the 12-bit input to a 20-bit output using a loop
            for i in 19 downto 12 loop
                output(i) <= input(11);  -- Replicate the sign bit
            end loop;
            output(11 downto 0) <= input(11 downto 0);  -- Copy the original 12 bits
        end if;
    end process;
end Behavioral;
