library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
library UNISIM;
use UNISIM.VComponents.all;

entity ZyboQDACtrl is
port (    

   led : out std_logic_vector(3 downto 0);
   sw  : in  std_logic_vector(3 downto 0);

   -- led_5
   led5_r : out std_logic;
   led5_b : out std_logic;
   led5_g : out std_logic;

   -- led_6
   led6_r : out std_logic;
   led6_b : out std_logic;
   led6_g : out std_logic;

   -- I/O ports
   QDA_IN_A_p  : out std_logic;
   QDA_IN_A_n  : out std_logic;
   QDA_OUT_A_p : in  std_logic;
   QDA_OUT_A_n : in  std_logic;

   QDA_IN_B_p  : out std_logic;
   QDA_IN_B_n  : out std_logic;
   QDA_OUT_B_p : in  std_logic;
   QDA_OUT_B_n : in  std_logic;

   QDA_IN_C_p  : out std_logic;
   QDA_IN_C_n  : out std_logic;
   QDA_OUT_C_p : in  std_logic;
   QDA_OUT_C_n : in  std_logic;

   QDA_IN_D_p  : out std_logic;
   QDA_IN_D_n  : out std_logic;
   QDA_OUT_D_p : in  std_logic;
   QDA_OUT_D_n : in  std_logic;

   -- SPI Ctrl
   SPI_SCLK : out std_logic;
   SPI_PCLK : out std_logic;
   SPI_SRST : out std_logic;
   SPI_SIN  : out std_logic;

   -- config signals
   EndeavorScale : out std_logic_vector(2 downto 0);
   TxDisable     : out std_logic_vector(3 downto 0);
   IntSoft       : out std_logic;
   IntHard       : out std_logic;
   DigReset      : out std_logic;

   -- debug signals (inputs from QDA)
   dFsmState    : in std_logic_vector(2 downto 0);
   dLocFifoFull : in std_logic;
   dExtFifoFull : in std_logic;
   dRxBusy      : in std_logic;
   dRxError     : in std_logic;
   dTxBusy      : in std_logic;

   -- PS ports
   DDR_addr          : inout STD_LOGIC_VECTOR (14 downto 0);
   DDR_ba            : inout STD_LOGIC_VECTOR (2 downto 0);
   DDR_cas_n         : inout STD_LOGIC;
   DDR_ck_n          : inout STD_LOGIC;
   DDR_ck_p          : inout STD_LOGIC;
   DDR_cke           : inout STD_LOGIC;
   DDR_cs_n          : inout STD_LOGIC;
   DDR_dm            : inout STD_LOGIC_VECTOR (3 downto 0);
   DDR_dq            : inout STD_LOGIC_VECTOR (31 downto 0);
   DDR_dqs_n         : inout STD_LOGIC_VECTOR (3 downto 0);
   DDR_dqs_p         : inout STD_LOGIC_VECTOR (3 downto 0);
   DDR_odt           : inout STD_LOGIC;
   DDR_ras_n         : inout STD_LOGIC;
   DDR_reset_n       : inout STD_LOGIC;
   DDR_we_n          : inout STD_LOGIC;
   FIXED_IO_ddr_vrn  : inout STD_LOGIC;
   FIXED_IO_ddr_vrp  : inout STD_LOGIC;
   FIXED_IO_mio      : inout STD_LOGIC_VECTOR (53 downto 0);
   FIXED_IO_ps_clk   : inout STD_LOGIC;
   FIXED_IO_ps_porb  : inout STD_LOGIC;
   FIXED_IO_ps_srstb : inout STD_LOGIC
);
end ZyboQDACtrl;

