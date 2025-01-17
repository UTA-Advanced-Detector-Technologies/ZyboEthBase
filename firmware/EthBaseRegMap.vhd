library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;

entity EthBaseRegMap is
   generic (
      N_QDA_PORTS : natural := 4;
		constant SPI_REGISTER_WIDTH : integer := 16; -- 12 DAC and 2 SW power down
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

      -- SPI Ctrl
      SPI_SCLK : out std_logic;
      SPI_PCLK : out std_logic;
      SPI_SRST : out std_logic;
      SPI_SIN  : out std_logic;

      -- QDA Node values
      QDAByte         : out std_logic_vector(63 downto 0);
      QDASend         : out std_logic;
      QDAMask         : out std_logic_vector(N_QDA_PORTS - 1 downto 0);
      QDAPacketLength : out std_logic_vector(31 downto 0);
      QDA_fifo_hits   : in  std_logic_vector(31 downto 0);
      QDA_fifo_valid  : in  std_logic;
      QDA_fifo_empty  : in  std_logic;
      QDA_fifo_full   : in  std_logic;
      QDA_fifo_ren    : out std_logic;

      -- QDA config signals
      EndeavorScale : out std_logic_vector(2 downto 0);
      TxDisable     : out std_logic_vector(3 downto 0);
      IntSoft       : out std_logic;
      IntHard       : out std_logic;
      DigReset      : out std_logic;

      -- QDA debug signals
      dFsmState    : in std_logic_vector(2 downto 0);
      dLocFifoFull : in std_logic;
      dExtFifoFull : in std_logic;
      dRxBusy      : in std_logic;
      dRxError     : in std_logic;
      dTxBusy      : in std_logic
   );
end entity EthBaseRegMap;

architecture behav of EthBaseRegMap is

   -- select addr subspace
   signal a_reg_addr   : std_logic_vector(8 downto 0)  := x"00"& '0';
   signal scratch_word : std_logic_vector(31 downto 0) := x"05a7cafe";
   signal pulseLen : std_logic_vector(31 downto 0) := (others => '0');

   -- debug input signals
   signal s_TxDisable   : std_logic_vector(3 downto 0);
   signal s_EndeavorScale   : std_logic_vector(2 downto 0);

   type debugIn is record
      dFsmState    : std_logic_vector(2 downto 0);
      dLocFifoFull : std_logic;
      dExtFifoFull : std_logic;
      dRxBusy      : std_logic;
      dRxError     : std_logic;
      dTxBusy      : std_logic;
   end record debugIn; -- 10 bits

   signal rDebugIn : debugIn;

  -- helper function to pack input signal values into the rdata value
  function readDebug (
     signal d : debugIn)
      return std_logic_vector
     is
     begin
      -- return a 32 bit value
      return x"000000" & d.dFsmState & d.dLocFifoFull
                       & d.dExtFifoFull & d.dRxBusy &d.dRxError  &d.dTxBusy;
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

   -- DAC registers
   constant REG_LOAD_PERIOD_C  : std_logic_vector(15 downto 0) := x"0000";
   constant REG_LATCH_PERIOD_C : std_logic_vector(15 downto 0) := x"0004";
   signal reg_load_period  : std_logic_vector(15 downto 0) := REG_LOAD_PERIOD_C;
   signal reg_latch_period : std_logic_vector(15 downto 0) := REG_LATCH_PERIOD_C;
   constant ZERO_C             : std_logic := '0';

   signal iPclk    : std_logic               := '0';
   signal iUpdate  : std_logic               := '0';
   signal iRegData : std_logic_vector(SPI_REGISTER_WIDTH - 1 downto 0) := (others => '0');

