----------------------------------------------------------------------------------
-- Company: Thayer School of Engineering at Dartmouth
-- Engineers: Jake Twarog & Alan Sun
-- 
-- Create Date: 05/23/2022 01:19:46 PM
-- Module Name: WordleTopLevel - Behavioral
-- 
-- Revision: 1.0
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WordleTopLevel is
    Port (  clk   : in std_logic
            ena   : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(39 DOWNTO 0));
end WordleTopLevel;

architecture Structural of WordleTopLevel is

-- Block ROM
component blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(39 DOWNTO 0));
END component;

--signal clka, ena: std_logic := '0';
--signal addra: std_logic_vector := (others => '0');
--signal douta: std_logic_vector := (others => '0');

begin

    WordleStorage: blk_mem_gen_0
        port map (
            clka => clk;
            ena => ena;
            addra => addra;
            douta => douta);
               


end Structural;