architecture Behavioral of ZyboQDACtrl is

   constant pulse_time : integer := 7_999_999;  -- fclk_freq / pulse_time = pulse's width
   constant FCLK_FRQ   : natural := 30000000;

   signal fclk : std_logic;
   signal rst  : std_logic := '0';

   -- QDA Data node
   constant N_QDA_PORTS    : natural   := 4;
   constant TIMESTAMP_BITS : natural   := 32;
   signal QDAByte          : std_logic_vector(63 downto 0);
   signal QDAsend          : std_logic;
   signal QDAMask          : std_logic_vector(N_QDA_PORTS - 1 downto 0);
   signal QDAPacketLength  : std_logic_vector(31 downto 0);
   signal QDA_fifo_valid   : std_logic := '0';
   signal QDA_fifo_empty   : std_logic := '0';
   signal QDA_fifo_full    : std_logic := '0';
   signal QDA_fifo_ren     : std_logic := '0';
   signal QDA_fifo_hits    : std_logic_vector(31 downto 0);

   signal qdaRxValid : std_logic;
   signal qdaTxValid : std_logic;

   -- QDA config
   signal sEndeavorScale : std_logic_vector(2 downto 0);

    -- ps-pl axi
   signal axi_resetn  : std_logic_vector(0 downto 0) := (others => '1');
   signal axi_awaddr  : std_logic_vector (31 downto 0);
   signal axi_awprot  : std_logic_vector (2 downto 0);
   signal axi_awvalid : std_logic_vector(0 downto 0);
   signal axi_awready : std_logic_vector(0 downto 0);
   signal axi_wdata   : std_logic_vector (31 downto 0);
   signal axi_wstrb   : std_logic_vector (3 downto 0);
   signal axi_wvalid  : std_logic_vector(0 downto 0);
   signal axi_wready  : std_logic_vector(0 downto 0);
   signal axi_bresp   : std_logic_vector (1 downto 0);
   signal axi_bvalid  : std_logic_vector(0 downto 0);
   signal axi_bready  : std_logic_vector(0 downto 0);
   signal axi_araddr  : std_logic_vector (31 downto 0);
   signal axi_arprot  : std_logic_vector (2 downto 0);
   signal axi_arvalid : std_logic_vector(0 downto 0);
   signal axi_arready : std_logic_vector(0 downto 0);
   signal axi_rdata   : std_logic_vector (31 downto 0);
   signal axi_rresp   : std_logic_vector (1 downto 0);
   signal axi_rvalid  : std_logic_vector(0 downto 0);
   signal axi_rready  : std_logic_vector(0 downto 0);
   
   -- Register signals
   signal reg_addr    : std_logic_vector (31 downto 0);
   signal reg_rdata   : std_logic_vector (31 downto 0);
   signal reg_wdata   : std_logic_vector (31 downto 0);
   signal reg_req     : std_logic := '0';
   signal reg_wen     : std_logic := '0';
   signal reg_ack     : std_logic := '0';

   -- ps axi4-stream data fifo
   signal S_AXI_0_tlast   : STD_LOGIC;
   signal S_AXI_0_tdata  : STD_LOGIC_VECTOR (31 downto 0);
   signal S_AXI_0_tready : STD_LOGIC;
   signal S_AXI_0_tvalid : STD_LOGIC;

   -- scpi signals from ps
   signal data_out   : std_logic_vector(7 downto 0); -- how many bytes to accept
   signal data_in    : std_logic_vector(7 downto 0); -- how many bytes to accept

   signal reg_data_out : std_logic_vector(63 downto 0);
   
   signal counter_led : std_logic                    := '0';
   signal leds        : std_logic_vector(3 downto 0) := (others => '0');

   signal pulse_red  : std_logic := '0';
   signal pulse_blu  : std_logic := '0';
   signal pulse_gre  : std_logic := '0';
   signal pulse_red6 : std_logic := '0';
   signal pulse_blu6 : std_logic := '0';
   signal pulse_gre6 : std_logic := '0';

   -- signals for buffering port IO
   signal QRx : std_logic_vector(3 downto 0);
   signal QTx : std_logic_vector(3 downto 0);
   
   
   -- pulse LED procedure
   procedure pulseLED(variable flag : in boolean;
                      variable start_pulse : inout std_logic;
                      variable count_pulse : inout integer;
                      signal output : out std_logic) is
      begin
         if flag then
             start_pulse := '1';
             count_pulse := 0;
         end if;
         if start_pulse = '1' then
             count_pulse := count_pulse + 1;
             output <= '1';
             if count_pulse >= pulse_time then
                 output      <= '0';
                 count_pulse := 0;
                 start_pulse := '0';
             end if;
         end if;
      end procedure pulseLED;


