library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;

entity EthBaseRegMap is
   generic (
      Version : std_logic_vector(31 downto 0) := x"0000_0000"
   );
   port (
      clk         : in std_logic;
      rst         : in std_logic;
      
      -- interface to AXI slave module
      addr        : in  std_logic_vector(31 downto 0);
      rdata       : out std_logic_vector(31 downto 0);
      wdata       : in  std_logic_vector(31 downto 0);
      req         : in  std_logic;
      wen         : in  std_logic;
      ack         : out std_logic;

      -- byte data IO
      data_in    : in  std_logic_vector(7 downto 0);
      data_out   : out std_logic_vector(7 downto 0); -- how many bytes to accept
      one_wire_data : in std_logic_vector(63 downto 0)
   );
end entity EthBaseRegMap;

architecture behav of EthBaseRegMap is

   -- select addr subspace
   signal a_reg_addr : std_logic_vector(8 downto 0) := x"00"& '0';
   signal scratch_word : std_logic_vector(31 downto 0) := x"05a7cafe";

begin

   a_reg_addr <= addr(10 downto 2);

   process (clk)

   begin
      if rising_edge (clk) then

         -- defaults
         ack   <= req;
         data_out <= (others => '0');

         -- reg mapping
         case to_integer(unsigned(a_reg_addr)) is

            -- reg info
            when 0 =>
               if wen = '1' and req = '1' then
                  scratch_word <= wdata;
               else
                  rdata <= scratch_word;
               end if;

            when 1 =>
               if wen = '1' and req = '1' then
                  data_out <= wdata(7 downto 0);
               else
                  rdata(7 downto 0) <= data_in;
               end if;

            when 2 =>
               rdata <= one_wire_data(31 downto 0);

            when 3 =>
               rdata <= one_wire_data(63 downto 32);

            when others =>
               rdata <= x"aBAD_ADD0";

         end case;

      end if;
         
   end process;

end behav;
