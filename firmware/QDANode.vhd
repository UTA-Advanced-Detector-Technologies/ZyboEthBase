-------------------------------------------------------------------------------
-- Title      : QDANode
-- Project    : ZyboQDB
-------------------------------------------------------------------------------
-- File       : QDANode.vhd
-- Author     : Kevin Keefe <kevin.keefe2@uta.edu>
-- Company    :
-- Created    : 2024-02-13
-- Last update: 2024-02-13
-- Platform   : Windows 11
-- Standard   : VHDL08
-------------------------------------------------------------------------------
-- Description: QDA Node impletemented on Zybo board with Vivado 2020.2, windows
-------------------------------------------------------------------------------
-- Copyright (c) 2024
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-09-06  1.0      keefe	Created
-------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.QpixPkg.all;
use work.QpixProtoPkg.all;

-- fancy sl / slv alias'
use work.UtilityPkg.all;


entity QDANode is
generic (
  N_QDA_PORTS    : natural := 4;
  TIMESTAMP_BITS : natural := 32);      -- number of input QDA channels to zybo
port (
  clk        : in  sl;
  rst        : in  sl;

  -- connect to QDAChanBuf
  QTx           : out slv(3 downto 0);
  QRx           : in  slv(3 downto 0);
  EndeavorScale : in  slv(2 downto 0);

  -- AXI-Stream IO
  S_AXI_0_tdata   : out STD_LOGIC_VECTOR (31 downto 0);
  S_AXI_0_tready  : in  STD_LOGIC;
  S_AXI_0_tlast   : out STD_LOGIC;
  S_AXI_0_tvalid  : out STD_LOGIC;

  -- Register Pins
  QDAByte         : in  slv(63 downto 0); -- byte to send out on tx port
  QDASend         : in  sl; -- pulse input to send a tx byte
  QDAMask         : in  slv(N_QDA_PORTS - 1 downto 0);
  qdaPacketLength : in  slv(31 downto 0);
  valid           : out sl;
  empty           : out sl;
  full            : out sl;
  QDA_fifo_Hits   : out slv(31 downto 0);
  QDAReadEn       : in  sl
  );
end QDANode;

architecture Behavioral of QDANode is

  -- QDA Ctrl signals
  constant emtpy_bits    : slv(64 - N_QDA_PORTS - TIMESTAMP_BITS - 1 downto 0) := (others => '0');
  signal n_qda_hits : unsigned(31 downto 0);
  
  type qByteArr is array (3 downto 0) of slv(63 downto 0);

  -- Rx signals from the QDA
  signal rxByte      : qByteArr;
  signal rxByteValid : slv(3 downto 0);
  signal rxByteAck   : slv(3 downto 0);

  -- Tx signals to ports
  signal txByte      : qByteArr;
  signal txByteValid : slv(3 downto 0);
  signal txByteReady : slv(3 downto 0);

  -- FIFO connection signals
  signal fifo_valid : sl;
  signal fifo_empty : sl;
  signal fifo_full  : sl;
  signal fifo_din  : slv(63 downto 0);
  signal fifo_dout : slv(63 downto 0);
  signal fifo_rd_en  : sl;
  signal fifo_wr_en  : sl;

  -- s_axi signals
  signal s_axis_tvalid : sl;
  signal s_axis_tready : sl;
  signal s_axis_tdata  : slv(31 downto 0);
  signal m_axis_tvalid : sl;
  signal m_axis_tready : sl;
  signal m_axis_tdata  : slv(31 downto 0);
  signal almost_full   : sl;

begin  -- architecture QDANode

  -- connections to entity;
  valid         <= fifo_valid;
  empty         <= fifo_empty;
  full          <= fifo_full;
  QDA_fifo_Hits <= std_logic_vector(n_qda_hits);
  
  -- keep track of how many hits we've received
  process(clk, fifo_valid, n_qda_hits, rxByteValid, rxByteAck, rxByte)
  begin
    if rising_edge(clk) then
        if fifo_valid = '1' then
            n_qda_hits <= n_qda_hits + 1;
        end if;

        -- choose to write fifo_din with rxByte
        for i in 0 to 3 loop
          -- received a valid byte on this channel
          if rxByteValid(i) = '1' then
            fifo_din     <= rxByte(i);
            fifo_wr_en   <= '1';
            rxByteAck    <= (others => '0');
            rxByteAck(i) <= '1';
            send_rx := false;
          end if;
        end loop;

        -- attempt to send on every masked output
        if QDASend = '1' then
          for i in 0 to 3 loop
            if QDAMask(i) = '1' and txByteReady(i) = '1' then
              txByte(i)      <= QDAByte;
              txByteValid(i) <= '1';
            end if;
          end loop;
        end if;

    end if;
  end process;


   ---------------------------------------------------
   -- FIFO
   ---------------------------------------------------
   -- FIFO data which is fill fromed FSM and sent as
   -- output to the register config in regmap
  QDAFifo_U : entity work.fifo_generator_0
  port map(
    clk    => clk,
    rst    => rst,
    din    => fifo_din,
    wr_en  => fifo_wr_en,
    rd_en  => fifo_rd_en,
    dout   => fifo_dout,

    -- status signals
    valid  => fifo_valid,
    empty  => fifo_empty,
    full   => fifo_full
   );

   ---------------------------------------------------
   -- AXI-Stream Logic connect FIFO
   ---------------------------------------------------
   -- output of this fifo should configurably connect to PS
   -- this should allow independent broadcasting of QDA resets
   -- this implementation is inspired from AxiLiteSlaveSimple.vhd
  AXIS_QDAFifo_U : entity work.QDAAxiFifo
  port map(
    clk => clk,

    -- Fifo Connections
    fifo_dout    => fifo_dout,
    fifo_wr_en   => fifo_wr_en,
    qda_fifo_ren => fifo_rd_en,
    fifo_valid   => fifo_valid,
    fifo_empty   => fifo_empty,
    fifo_full    => fifo_full,

    -- register connections
    qdaPacketLength => qdaPacketLength,

    -- direct AXI Data Fifo Connections
    -- AXI IO
    S_AXI_0_tdata   => S_AXI_0_tdata,
    S_AXI_0_tready  => S_AXI_0_tready,
    S_AXI_0_tlast   => S_AXI_0_tlast,
    S_AXI_0_tvalid  => S_AXI_0_tvalid
   );

  -- allocate an endeavor node for each of the QPix Directions
 TxRx : for i in 0 to 3 generate
    END_QDAPort_U : entity work.QpixEndeavorTop
      port map(
        clk         => clk,
        sRst        => rst,
        scale       => EndeavorScale,
        TxRxDisable => '0', -- don't disable any of these nodes

        -- RX out
        rxByte      => rxByte(i),
        rxByteValid => rxByteValid(i),
        rxByteAck   => rxByteAck(i),

        -- RX Error statuses out
        rxFrameErr  => open,
        rxBreakErr  => open,
        rxBusy      => open,
        rxError     => open,

        -- TX in
        txByte      => txByte(i),
        txByteValid => txByteValid(i),
        txByteReady => txByteReady(i),

        -- external ports
        Rx          => QRx(i),
        Tx          => QTx(i)
      );
  end generate TxRx;


end architecture Behavioral;
