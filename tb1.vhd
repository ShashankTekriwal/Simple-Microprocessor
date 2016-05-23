--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:08:56 04/16/2016
-- Design Name:   
-- Module Name:   C:/Users/Shashank/Desktop/HPS/vhdl/SimpleProc2/tb1.vhd
-- Project Name:  SimpleProc2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: proc
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb1 IS
END tb1;
 
ARCHITECTURE behavior OF tb1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT proc
    PORT(
         Data : IN  std_logic_vector(7 downto 0);
         Reset : IN  std_logic;
         w : IN  std_logic;
         Clock : IN  std_logic;
         F : IN  std_logic_vector(1 downto 0);
         Rx : IN  std_logic_vector(1 downto 0);
         Ry : IN  std_logic_vector(1 downto 0);
         Done : BUFFER  std_logic;
         BusWires : INOUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Data : std_logic_vector(7 downto 0) := (others => '0');
   signal Reset : std_logic := '0';
   signal w : std_logic := '0';
   signal Clock : std_logic := '0';
   signal F : std_logic_vector(1 downto 0) := (others => '0');
   signal Rx : std_logic_vector(1 downto 0) := (others => '0');
   signal Ry : std_logic_vector(1 downto 0) := (others => '0');

	--BiDirs
   signal BusWires : std_logic_vector(7 downto 0);

 	--Outputs
   signal Done : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: proc PORT MAP (
          Data => Data,
          Reset => Reset,
          w => w,
          Clock => Clock,
          F => F,
          Rx => Rx,
          Ry => Ry,
          Done => Done,
          BusWires => BusWires
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 100 ns;	

      wait for Clock_period*2;

      -- insert stimulus here
		Data <= "10101010";
		w <= '1';
		F <= "00";
		Rx <= "01";
		Ry <= "00";
		wait for 20 ns;
		
		w <= '0';
		wait for 20 ns;
		
		Data <= "11001100";
		Rx <= "00";
		F <= "00";
		w <= '1';
		wait for 20 ns;
		
		w <= '0';
		wait for 20 ns;
		
		F <= "01";
		Rx <= "11";
		Ry <= "01";
		w <= '1';
		wait for 20 ns;
		
		w <= '0';
		wait for 20 ns;
		
		F <= "10";
		Rx <= "00";
		Ry <= "01";
		w <= '1';
		wait for 20 ns;
		
		w <= '0';
      wait;
   end process;

END;
