--------------------------------------------------------------------------------
--
-- LAB #3
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	reg8a: bitstorage PORT MAP (
		bitin => datain(0),
		enout => enout,
		writein => writein,
		bitout => dataout(0)
	);

	reg8b: bitstorage PORT MAP (
		bitin => datain(1),
		enout => enout,
		writein => writein,
		bitout => dataout(1)
	);

	reg8c: bitstorage PORT MAP (
		bitin => datain(2),
		enout => enout,
		writein => writein,
		bitout => dataout(2)
	);

	reg8d: bitstorage PORT MAP (
		bitin => datain(3),
		enout => enout,
		writein => writein,
		bitout => dataout(3)
	);

	reg8e: bitstorage PORT MAP (
		bitin => datain(4),
		enout => enout,
		writein => writein,
		bitout => dataout(4)
	);

	reg8f: bitstorage PORT MAP (
		bitin => datain(5),
		enout => enout,
		writein => writein,
		bitout => dataout(5)
	);

	reg8g: bitstorage PORT MAP (
		bitin => datain(6),
		enout => enout,
		writein => writein,
		bitout => dataout(6)
	);

	reg8h: bitstorage PORT MAP (
		bitin => datain(7),
		enout => enout,
		writein => writein,
		bitout => dataout(7)
	);
		
end architecture memmy;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	component register8
		port(datain: in std_logic_vector(7 downto 0);
		     enout:  in std_logic;
		     writein: in std_logic;
		     dataout: out std_logic_vector(7 downto 0));
	end component;
	signal out16, out8, write16, write8 : std_logic;
begin
	out8 <= (enout8 and enout16 and enout32);
	out16 <= (enout16 and enout32);
	write8 <= (writein8 or writein16 or writein32);
	write16 <= (writein16 or writein32);
	reg32a: register8 PORT MAP (
		datain(7 downto 0) => datain(7 downto 0),
		enout => out8,
		writein => write8,
		dataout(7 downto 0) => dataout(7 downto 0)
	);
		
	reg32b: register8 PORT MAP (
		datain(7 downto 0) => datain(15 downto 8),
		enout => out16,
		writein => write16,
		dataout(7 downto 0) => dataout(15 downto 8)
	);

	reg32c: register8 PORT MAP (
		datain(7 downto 0) => datain(23 downto 16),
		enout => enout32,
		writein => writein32,
		dataout(7 downto 0) => dataout(23 downto 16)
	);

	reg32d: register8 PORT MAP (
		datain(7 downto 0) => datain(31 downto 24),
		enout => enout32,
		writein => writein32,
		dataout(7 downto 0) => dataout(31 downto 24)
	);

end architecture biggermem;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic;
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is
	component fulladder
		port (a : in std_logic;
	          b : in std_logic;
	          cin : in std_logic;
	          sum : out std_logic;
	          carry : out std_logic
	         );
	end component;
	signal temp : std_logic_vector (31 downto 0);
	signal carrynum : std_logic_vector (31 downto 0);
	signal carryout : std_logic_vector (31 downto 0);
	
begin
	temp <= datain_b when add_sub='0' else
		not datain_b;
	comp0: fulladder PORT MAP (datain_a(0), temp(0), add_sub, dataout(0), carrynum(0));
	gen_addtract: for n in 1 to 30 generate
		comp: fulladder PORT MAP (datain_a(n), temp(n), carrynum(n-1), dataout(n), carrynum(n));
	end generate gen_addtract;
	comp31: fulladder PORT MAP (datain_a(31), temp(31), carrynum(30), dataout(31), co);

end architecture calc;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
	signal shiftnum : integer range 0 to 3;
begin
	shiftnum <= 0 when shamt(1 downto 0)="00" ELSE
		    1 when shamt(1 downto 0)="01" ELSE
		    2 when shamt(1 downto 0)="10" ELSE
		    3;
	process(shiftnum)
	begin
		if dir='0' then
			dataout <= (others => '0');
			dataout(31 downto shiftnum) <= datain(31-shiftnum downto 0);
		else
			dataout <= (others => '0');
			dataout(31-shiftnum downto 0) <= datain(31 downto shiftnum);
		end if;
	end process;
end architecture shifter;