begin

--    led <= sw;

    -- LED-5, active high
    led5_r <= pulse_red;
    led5_b <= pulse_blu;
    led5_g <= pulse_gre;

    led6_r <= pulse_red6;
    led6_b <= pulse_blu6;
    led6_g <= pulse_gre6;

    EndeavorScale <= sEndeavorScale;

  ---------------------------------------------------
  -- Channel Maps
  ---------------------------------------------------
  PortA_U : entity work.QDAChanBuf
  port map(
    -- Rx port from the QDA
    port_in_p => QDA_OUT_A_p,
    port_in_n => QDA_OUT_A_n,
    Rx => QRx(0),

    -- Tx port to the QDA
    Tx => QTx(0),
    port_out_p => QDA_IN_A_p,
    port_out_n => QDA_IN_A_n
  );

  PortB_U : entity work.QDAChanBuf
  port map(
    -- Rx port from the QDA
    port_in_p => QDA_OUT_B_p,
    port_in_n => QDA_OUT_B_n,
    Rx => QRx(1),

    -- Tx port to the QDA
    Tx => QTx(1),
    port_out_p => QDA_IN_B_p,
    port_out_n => QDA_IN_B_n
  );

  PortC_U : entity work.QDAChanBuf
  port map(
    -- Rx port from the QDC
    port_in_p => QDA_OUT_C_p,
    port_in_n => QDA_OUT_C_n,
    Rx => QRx(2),

    -- Tx port to the QDC
    Tx => QTx(2),
    port_out_p => QDA_IN_C_p,
    port_out_n => QDA_IN_C_n
  );

  PortD_U : entity work.QDAChanBuf
  port map(
    -- Rx port from the QDA
    port_in_p => QDA_OUT_D_p,
    port_in_n => QDA_OUT_D_n,
    Rx => QRx(3),

    -- Tx port to the QDA
    Tx => QTx(3),
    port_out_p => QDA_IN_D_p,
    port_out_n => QDA_IN_D_n
  );
   

  ---------------------------------------------------
  -- Processing system
  ---------------------------------------------------
  design_1_U : entity work.design_1_wrapper
        port map (
           -- PS ports
           DDR_addr(14 downto 0)     => DDR_addr(14 downto 0),
           DDR_ba(2 downto 0)        => DDR_ba(2 downto 0),
           DDR_cas_n                 => DDR_cas_n,
           DDR_ck_n                  => DDR_ck_n,
           DDR_ck_p                  => DDR_ck_p,
           DDR_cke                   => DDR_cke,
           DDR_cs_n                  => DDR_cs_n,
           DDR_dm(3 downto 0)        => DDR_dm(3 downto 0),
           DDR_dq(31 downto 0)       => DDR_dq(31 downto 0),
           DDR_dqs_n(3 downto 0)     => DDR_dqs_n(3 downto 0),
           DDR_dqs_p(3 downto 0)     => DDR_dqs_p(3 downto 0),
           DDR_odt                   => DDR_odt,
           DDR_ras_n                 => DDR_ras_n,
           DDR_reset_n               => DDR_reset_n,
           DDR_we_n                  => DDR_we_n,
           FIXED_IO_ddr_vrn          => FIXED_IO_ddr_vrn,
           FIXED_IO_ddr_vrp          => FIXED_IO_ddr_vrp,
           FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
           FIXED_IO_ps_clk           => FIXED_IO_ps_clk,
           FIXED_IO_ps_porb          => FIXED_IO_ps_porb,
           FIXED_IO_ps_srstb         => FIXED_IO_ps_srstb,

           reset_rtl                 => '0',
           -- axi interface to PL
           M_AXI_0_awaddr            => axi_awaddr,
           M_AXI_0_awprot            => axi_awprot,
           M_AXI_0_awvalid           => axi_awvalid,
           M_AXI_0_awready           => axi_awready,
           M_AXI_0_wdata             => axi_wdata,
           M_AXI_0_wstrb             => axi_wstrb,
           M_AXI_0_wvalid            => axi_wvalid,
           M_AXI_0_wready            => axi_wready,
           M_AXI_0_bresp             => axi_bresp,
           M_AXI_0_bvalid            => axi_bvalid,
           M_AXI_0_bready            => axi_bready,
           M_AXI_0_araddr            => axi_araddr,
           M_AXI_0_arprot            => axi_arprot,
           M_AXI_0_arvalid           => axi_arvalid,
           M_AXI_0_arready           => axi_arready,
           M_AXI_0_rdata             => axi_rdata,
           M_AXI_0_rresp             => axi_rresp,
           M_AXI_0_rvalid            => axi_rvalid,
           M_AXI_0_rready            => axi_rready,

           -- clk + rst
           aresetn                   => axi_resetn,
           fclk                      => fclk,

           -- data fifo interface for Input to PS
           S_AXIS_0_tdata   => S_AXI_0_tdata,
           S_AXIS_0_tready  => S_AXI_0_tready,
           S_AXIS_0_tlast   => S_AXI_0_tlast,
           S_AXIS_0_tvalid  => S_AXI_0_tvalid,
           S_AXIS_0_tkeep   => "1111"
        );


  ---------------------------------------------------
  -- AXI Lite interface from PS
  ---------------------------------------------------
  AxiLiteSlaveSimple_U : entity work.AxiLiteSlaveSimple
     port map(
        axi_aclk              => fclk,
        axi_aresetn           => axi_resetn(0),

        axi_awaddr            => axi_awaddr,
        axi_awprot            => axi_awprot,
        axi_awvalid           => axi_awvalid(0),
        axi_awready           => axi_awready(0),
        axi_wdata             => axi_wdata,
        axi_wstrb             => axi_wstrb,
        axi_wvalid            => axi_wvalid(0),
        axi_wready            => axi_wready(0),
        axi_bresp             => axi_bresp,
        axi_bvalid            => axi_bvalid(0),
        axi_bready            => axi_bready(0),
        axi_araddr            => axi_araddr,
        axi_arprot            => axi_arprot,
        axi_arvalid           => axi_arvalid(0),
        axi_arready           => axi_arready(0),
        axi_rdata             => axi_rdata,
        axi_rresp             => axi_rresp,
        axi_rvalid            => axi_rvalid(0),
        axi_rready            => axi_rready(0),

        addr                  => reg_addr,
        rdata                 => reg_rdata,
        wdata                 => reg_wdata,
        req                   => reg_req,
        wen                   => reg_wen,
        ack                   => reg_ack
     );

  ---------------------------------------------------
  -- EthBaseRegMap
  ---------------------------------------------------
  EthBaseRegMap_U : entity work.EthBaseRegMap
  generic map (
     Version        => x"0000_0001"
  )
  port map(
     clk          => fclk,
     rst          => rst,

     addr         => reg_addr,
     rdata        => reg_rdata,
     wdata        => reg_wdata,
     req          => reg_req,
     wen          => reg_wen,
     ack          => reg_ack,

     -- byte data IO
     EndeavorScale => sEndeavorScale,
     TxDisable     => TxDisable,
     IntSoft       => IntSoft,
     IntHard       => IntHard,
     DigReset      => DigReset,

     -- QDA SPI VCO
     SPI_SCLK => SPI_SCLK,
     SPI_PCLK => SPI_PCLK,
     SPI_SRST => SPI_SRST,
     SPI_SIN  => SPI_SIN,

     -- QDA debug signals
     dFsmState    => dFsmState,
     dLocFifoFull => dLocFifoFull,
     dExtFifoFull => dExtFifoFull,
     dRxBusy      => dRxBusy,
     dRxError     => dRxError,
     dTxBusy      => dTxBusy,

     -- QDA Node interactions
     QDAByte         => QDAByte,
     QDASend         => QDASend,
     QDAMask         => QDAMask,
     QDAPacketLength => QDAPacketLength,
     QDA_fifo_valid  => QDA_fifo_valid,
     QDA_fifo_empty  => QDA_fifo_empty,
     QDA_fifo_full   => QDA_fifo_full,
     QDA_fifo_hits   => QDA_fifo_hits,
     QDA_fifo_ren    => QDA_fifo_ren
  );

   ---------------------------------------------------
   -- QDA node, manage the 4 Tx / Rx lines from the QDA
   ---------------------------------------------------
 QDANode_U : entity work.QDANode
  generic map(
  N_QDA_PORTS    => N_QDA_PORTS,
  TIMESTAMP_BITS => TIMESTAMP_BITS)
  port map(
     clk         => fclk,
     rst         => rst,

     QTx => QTx,
     QRx => QRx,
     EndeavorScale => sEndeavorScale,

     -- AXI Output to UDP
     S_AXI_0_tdata   => S_AXI_0_tdata,
     S_AXI_0_tready  => S_AXI_0_tready,
     S_AXI_0_tlast   => S_AXI_0_tlast,
     S_AXI_0_tvalid  => S_AXI_0_tvalid,

     -- valid signals being sent
     RxValid => qdaRxValid,
     TxValid => qdaTxValid,

     -- Register Pins
     QDAByte         => QDAByte,
     QDASend         => QDASend,
     QDAMask         => QDAMask,
     QDAPacketLength => QDAPacketLength,
     valid           => QDA_fifo_valid,
     empty           => QDA_fifo_empty,
     full            => QDA_fifo_full,
     QDA_fifo_Hits   => QDA_fifo_hits,
     QDAReadEn       => QDA_fifo_ren
  );


