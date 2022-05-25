----------------------------------------------------------------------------------
-- Company: Thayer School of Engineering at Dartmouth
-- Engineers: Jake Twarog & Alan Sun
-- 
-- Create Date: 05/23/2022 01:19:46 PM
-- Module Name: SCITRansmitter - Behavioral
-- 
-- Revision: 1.0
-- Originally: Homework 5-1
----------------------------------------------------------------------------------

-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY SCI_Tx IS
PORT ( 	clk			: 	in 	STD_LOGIC;
		Parallel_in	: 	in 	STD_LOGIC_VECTOR(7 downto 0);
        New_data	:	in	STD_LOGIC;
        Tx			:	out STD_LOGIC);
end SCI_Tx;

ARCHITECTURE behavior of SCI_Tx is

constant BAUD_PERIOD: integer := 868; --Number of clock cycles needed to achieve the correct baud rate

type regfile is array(0 to 7) of std_logic_vector(7 downto 0);
signal queue_reg: regfile:= ((others => '0'),(others => '0'),(others => '0'),(others => '0'),(others => '0'),(others => '0'),(others => '0'),(others => '0'));
signal empty, full: std_logic := '0';
signal front, rear: unsigned(2 downto 0) := "000";
signal queuecounter: unsigned(3 downto 0) := "0000";

signal Parallel_transfer: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
signal Shift_Reg: std_logic_vector(9 downto 0) := (others => '1');
signal Baud_Counter: unsigned(8 downto 0) := (others => '0'); -- 9 bits are needed to represent 391.
signal bit_count: integer := 9;

signal shift_en, load_en: std_logic := '0';

BEGIN

-- Non-queue processes --
baud_counter_proc: process(clk)
begin
	if rising_edge(clk) then
    	
        --Baud Counter
        shift_en <= '0';
        Baud_Counter <= Baud_Counter + 1;
        if (Baud_Counter = BAUD_PERIOD-1) then
        	shift_en <= '1';
            Baud_Counter <= (others => '0');
        end if;
    end if;
end process baud_counter_proc;

shift_register: process(clk, shift_en)
begin
    --Shift Register
    if rising_edge(clk) then  
        if load_en = '1' AND bit_count = 10 then
        	Shift_Reg <= '1' & Parallel_transfer & '0'; -- Concatenate the start and stop bits
            bit_count <= 0;
        elsif shift_en = '1' then
        	Shift_Reg <= '1' & Shift_Reg(9 downto 1); --shift the bits and add an idle bit to the MSB 
            bit_count <= bit_count + 1;
        end if;
	end if;
end process shift_register;

-- Queue processes --
queue_storage: process(clk)
begin
	if rising_edge(clk) then
  		if full = '0' AND new_data = '1' then
        	queue_reg( to_integer(unsigned(rear)) ) <= Parallel_in;
        end if;
    end if;
end process;

queue_retrieval: process(front, queue_reg)
begin
	Parallel_transfer <= queue_reg( to_integer(unsigned(front)) );
end process queue_retrieval;

empty_full_proc: process(queuecounter)
begin
	empty <= '0';
    full <= '0';
    if queuecounter = 0 then
        empty <= '1';
    elsif queuecounter = 8 then 
        full <= '1';
    end if;
end process empty_full_proc;

queue_tracker: process(clk, bit_count, new_data)
begin
	if rising_edge(clk) then
    	if empty = '0' AND bit_count = 9 then
            load_en <= '1';
        	if shift_en = '1' then
				front <= front + 1;
            	queuecounter <= queuecounter - 1;
            end if;
        else
        	load_en <= '0';
        end if;
   		if full = '0' AND new_data = '1' then
        	rear <= rear + 1;
            queuecounter <= queuecounter + 1;
        end if;
    end if;
end process queue_tracker;

-- Lastly, our output is asynchronous and purely based off what has been shifted out.
Tx <= Shift_Reg(0);

end behavior;