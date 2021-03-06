----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:46:48 04/16/2016 
-- Design Name: 
-- Module Name:    proc - Behavioral 
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
USE ieee.std_logic_signed.all ;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY proc IS
	PORT ( Data : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;
		Reset, w : IN STD_LOGIC ;
		Clock : IN STD_LOGIC ;
		F, Rx, Ry : IN STD_LOGIC_VECTOR(1 DOWNTO 0) ;
		Done : BUFFER STD_LOGIC ;
		BusWires : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
END proc ;


ARCHITECTURE Behavior OF proc IS

SIGNAL X, Y, Rin, Rout : STD_LOGIC_VECTOR(0 TO 3) ;
SIGNAL Clear, High, AddSub : STD_LOGIC ;
SIGNAL Extern, Ain, Gin, Gout, FRin : STD_LOGIC ;
SIGNAL Count, Zero, T, I : STD_LOGIC_VECTOR(1 DOWNTO 0) ;
SIGNAL R0, R1, R2, R3 : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
SIGNAL A, Sum, G : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
SIGNAL Func, FuncReg, Sel : STD_LOGIC_VECTOR(1 TO 6) ;

COMPONENT regn
	GENERIC ( N : INTEGER := 8);
	PORT ( R : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
		Rin, Clock : IN STD_LOGIC ;
		Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
END COMPONENT ;

COMPONENT trin
	GENERIC ( N : INTEGER := 8);
	PORT ( X : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	E : IN STD_LOGIC ;
	F : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
END COMPONENT ;

COMPONENT upcount
	PORT ( Clear, Clock : IN STD_LOGIC ;
		Q : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
END COMPONENT;

COMPONENT dec2to4
	PORT ( w : IN STD_LOGIC_VECTOR(1 DOWNTO 0) ;
	En : IN STD_LOGIC ;
	y : OUT STD_LOGIC_VECTOR(0 TO 3) ) ;
END COMPONENT ;

BEGIN
	Zero <= "00" ; High <= '1' ;
	Clear <= Reset OR Done OR (NOT w AND NOT T(1) AND NOT T(0)) ;
	counter: upcount PORT MAP ( Clear, Clock, Count ) ;
	T <= Count ;
	Func <= F & Rx & Ry ;
	FRin <= w AND NOT T(1) AND NOT T(0) ;
	functionreg: regn GENERIC MAP ( N => 6 )
		PORT MAP ( Func, FRin, Clock, FuncReg ) ;
	I <= FuncReg(1 TO 2) ;
	decX: dec2to4 PORT MAP ( FuncReg(3 TO 4), High, X ) ;
	decY: dec2to4 PORT MAP ( FuncReg(5 TO 6), High, Y ) ;
	controlsignals: PROCESS ( T, I, X, Y )
	BEGIN
		Extern <= '0' ; Done <= '0' ; Ain <= '0' ; Gin <= '0' ;
		Gout <= '0' ; AddSub <= '0' ; Rin <= "0000" ; Rout <= "0000" ;
		CASE T IS WHEN "00" => -- no signals asserted in time step T0
			WHEN "01" => -- define signals asserted in time step T1
				CASE I IS
					WHEN "00" => -- Load
						Extern <= '1' ; Rin <= X ; Done <= '1' ;
					WHEN "01" => -- Move
						Rout <= Y ; Rin <= X ; Done <= '1' ;
					WHEN OTHERS => -- Add, Sub
						Rout <= X ; Ain <= '1' ;
				END CASE ;
			WHEN "10" => -- define signals asserted in time step T2
				CASE I IS
					WHEN "10" => -- Add
						Rout <= Y ; Gin <= '1' ;
					WHEN "11" => -- Sub
						Rout <= Y ; AddSub <= '1' ; Gin <= '1' ;
					WHEN OTHERS => -- Load, Move
				END CASE ;
			WHEN OTHERS => -- define signals asserted in time step T3
				CASE I IS
					WHEN "00" => -- Load
					WHEN "01" => -- Move
					WHEN OTHERS => -- Add, Sub
						Gout <= '1' ; Rin <= X ; Done <= '1' ;
				END CASE ;
		END CASE ;
	END PROCESS ;
	reg0: regn PORT MAP ( BusWires, Rin(0), Clock, R0 ) ;
	reg1: regn PORT MAP ( BusWires, Rin(1), Clock, R1 ) ;
	reg2: regn PORT MAP ( BusWires, Rin(2), Clock, R2 ) ;
	reg3: regn PORT MAP ( BusWires, Rin(3), Clock, R3 ) ;
	regA: regn PORT MAP ( BusWires, Ain, Clock, A ) ;
	alu: WITH AddSub SELECT
		Sum <= A + BusWires WHEN '0',
		A - BusWires WHEN OTHERS ;
	regG: regn PORT MAP ( Sum, Gin, Clock, G ) ;
	Sel <= Rout & Gout & Extern ;
	WITH Sel SELECT
		BusWires <= R0 WHEN "100000",
		R1 WHEN "010000",
		R2 WHEN "001000",
		R3 WHEN "000100",
		G WHEN "000010",
		Data WHEN OTHERS ;
END Behavior ;