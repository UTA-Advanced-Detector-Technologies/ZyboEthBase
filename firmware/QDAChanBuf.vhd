library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
library UNISIM;
use UNISIM.VComponents.all;

entity QDAChanBuf is
port (

  -- Rx port from the QDA
  port_in_p : in std_logic;
  port_in_n : in std_logic;
  Rx : out std_logic;

  -- Tx port to the QDA
  Tx : in std_logic;
  port_out_p : out std_logic;
  port_out_n : out std_logic

  );
end QDAChanBuf;

architecture behavioral of QDAChanBuf is

  signal sRx : std_logic := '0';
  signal sTx : std_logic := '0';

begin  -- architecture behavioral

    IBUFDS_inst : IBUFDS
    generic map (
        DIFF_TERM => FALSE, -- Differential Termination
        IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
        IOSTANDARD => "DEFAULT")
    port map (
        O => sRx,        -- Buffer output
        I => port_in_p,  -- Diff_p buffer input (connect directly to top-level port)
        IB => port_in_n  -- Diff_n buffer input (connect directly to top-level port)
    );

    OBUFDS_inst : OBUFDS
    generic map (
        IOSTANDARD => "DEFAULT", -- Specify the output I/O standard
        SLEW => "SLOW")          -- Specify the output slew rate
    port map (
        O => port_out_p,   -- Diff_p output (connect directly to top-level port)
        OB => port_out_n,  -- Diff_n output (connect directly to top-level port)
        I => Tx           -- Buffer input
    );

    -- connect signals to ports
--    sTx <= Tx;
    Rx <= sRx;


end architecture behavioral;
