library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_OneWire is
end TB_OneWire;

architecture TB of TB_OneWire is
  signal clk, rst : std_logic := '0';
  signal din : std_logic; -- Initialize the data line to a high-impedance state
  signal dout : std_logic; -- Initialize the data line to a high-impedance state
  signal presence : std_logic;
  signal begin_read : std_logic;

  constant clk_period_ns : time := 10 ns; -- Clock period: 20 ns

   component OneWire
     Generic (
       clk_frequency : positive := 100E6  -- Clock frequency: 50 MHz
     );
     Port (
       clk : in std_logic;
       rst : in std_logic;
       begin_read : in std_logic;
       din : in std_logic;
       dout : out std_logic;
       presence : out std_logic
     );
   end component;

   begin
   UUT: OneWire
     generic map (
       clk_frequency => 100e6  -- Convert clock period to frequency
     )
     port map (
       clk => clk,
       rst => rst,
       din => din,
       dout => dout,
       begin_read => begin_read,
       presence => presence
     );
  --

  U_Clk : entity work.ClkRst
    port map (
        CLK_PERIOD_G => 10 ns, -- : time    := 10 ns;
        CLK_DELAY_G  => 1 ns,   -- : time    := 1 ns;  -- Wait this long into simulation before asserting reset
        clkP         => clk, -- : out sl := '0';
        rst          => open  -- : out sl := '1';
    );

  -- Test Sequence
  stim_proc : process
  begin
    wait for 2.0 ns;

    rst <= '0';
    wait for 10 us; -- Reset for 1 ms
    rst <= '1';
    wait for 10 us;
    rst <= '0';
    wait for 100 us;
    begin_read <= '1';
    wait for 10 us; -- Release the reset
    begin_read <= '0';
    wait for 10 us; -- Release the reset

    -- Example: Simulate a simple data transmission
    wait for 610 us;
    din <= '1';
    wait for 70 us;
    din <= '0';
    wait for 200 us;
    din <= '1';
--    wait for 100 ns;
--    data <= 'Z';
--    wait for 100 ns;

    -- Simulate presence pulse detection
    -- assert presence = '1' report "Presence pulse not detected" severity ERROR;

    wait;
  end process;

end TB;
