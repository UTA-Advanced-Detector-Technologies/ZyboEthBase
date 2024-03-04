//-----------------------------------------------------------------------------
// Title         : QDADacControl
// Project       : QDA
//-----------------------------------------------------------------------------
// File          : QDADacControl.v
// Author        :   <keefe@FORERUNNER>
// Created       : 29.02.2024
// Last modified : 29.02.2024
//-----------------------------------------------------------------------------
// Description :
//
//-----------------------------------------------------------------------------
// Copyright (c) 2024 by UTA This model is the confidential and
// proprietary property of UTA and the possession or use of this
// file requires a written license from UTA.
//------------------------------------------------------------------------------
// Modification history :
// 29.02.2024 : created
//-----------------------------------------------------------------------------

module QDA_DAC_CONTROL (
   input clk,
   input [15:0] LOAD_PERIOD,
   input [15:0] LATCH_PERIOD,
   input UPDATE,
   input [15:0] REG_DATA,
   output reg SIN,
   output reg SCLK,
   output reg PCLK
) ;

   // internal stuff
   reg [3:0] state_d = 4'b0;
   reg [3:0] state_q = 4'b0;
   reg [15:0] Cnter = 15'b0;
   reg [3:0] Curbit = 3'b0;
   reg [3:0] Nextbit = 3'b0;
   reg       Done = 1'b0;

   // FSM Sends a bit and waits on latch(load)_period
   localparam idle = 3'd0;
   localparam low_sclk = 3'd1;
   localparam send_bit = 3'd2;
   localparam send_pclk = 3'd3;
   localparam finished = 3'd4;

   // FSM Combinrational Logic
   always @(*) begin
      case(state_q)
        idle: begin
          SIN <= 1'b0;
          SCLK <= 1'b0;
          PCLK <= 1'b0; end
        low_sclk: begin
          SIN <= REG_DATA[Curbit];
          SCLK <= 1'b0;
          PCLK <= 1'b0; end
        send_bit: begin
          SIN <= REG_DATA[Curbit];
          SCLK <= 1'b1;
          PCLK <= 1'b0; end
        send_pclk: begin
          SIN <= 1'b0;
          SCLK <= 1'b0;
          PCLK <= 1'b1; end
        finished: begin
          SIN <= 1'b0;
          SCLK <= 1'b0;
          PCLK <= 1'b0; end
        default: begin
          SIN <= 1'b0;
          SCLK <= 1'b0;
          PCLK <= 1'b0; end
       endcase
   end

   // FSM Sequential Logic
   always@ (posedge clk) begin
      // every clk
      state_q <= state_d;
      Curbit <= Nextbit;

      // iff update and in idle, begin sending bits
      if (UPDATE == 'b1 & state_q == idle)
         state_d <= low_sclk;
      // if finished, go back to IDLE
      else if (state_q == finished)
        state_d <= idle;
      // prep the bit here in the low state
      else if (state_q == low_sclk) begin
         Cnter <= Cnter + 1'b1;
         if (Cnter >= LATCH_PERIOD - 1) begin
            Cnter <= 0;
            if (Done == 1'b1)
               state_d <= send_pclk;
            else
               state_d <= send_bit;
         end
      // load the bit to be sent
      end else if (state_q == send_bit) begin
         Cnter <= Cnter + 1'b1;
         if (Cnter >= LOAD_PERIOD - 1) begin
            Cnter <= 0;
            state_d <= low_sclk;
            if (Nextbit >= 16 - 1)
              Done = 1'b1;
            else
              Nextbit <= Nextbit + 1'b1;
         end
      // finally, send a single pclk to load the DAC, then go to finished
      end else if (state_q == send_pclk) begin
         Cnter <= Cnter + 1'b1;
         Nextbit <= 0;
         Done = 0'b0;
         if (Cnter >= LATCH_PERIOD - 1)
           state_d <= finished;
      end
   end

endmodule // QDA_DAC_CONTROL
