--------------------------------------------------------------------------------
--
-- LAB #4
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity ALU is
	Port(	DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		ALUCtrl: in std_logic_vector(4 downto 0);
		Zero: out std_logic;
		ALUResult: out std_logic_vector(31 downto 0) );
end entity ALU;

architecture ALU_Arch of ALU is
	-- ALU components	
	component adder_subtracter
		port(	datain_a: in std_logic_vector(31 downto 0);
			datain_b: in std_logic_vector(31 downto 0);
			add_sub: in std_logic;
			dataout: out std_logic_vector(31 downto 0);
			co: out std_logic);
	end component adder_subtracter;

	component shift_register
		port(	datain: in std_logic_vector(31 downto 0);
		   	dir: in std_logic;
			shamt:	in std_logic_vector(4 downto 0);
			dataout: out std_logic_vector(31 downto 0));
	end component shift_register;
	
	signal sum: std_logic_vector(31 downto 0);
	signal shiftget: std_logic_vector(31 downto 0);
	signal carryhold: std_logic;
	signal sumcheck, shiftcheck, andcheck, orcheck: std_logic;
begin
	-- Add ALU VHDL implementation here
	addsub: adder_subtracter port map (
		datain_a => DataIn1,
		datain_b => DataIn2,
		add_sub => ALUCtrl(4),
		dataout => sum,
		co => carryhold
	);

	shifter: shift_register port map (
		datain => DataIn1,
		shamt => DataIn2(4 downto 0),
		dir => ALUCtrl(4),
		dataout => shiftget
	);
	
	with ALUCtrl(3 downto 0) select
	ALUResult <= sum when "0000",
		     DataIn1 AND DataIn2 when "0001",
		     DataIn1 OR DataIn2 when "0010",
		     shiftget when "0011",
		     DataIn2 when "0100",
		     (others => 'Z') when others;

	sumcheck <= '1' when sum = "00000000000000000000000000000000" else
		    '0';

	andcheck <= '1' when (DataIn1 AND DataIn2) = "00000000000000000000000000000000" else
		    '0';

	orcheck <= '1' when (DataIn1 OR DataIn2) = "00000000000000000000000000000000" else
		   '0';

	shiftcheck <= '1' when shiftget = "00000000000000000000000000000000" else
		      '0';

	with ALUCtrl(3 downto 0) select
	Zero <=  sumcheck when "0000",
		 andcheck when "0001",
		 orcheck when "0010",
		 shiftcheck when "0011",
		 'Z' when others;

end architecture ALU_Arch;


