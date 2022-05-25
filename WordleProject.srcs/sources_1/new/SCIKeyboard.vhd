----------------------------------------------------------------------------------
-- Company: Thayer School of Engineering at Dartmouth
-- Engineers: Jake Twarog & Alan Sun
-- 
-- Create Date: 05/23/2022 01:19:46 PM
-- Module Name: WordleTest1 - Behavioral
-- 
-- Revision: 0.1
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SCIKeyboard is
    Port (clk         :   in std_logic);
end SCIKeyboard;

architecture Behavioral of SCIKeyboard is
-- State signals
type state_type is (idle, wait_half_tc, shift1, wait_tc, shift2, data_ready);
signal current_state, next_state: state_type := idle;

-- Shift register (courtesy of Exercise 20)
constant BAUD_PERIOD : integer := 868; -- 115200 baud

signal Shift_Reg : std_logic_vector(9 downto 0) := (others => '1');
signal Baud_Counter : unsigned(8 downto 0) := (others => '0'); -- 9 bits are needed to represent 391.
signal tc : std_logic := '0';

begin

-- We will start by designing the finite state machine, including its state update process.
    state_update: process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process state_update;
    
    nextstatelogic: process(current_state)
    begin
        -- First, we must declare any defaults.
        next_state <= current_state;
        
        --case current_state is
            
            -- when idle =>
                -- if Rx    
        --end case;
    end process nextstatelogic;
    
    -- Used courtesy of Exercise 20.
    
    datapath: process(clk)
    begin
        if rising_edge(clk) then
            
            --Baud Counter
            tc <= '0';
            Baud_Counter <= Baud_Counter + 1;
            if (Baud_Counter = BAUD_PERIOD-1) then
                tc <= '1';
                Baud_Counter <= (others => '0');
            end if;
            if (New_data = '1') then
                Baud_Counter <= (others => '0');
            end if;
            
            --Shift Register (TRANSMITTER - NOT RECEIVER YET)
            if (New_data = '1') then
                Shift_Reg <= '1' & Parallel_in & '0'; -- Concatenate the start and stop bits
            
            elsif (tc = '1') then
                Shift_Reg <= '1' & Shift_Reg(9 downto 1); --shift the bits and add an idle bit to the MSB 
            end if;
                    
            
        end if;
    end process datapath;  

end Behavioral;