begin

   -- read inputs into record
   rDebugIn.dFsmState    <= dFsmState;
   rDebugIn.dLocFifoFull <= dLocFifoFull;
   rDebugIn.dExtFifoFull <= dExtFifoFull;
   rDebugIn.dRxBusy      <= dRxBusy;
   rDebugIn.dRxError     <= dRxError;
   rDebugIn.dTxBusy      <= dTxBusy;

   -- send outputs
   IntSoft  <= rDebugOut.IntSoft;
   IntHard  <= rDebugOut.IntHard;
   DigReset <= rDebugOut.DigReset;

   a_reg_addr <= addr(10 downto 2);

   -- reg signals assined to ports
   TxDisable     <= s_TxDisable;
   EndeavorScale <= s_EndeavorScale;

   process (clk, s_TxDisable, s_EndeavorScale, rDebugOut, rDebugIn)
      variable count : unsigned(31 downto 0) := (others => '0');
   begin
      if rising_edge (clk) then

         -- defaults
         ack   <= req;
         QDASend <= '0';
         iUpdate <= '0';
         count := count + 1;

         -- reg mapping
         case a_reg_addr is

            -- scratchpad IO
            when x"00" =>
               if wen = '1' and req = '1' then
                  scratch_word <= wdata;
               else
                  rdata <= scratch_word;
               end if;

            -- set TxDisable
            when x"01" =>
               if wen = '1' and req = '1' then
                  s_TxDisable <= wdata(3 downto 0);
               else
                  rdata(3 downto 0) <= s_TxDisable;
               end if;

            -- set pulse len
            when x"02" =>
               if wen = '1' and req = '1' then
                  pulseLen <= wdata;
               else
                  rdata <= pulseLen;
               end if;

            -- read debug
            when x"03" =>
               rdata <= readDebug(rDebugIn);

            -- send debug pulses
            when x"04" =>
               if wen = '1' and req = '1' then
                  count := (others => '0');
               end if;
               case wdata is
                  when x"0000" =>
                     rDebugOut <= pulseDebugOut_Soft;
                  when x"0001" =>
                     rDebugOut <= pulseDebugOut_Hard;
                  when x"0002" =>
                     rDebugOut <= pulseDebugOut_Reset;
                  when others =>
                     rDebugOut <= pulseDebugOut_C;
               end case;

            -- endeavor scale
            when x"05" =>
               if wen = '1' and req = '1' then
                  s_EndeavorScale <= wdata(2 downto 0);
               else
                  rdata(2 downto 0) <= s_EndeavorScale;
               end if;

            -- The QDA Node Registers
            when x"06" =>
               QDAMask <= wdata(N_QDA_PORTS - 1 downto 0);

            -- QDA FIFO values
            when x"10"    =>
               rdata(2 downto 0) <= QDA_fifo_empty & QDA_fifo_full & QDA_fifo_valid;

            when x"11" =>
               QDA_fifo_ren <= wdata(0);

            when x"12" =>
               QDAPacketLength <= wdata;

            when x"13" =>
               rdata <= QDA_fifo_hits;

            -- QDA Byte low
            when x"14" =>
               QDAByte(31 downto 0) <= wdata;

            -- QDA Byte high, on writing high byte, the byte will be sent
            -- to the ports via QDAMask
            when x"15" =>
               QDAByte(63 downto 32) <= wdata;
               QDASend <= '1';

            -- QDA SPI Configure on the Voltage DAC
            when x"16" =>
               iRegData <= wdata(SPI_REGISTER_WIDTH - 1 downto 0);
               iUpdate <= '1';

            -- QDA SPI configure the SRST pin here..
            when x"17" =>
               SPI_SRST <= wdata(0);

            when x"18" =>
               if wen = '1' and req = '1' then
                  reg_load_period <= wdata(15 downto 0);
               else
                  rdata(15 downto 0) <= reg_load_period;
               end if;

            when x"19" =>
               if wen = '1' and req = '1' then
                  reg_latch_period <= wdata(15 downto 0);
               else
                  rdata(15 downto 0) <= reg_latch_period;
               end if;

            when others =>
               rdata <= x"aBAD_ADD0";

         end case;

         -- send the debug low again
         if count >= unsigned(pulseLen) then
            count := (others => '0');
            rDebugOut <= pulseDebugOut_C;
         end if;

      end if;
         
   end process;

  U_IRS3D_DAC_CONTROL : entity work.IRS3D_DAC_CONTROL
    generic map (
      REGISTER_WIDTH => SPI_REGISTER_WIDTH
      )
    port map (
      CLK          => clk,                --: in  STD_LOGIC;
      LOAD_PERIOD  => reg_load_period,  --: in  STD_LOGIC_VECTOR(15 downto 0);
      LATCH_PERIOD => reg_latch_period, --: in  STD_LOGIC_VECTOR(15 downto 0);
      UPDATE       => iUpdate,            --: in  STD_LOGIC;
      REG_DATA     => iRegData,           --: in  STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
      SHOUT_DATA   => open,               --: out STD_LOGIC_VECTOR(REGISTER_WIDTH-1 downto 0);
      SIN          => SPI_SIN,            --: out STD_LOGIC;
      SHOUT        => ZERO_C,             --: in  STD_LOGIC;
      SCLK         => SPI_SCLK,           --: out STD_LOGIC;
      PCLK         => SPI_PCLK,           --: out STD_LOGIC;
      DONE         => open              --: out STD_LOGIC
      );

end behav;
