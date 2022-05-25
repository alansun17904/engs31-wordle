----------------------------------------------------------------------------------
-- Company: Thayer School of Engineering at Dartmouth
-- Engineers: Jake Twarog & Alan Sun
-- 
-- Create Date: 05/23/2022 01:19:46 PM
-- Module Name: WordROM - Behavioral
-- 
-- Revision: 1.0
----------------------------------------------------------------------------------

-- Is this even necessary??

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WordROM is
    Port (  clk: in std_logic;
            we, re: in std_logic;
            addr, din: in std_logic_vector(7 downto 0);
            dout: out std_logic_vector(7 downto 0));
end WordROM;

architecture Behavioral of WordROM is

begin


end Behavioral;
