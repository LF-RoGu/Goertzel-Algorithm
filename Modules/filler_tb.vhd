library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use NUMERIC_STD for unsigned and signed types

entity filler_tb is
end filler_tb;

architecture Behavioral of filler_tb is

    -- Component declaration
    component filler is
        Port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            input : in  signed(11 downto 0);
            output : out  signed(19 downto 0)
        );
    end component;

    -- Signals for connecting to the component
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal input : signed(11 downto 0) := (others => '0');
    signal output : signed(19 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: filler
        Port map (
            clk => clk,
            rst => rst,
            input => input,
            output => output
        );

    -- Clock generation
    clk_process :process
    begin
	while True loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
	end loop;
    end process;

    -- Stimulus process
    stim_proc: process
	variable expected_output : signed(19 downto 0);
    begin
	-- Test case 1: Reset the component
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Test case 2: Apply a positive number
        input <= to_signed(341, 12);  -- +341 in decimal
        expected_output := to_signed(341, 20);
        wait for 20 ns;
        assert output = expected_output report "Test case 2 failed: +341" severity error;

        -- Test case 3: Apply a negative number
        input <= to_signed(-341, 12);  -- -341 in decimal
        expected_output := to_signed(-341, 20);
        wait for 20 ns;
        assert output = expected_output report "Test case 3 failed: -341" severity error;

        -- Test case 4: Apply another positive number
        input <= to_signed(1, 12);  -- +1 in decimal
        expected_output := to_signed(1, 20);
        wait for 20 ns;
        assert output = expected_output report "Test case 4 failed: +1" severity error;

        -- Test case 5: Apply another negative number
        input <= to_signed(-1, 12);  -- -1 in decimal
        expected_output := to_signed(-1, 20);
        wait for 20 ns;
        assert output = expected_output report "Test case 5 failed: -1" severity error;
        wait for 20 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
