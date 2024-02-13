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

      -- QDA config signals
      TxDisable : out std_logic_vector(3 downto 0);
      IntSoft   : out std_logic;
      IntHard   : out std_logic;
      DigReset  : out std_logic;

      -- QDA debug signals
      dFsmState    : in std_logic_vector(2 downto 0);
      dLocFifoFull : in std_logic;
      dExtFifoFull : in std_logic;
      dRxBusy      : in std_logic;
      dRxValid     : in std_logic;
      dRxError     : in std_logic;
      dTxBusy      : in std_logic;
      dDataValid   : in std_logic
   );
end entity EthBaseRegMap;

architecture behav of EthBaseRegMap is

   -- select addr subspace
   signal a_reg_addr   : std_logic_vector(8 downto 0)  := x"00"& '0';
   signal scratch_word : std_logic_vector(31 downto 0) := x"05a7cafe";
   signal pulseLen : std_logic_vector(31 downto 0) := (others => '0');

   -- debug input signals
   signal s_TxDisable   : std_logic_vector(3 downto 0);

   type debugIn is record
      dFsmState    : std_logic_vector(2 downto 0);
      dLocFifoFull : std_logic;
      dExtFifoFull : std_logic;
      dRxBusy      : std_logic;
      dRxValid     : std_logic;
      dRxError     : std_logic;
      dTxBusy      : std_logic;
      dDataValid   : std_logic;
   end record debugIn; -- 10 bits

   signal rDebugIn : debugIn;

  -- helper function to pack input signal values into the rdata value
  function readDebug (
     signal d : debugIn)
      return std_logic_vector
     is
     begin
      -- return a 32 bit value
      return x"00000" & "00" & d.dFsmState & d.dLocFifoFull
                      & d.dExtFifoFull & d.dRxBusy & d.dRxValid &d.dRxError  &d.dTxBusy & d.dDataValid;
     end function;

   type pulseDebugOut is record
      IntSoft  : std_logic;
      IntHard  : std_logic;
      DigReset : std_logic;
   end record pulseDebugOut;  -- 3 Bits

   constant pulseDebugOut_C     : pulseDebugOut := (IntSoft => '0', IntHard => '0', Digreset => '0');
   constant pulseDebugOut_Soft  : pulseDebugOut := (IntSoft => '1', IntHard => '0', Digreset => '0');
   constant pulseDebugOut_Hard  : pulseDebugOut := (IntSoft => '0', IntHard => '1', Digreset => '0');
   constant pulseDebugOut_Reset : pulseDebugOut := (IntSoft => '0', IntHard => '0', Digreset => '1');

   signal rDebugOut         : pulseDebugOut := pulseDebugOut_C;

begin

   -- read inputs into record
   rDebugIn.dFsmState    <= dFsmState;
   rDebugIn.dLocFifoFull <= dLocFifoFull;
   rDebugIn.dExtFifoFull <= dExtFifoFull;
   rDebugIn.dRxBusy      <= dRxBusy;
   rDebugIn.dRxValid     <= dRxValid;
   rDebugIn.dRxError     <= dRxError;
   rDebugIn.dTxBusy      <= dTxBusy;
   rDebugIn.dDataValid   <= dDataValid;

   -- send outputs
   IntSoft  <= rDebugOut.IntSoft;
   IntHard  <= rDebugOut.IntHard;
   DigReset <= rDebugOut.DigReset;

   a_reg_addr <= addr(10 downto 2);

   -- reg signals assined to ports
   TxDisable <= s_TxDisable;

   process (clk, s_TxDisable, rDebugOut, rDebugIn)
      variable count : std_logic_vector(31 downto 0) := (others => '0');
   begin
      if rising_edge (clk) then


         -- defaults
         ack   <= req;
         count := count + 1;

         -- reg mapping
         case to_integer(unsigned(a_reg_addr)) is

            -- scratchpad IO
            when 0 =>
               if wen = '1' and req = '1' then
                  scratch_word <= wdata;
               else
                  rdata <= scratch_word;
               end if;

            -- set TxDisable
            when 1 =>
               if wen = '1' and req = '1' then
                  s_TxDisable <= wdata(3 downto 0);
               else
                  rdata(3 downto 0) <= s_TxDisable;
               end if;

            -- set pulse len
            when 2 =>
               if wen = '1' and req = '1' then
                  pulseLen <= wdata;
               else
                  rdata <= pulseLen;
               end if;

            -- read debug
            when 3 =>
               rdata <= readDebug(rDebugIn);

            -- send debug pulses
            when 4 =>
               -- make sure to reset counter on update
               count := (others => '0');
               case to_integer(unsigned(wdata)) is
                  when 1 =>
                     rDebugOut <= pulseDebugOut_Soft;
                  when 2 =>
                     rDebugOut <= pulseDebugOut_Hard;
                  when 3 =>
                     rDebugOut <= pulseDebugOut_Reset;
                  when others =>
                     rDebugOut <= pulseDebugOut_C;
               end case;

            when others =>
               rdata <= x"aBAD_ADD0";

         end case;

         -- reset the counter and pulse
         if count >= pulseLen then
            count := (others => '0');
            rDebugOut <= pulseDebugOut_C;
         end if;

      end if;
         
   end process;

end behav;
