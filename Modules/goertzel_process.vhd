library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity goertzel_process is
    generic (
        N_bits : integer := 20;
        numSamples : integer := 135
    );
    Port (
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        coeff  : in  STD_LOGIC_VECTOR(N_bits-1 downto 0);
        data   : in  STD_LOGIC_VECTOR(N_bits-1 downto 0);
        q1     : out STD_LOGIC_VECTOR(N_bits-1 downto 0);
        q2     : out STD_LOGIC_VECTOR(N_bits-1 downto 0);
        ready  : out STD_LOGIC
    );
end goertzel_process;

architecture Behavioral of goertzel_process is
    signal q0      : signed(N_bits-1 downto 0) := (others => '0');
    signal q1_sig  : signed(N_bits-1 downto 0) := (others => '0');
    signal q2_sig  : signed(N_bits-1 downto 0) := (others => '0');
    signal coeff_s : signed(N_bits-1 downto 0);
    signal data_s  : signed(N_bits-1 downto 0);
    constant delay_cycles : integer := 1; -- Number of cycles to delay after ready signal
begin

    -- Convert input vectors to signed
    coeff_s <= signed(coeff);
    data_s  <= signed(data);

    process(clk, rst)
        variable sample_count : integer := 0;
    begin
        if rst = '1' then
            q1_sig <= (others => '0');
            q2_sig <= (others => '0');
            q0 <= (others => '0');
            sample_count := 0;
            ready <= '0';
        elsif rising_edge(clk) then
          if sample_count < numSamples then
            -- Perform the Goertzel algorithm computation
            q0 <= resize(coeff_s * q1_sig - q2_sig + data_s, q0'length);
            q2_sig <= q1_sig;
          	q1_sig <= q0;
          	sample_count := sample_count + 1;
			ready <= '0';
          elsif sample_count = numSamples then
          	ready <= '1';
            -- Assign internal signals to output ports
            q1 <= std_logic_vector(q1_sig);
            q2 <= std_logic_vector(q2_sig);
          end if;
        end if;
    end process;
end Behavioral;
