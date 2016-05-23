----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:53 04/15/2016 
-- Design Name: 
-- Module Name:    dec2to4 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY dec2to4 IS
	PORT ( w : IN STD_LOGIC_VECTOR(1 DOWNTO 0) ;
	En : IN STD_LOGIC ;
	y : OUT STD_LOGIC_VECTOR(0 TO 3) ) ;
END dec2to4 ;
ARCHITECTURE Behavior OF dec2to4 IS
SIGNAL Enw : STD_LOGIC_VECTOR(2 DOWNTO 0) ;
BEGIN
	Enw <= En & w ;
	WITH Enw SELECT
		y <= "1000" WHEN "100",
			"0100" WHEN "101",
			"0010" WHEN "110",
			"0001" WHEN "111",
			"0000" WHEN OTHERS ;
END Behavior ;

