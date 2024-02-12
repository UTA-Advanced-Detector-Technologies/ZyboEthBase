library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OneWire is
  Generic (
    clk_frequency : positive := 50E6  -- Default clock frequency: 50 MHz
  );
  Port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    begin_read : in  std_logic;
    dout       : out std_logic;
    din        : in  std_logic;
    presence   : out STD_LOGIC;
    -- output data
    reg_data_out : out std_logic_vector(63 downto 0)
  );
end OneWire;

architecture Behavioral of OneWire is
  type t_state is (IDLE_S, RESET_S, DETECT_S, WRITE_S, READ_S, DONE_S);
  signal state    : t_state;
  -- signal state : integer := 0;
  signal elapsed_cycles : integer := 0;

  signal data : std_logic;

  constant RESET_CYCLES : integer := 48;  -- Reset duration in clock cycles
  constant SLOT_CYCLES : integer := 12;  -- Slot duration in clock cycles
  constant SAMPLE_CYCLES : integer := 5; -- Sample duration in clock cycles

  constant CLKS_PER_US : integer := 100;

  constant RESET_TIME_US : integer := 600;
  constant PRES_DETECT_HIGH_US : integer := 60; -- detect high
  constant PRES_DETECT_TIME_US : integer := 240; -- detect low

  constant WRITE_ZER_LOW_TIME : integer := 60; -- 60us to 120us
  constant WRITE_ONE_LOW_TIME : integer := 1; -- 1us to 15us
  constant TIME_SLOT : integer := 65; -- standard speed

  constant READ_LOW_TIME : integer := 5; -- 5 us to 15 us
  constant READ_SAMPLE_TIME : integer := 14; -- 5 us to 15-delta us

  signal found_pres_low : boolean := false;
  signal found_pres_high : boolean := false;

  signal read_data : std_logic_vector(63 downto 0);

  constant CMD_READROM : std_logic_vector(7 downto 0) := x"33";

begin

  reg_data_out <= read_data;

  -- Sequential part for state transitions
  process(clk, rst, begin_read, data, dout, din, state, elapsed_cycles)
    variable read_bit : integer range 0 to 64 := 0;
    variable write_bit : integer range 0 to 8 := 0;
  begin

    if rst = '1' then
      state <= IDLE_S;
      elapsed_cycles <= 0;

    elsif rising_edge(clk) then

      case state is

        when IDLE_S =>
          dout <= '1';

          found_pres_low <= false;
          found_pres_high <= false;

          write_bit := 0;
          read_bit := 0;
          
          -- Master initiates a reset pulse
          if begin_read = '1' then
            state <= RESET_S;
            dout <= '0';
            elapsed_cycles <= 0;
          end if;

        -- probe the reset
        when RESET_S =>
          elapsed_cycles <= elapsed_cycles + 1;
          dout           <= '0';
          read_data <= (others => '0');

          -- Update state machine for the next bit
          if elapsed_cycles >= RESET_TIME_US * CLKS_PER_US then
              state          <= DETECT_S;
              dout           <= 'Z';
              elapsed_cycles <= 0;
          end if;

        when DETECT_S =>
          elapsed_cycles <= elapsed_cycles + 1;
          dout <= 'Z';

          -- if we found the low and high pulse, we can send the cmd
          if elapsed_cycles >= PRES_DETECT_TIME_US * CLKS_PER_US then
            if found_pres_low and found_pres_high then
              state          <= WRITE_S;
              elapsed_cycles <= 0;
            else
              state <= IDLE_S;
            end if;
          end if;

          -- detect low
          if elapsed_cycles >= PRES_DETECT_HIGH_US * CLKS_PER_US then
              -- Reading data from the bus
              if din = '0' then
                found_pres_low <= true;
              end if;
          -- detect high first
          else
            if din = '1' then
              found_pres_high <= true;
            end if;
          end if;

        -- write 0x33 to get the ROMID back
        when WRITE_S =>
          elapsed_cycles <= elapsed_cycles + 1;
          dout <= '0';

          if CMD_READROM(write_bit) = '1' then
            if elapsed_cycles >= WRITE_ONE_LOW_TIME * CLKS_PER_US then
              dout <= '1';
            end if;
          elsif CMD_READROM(write_bit) = '0' then
            if elapsed_cycles >= WRITE_ZER_LOW_TIME * CLKS_PER_US then
              dout <= '1';
            end if;
          end if;

          -- finished writing all bits of the cmd reg
          if elapsed_cycles >= TIME_SLOT * CLKS_PER_US then
            write_bit := write_bit + 1;
            elapsed_cycles <= 0;
            if write_bit = 8 then
              elapsed_cycles <= 0;
              state <= READ_S;
            end if;
          end if;

        -- read 64 bits back
        when READ_S =>
          elapsed_cycles <= elapsed_cycles + 1;

          -- force low until Trl
          if elapsed_cycles >= READ_LOW_TIME * CLKS_PER_US then
            dout <= 'Z';
            -- read
            if elapsed_cycles <= READ_SAMPLE_TIME * CLKS_PER_US then
              read_data(read_bit) <= din;
            end if;
          else
            dout <= '0';
          end if;

          -- go to the next bit
          if elapsed_cycles >= TIME_SLOT * CLKS_PER_US then
            read_bit := read_bit + 1;
            elapsed_cycles <= 0;
            -- finished up reading
            if read_bit = 64 then
              state <= IDLE_S;
            end if;
          end if;

        when others =>
          state <= IDLE_S;
      end case;
    end if;
  end process;

  -- Combinational part for state logic
  -- process(state, dout, elapsed_cycles)
  -- begin
  --   case state is
  --     when 1 =>
  --       -- One-Wire communication logic
  --       -- Implement sending and receiving bits here

  --       if elapsed_cycles = SLOT_CYCLES then
  --         -- Writing data to the bus
  --         dout <= '1';  -- For example, sending a '1' bit
  --       elsif elapsed_cycles = SLOT_CYCLES + SAMPLE_CYCLES then
  --         dout <= 'Z';
  --       elsif elapsed_cycles = SLOT_CYCLES * 2 + SAMPLE_CYCLES then
  --         -- Update state machine for the next bit
  --         -- You'll need to add more logic for the complete bit exchange
  --       end if;

  --     when others =>
  --       null;
  --   end case;
  -- end process;

  -- Presence pulse detection
  presence <= din;

end Behavioral;
