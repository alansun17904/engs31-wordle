----------------------------------------------------------------------------------
-- Company: Thayer School of Engineering at Dartmouth
-- Engineers: Jake Twarog & Alan Sun
-- 
-- Create Date: 05/23/2022 01:19:46 PM
-- Module Name: WordleLogic - Behavioral
-- 
-- Revision: 1.0
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity WordleLogic is
port(   clk         :   in std_logic;
        input_val   :   in std_logic_vector(6 downto 0)); -- ASCII value of the entered character
end WordleLogic;
architecture Behavioral of WordleLogic is

begin


end Behavioral;
