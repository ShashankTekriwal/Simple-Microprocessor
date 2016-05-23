----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:09:28 04/15/2016 
-- Design Name: 
-- Module Name:    trin - Behavioral 
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

ENTITY trin IS
	GENERIC ( N : INTEGER := 8);
	PORT ( X : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	E : IN STD_LOGIC ;
	F : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
END trin ;
ARCHITECTURE Behavior OF trin IS
BEGIN
	F <= (OTHERS => 'Z') WHEN E = '0' ELSE X ;
END Behavior ;
