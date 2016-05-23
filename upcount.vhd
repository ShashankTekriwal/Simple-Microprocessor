----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:04:37 04/15/2016 
-- Design Name: 
-- Module Name:    upcount - Behavioral 
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
USE ieee.std_logic_unsigned.all ;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY upcount IS
	PORT ( Clear, Clock : IN STD_LOGIC ;
		Q : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
END upcount ;
ARCHITECTURE Behavior OF upcount IS
BEGIN
	upcount: PROCESS ( Clock )
	BEGIN
		IF (Clock'EVENT AND Clock = '1') THEN
			IF Clear = '1' THEN
				Q <= "00" ;
			ELSE
				Q <= Q + '1' ;
			END IF ;
		END IF;
	END PROCESS;
END Behavior ;

