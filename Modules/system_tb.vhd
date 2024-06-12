library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

--test bench component
entity system_tb is
end system_tb ;

architecture Behavioral of system_tb is
	component system is
		generic (
          		N : integer;
			freq_sample:integer
      			);
      	port (
          	clk : in std_logic;
          	rst : in std_logic;
          	input : in unsigned (11 downto 0);
          	magnitude : out signed(19 downto 0);
          	real_out : out signed(19 downto 0);
          	imaginary : out signed(19 downto 0)
      		);
  	end component system;

  	signal clk : std_logic := '0';	
	signal rst : std_logic := '0';
  	signal data_signal : unsigned(11 downto 0);
  	signal magnitude : signed(19 downto 0); 
  	signal real_out : signed(19 downto 0); 
  	signal imaginary : signed(19 downto 0); 
	constant N_value : integer := 135;
	constant freq_sample_value: integer := 4000000;

	begin
  		DUT: system
  			generic map(
    				N => N_value,
    				freq_sample => freq_sample_value
  			)
  		port map (
    			clk => clk, 
    			rst => rst, 
    			input => data_signal, 
    			magnitude => magnitude, 
    			real_out => real_out, 
    			imaginary => imaginary
  			);

  		clk_gen: process 
			begin
    				clk <= '0';
    				wait for 500 ns;
    				clk <= '1';
    				wait for 500 ns;
  			end process;

  	process
    		variable line_hex : line;
    		file input_file : text;
    		variable input_bit : unsigned(11 downto 0);

  		begin
    			file_open(input_file, "signals_rect_ones.txt", read_mode);
    			while not endfile(input_file) loop
				readline(input_file, line_hex);
      				hread(line_hex, input_bit);
      				report "input_bit: " & to_hstring(input_bit);
      				if input_bit = 1 then
        				rst <= '1';
      				else
        				rst <= '0';
        				data_signal <= resize(input_bit, data_signal'length);
      				end if;
      				wait until rising_edge(clk);
    			end loop;
    			file_close(input_file);
   			 wait;
  		end process;
end architecture;