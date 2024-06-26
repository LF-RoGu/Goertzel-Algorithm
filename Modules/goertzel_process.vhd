library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity goertzel_process is
    generic (
        N_bits : integer := 20;
        coefficient_mul : signed(19 downto 0) := to_signed(1000, 20);
        numSamples : integer := 135
    );
    Port (
        clk        : in  STD_LOGIC;
        rst        : in  STD_LOGIC;
        data       : in  STD_LOGIC_VECTOR(N_bits-1 downto 0);
        coeff      : in  STD_LOGIC_VECTOR(N_bits-1 downto 0);
        cosine     : in  STD_LOGIC_VECTOR(N_bits-1 downto 0);
        sine       : in  STD_LOGIC_VECTOR(N_bits-1 downto 0);
        magnitude  : out STD_LOGIC_VECTOR(N_bits-1 downto 0);
        real_part  : out STD_LOGIC_VECTOR(N_bits-1 downto 0);
        img_part   : out STD_LOGIC_VECTOR(N_bits-1 downto 0)
    );
end goertzel_process;

architecture Behavioral of goertzel_process is
    signal q0_s, q1_s, q2_s : signed(N_bits-1 downto 0) := (others => '0');
    signal ready : std_logic;
begin
    process (clk, rst)
        variable q0 : signed(N_bits - 1 downto 0) := (others => '0');
        variable q1 : signed(N_bits - 1 downto 0) := (others => '0');
        variable q2 : signed(N_bits - 1 downto 0) := (others => '0');
        variable real_part_v : signed(N_bits - 1 downto 0) := (others => '0');
        variable img_part_v : signed(N_bits - 1 downto 0) := (others => '0');
        variable coefficient : signed(N_bits - 1 downto 0) := (others => '0');
        variable cosine_signed, sine_signed : signed(N_bits - 1 downto 0);
        variable magnitude_var : signed(2*N_bits-1 downto 0) := (others => '0');
        variable temp_q1, temp_q2, temp_result : signed(2*N_bits-1 downto 0);
        variable sample_count : integer := 0;
    begin
        if rst = '1' then
            q0 := (others => '0');
            q1 := (others => '0');
            q2 := (others => '0');
            real_part_v := (others => '0');
            img_part_v := (others => '0');
            sample_count := 0;
            ready <= '0';
        elsif rising_edge(clk) then
            coefficient := signed(unsigned(coeff));
            cosine_signed := signed(unsigned(cosine));
            sine_signed := signed(unsigned(sine));

            temp_q1 := resize(q1, 2*N_bits);
            temp_q2 := resize(q2, 2*N_bits);
            temp_result := resize(coefficient * temp_q1 / coefficient_mul, 2*N_bits);

            q0 := signed(data) + temp_result(N_bits-1 downto 0) - q2;
            q2 := q1;
            q1 := q0;
			sample_count := sample_count + 1;
			ready <= '0';
            
            real_part_v := ( q1 - (resize(q2 * cosine_signed / coefficient_mul, N_bits)) ) / 68;
            img_part_v := ( resize(q2 * sine_signed / coefficient_mul, N_bits) ) / 68;
            
            if sample_count = numSamples then
          		ready <= '1';
                sample_count := 0;
                q0 := (others => '0');
                magnitude_var := resize(real_part_v * real_part_v + img_part_v * img_part_v, 2*N_bits);
            	magnitude <= std_logic_vector(magnitude_var(N_bits-1 downto 0));
                real_part <= std_logic_vector(real_part_v);
            	img_part <= std_logic_vector(img_part_v);
            end if;

            q0_s <= q0;
            q1_s <= q1;
            q2_s <= q2;
        end if;
    end process;
end Behavioral;
