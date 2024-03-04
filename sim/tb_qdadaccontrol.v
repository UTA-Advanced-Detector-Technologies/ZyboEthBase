//-----------------------------------------------------------------------------
// Title         : tb_qda_dac
// Project       : qda
//-----------------------------------------------------------------------------
// File          : tb_qdadaccontrol.v
// Author        :   <keefe@FORERUNNER>
// Created       : 04.03.2024
// Last modified : 04.03.2024
//-----------------------------------------------------------------------------
// Description :
//
//-----------------------------------------------------------------------------
// Copyright (c) 2024 by UTA This model is the confidential and
// proprietary property of UTA and the possession or use of this
// file requires a written license from UTA.
//------------------------------------------------------------------------------
// Modification history :
// 04.03.2024 : created
//-----------------------------------------------------------------------------

module tb_qda_dac;

   reg clk;
   reg [15:0] LOAD_PERIOD;
   reg [15:0] LATCH_PERIOD;
   reg        UPDATE;
   reg [15:0] REG_DATA;
   wire        SIN;
   wire        SCLK;
   wire        PCLK;


   QDA_DAC_CONTROL dut (
                        .clk (clk),
                        .LOAD_PERIOD (LOAD_PERIOD),
                        .LATCH_PERIOD (LATCH_PERIOD),
                        .UPDATE (UPDATE),
                        .REG_DATA (REG_DATA),
                        .SIN (SIN),
                        .SCLK (SCLK),
                        .PCLK (PCLK)
                        );


   always #10 clk = ~clk;

   initial begin
      UPDATE <= 0;
      LOAD_PERIOD <= 16'd10;
      LATCH_PERIOD <= 16'd10;
      REG_DATA <= 16'haaaa;

      // time steps
      #5 clk = 0;

      #20 UPDATE = 1;

      #20 UPDATE = 0;

   end

endmodule // tb_qda_dac
