----------------------------------------------------------------------------------
-- Company: Thayer School of Engineering at Dartmouth
-- Engineer: Jake Twarog
-- 
-- Create Date: 05/23/2022 01:19:46 PM
-- Module Name: WordleTest1 - Behavioral
-- 
-- Revision: 1.0
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity WordleTest1 is
port(   clk         :   in std_logic;
        input_val   :   in std_logic_vector(6 downto 0)); -- ASCII value of the entered character
end WordleTest1;

architecture Behavioral of WordleTest1 is
-- State signals
type state_type is (enter_letter, display, validate, validate_check, eval_1, eval_2, eval_check, win, lose);
signal current_state, next_state: state_type := enter_letter;

-- Counting signals
signal char_count: unsigned(2 downto 0) := "000";
signal char_count_en: std_logic := '0';

-- Validation signals
signal valid, valid_word_en: std_logic := '0';

-- Evaluation signals
signal guess_count: unsigned(2 downto 0) := "000";
signal guess_count_en, eval_1_en, eval_2_en: std_logic := '0';
signal word_right: std_logic := '0';
signal win_en, lose_en: std_logic := '0';

begin

    -- We will start by designing the finite state machine, including its state update process.
    state_update: process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process state_update;
    
    -- For the next state logic of the top-level state machine:
    nextstatelogic: process(current_state)
    begin
        -- First, we must declare any defaults.
        next_state <= current_state;
        char_count_en <= '0';
        valid_word_en <= '0';
        guess_count_en <= '0';
        eval_1_en <= '0';
        eval_2_en <= '0';
        win_en <= '0';
        lose_en <= '0';
        
        case (current_state) is
        
            when enter_letter =>
                if unsigned(input_val) > 96 AND 123 > unsigned(input_val) then   -- decimal values
                    next_state <= display;
                end if;

            when display =>
                if char_count = 5 then
                    next_state <= validate;
                else
                    next_state <= enter_letter;
                end if;
                char_count_en <= '1'; -- not sure if this is in exactly the right spot in this case - discuss?
           
            when validate =>
                valid_word_en <= '1'; -- enables validation process elsewhere
                
            when validate_check =>
                if valid = '1' then
                    next_state <= eval_1;
                else
                    next_state <= enter_letter;
                    -- char_count <= 0;    -- does this go here as well?
                end if;
            
            when eval_1 => -- first pass
                guess_count_en <= '1';
                eval_1_en <= '1';
            
            when eval_2 => -- second pass
                eval_2_en <= '1';
                
            when eval_check =>
                if word_right = '1' then
                    next_state <= win;
                elsif word_right = '0' AND guess_count = 5 then     -- guesses counting up from zero
                    next_state <= lose;
                else
                    next_state <= enter_letter;
                end if;
            
            when win =>
                win_en <= '1';
                next_state <= enter_letter;
                
            when lose =>
                lose_en <= '1';
                next_state <= enter_letter;
            
            when others =>
                next_state <= enter_letter;
                
            end case;
       end process nextstatelogic;

end Behavioral;