-- pulse relevant LEDs
pulse : process (fclk) is
    -- variable conditions
    variable cr5 : boolean := false;
    variable cb5 : boolean := false;
    variable cg5 : boolean := false;
    variable cr6 : boolean := false;
    variable cb6 : boolean := false;
    variable cg6 : boolean := false;
    -- led5
    variable pulse_count_red : integer range 0 to pulse_time := 0;
    variable start_pulse_red : std_logic := '0';
    variable pulse_count_blu : integer range 0 to pulse_time := 0;
    variable start_pulse_blu : std_logic := '0';
    variable pulse_count_gre : integer range 0 to pulse_time := 0;
    variable start_pulse_gre : std_logic := '0';
    -- LED6
    variable pulse_count_red6 : integer range 0 to pulse_time := 0;
    variable start_pulse_red6 : std_logic := '0';
    variable pulse_count_blu6 : integer range 0 to pulse_time := 0;
    variable start_pulse_blu6 : std_logic := '0';
    variable pulse_count_gre6 : integer range 0 to pulse_time := 0;
    variable start_pulse_gre6 : std_logic := '0';
begin
    if rising_edge(fclk) then

      -- LED Flashing conditions
       cr5 := false;
       cg5 := QRx(0) = '1';
       cb5 := false;

       cr6 := false;
       cg6 := QRx(0) = '0';
       cb6 := false;

       -- proc's RGB
       pulseLED(cr5, start_pulse_red, pulse_count_red, pulse_red);
       pulseLED(cb5, start_pulse_blu, pulse_count_blu, pulse_blu);
       pulseLED(cg5, start_pulse_gre, pulse_count_gre, pulse_gre);

       -- led6 RGB
       pulseLED(cr6, start_pulse_red6, pulse_count_red6, pulse_red6);
       pulseLED(cb6, start_pulse_blu6, pulse_count_blu6, pulse_blu6);
       pulseLED(cg6, start_pulse_gre6, pulse_count_gre6, pulse_gre6);

    end if;
end process pulse;

end Behavioral;
