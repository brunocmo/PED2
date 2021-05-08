// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon Mar  1 14:14:52 2021
// Host        : DESKTOP-R1K7JBB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top vio_fsmpwm -prefix
//               vio_fsmpwm_ vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2019.2" *)
module vio_fsmpwm(clk, probe_in0, probe_out0, probe_out1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[0:0],probe_out0[0:0],probe_out1[0:0]" */;
  input clk;
  input [0:0]probe_in0;
  output [0:0]probe_out0;
  output [0:0]probe_out1;
endmodule
