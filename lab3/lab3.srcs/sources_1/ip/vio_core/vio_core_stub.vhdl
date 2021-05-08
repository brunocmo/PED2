-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Fri Apr 30 19:44:57 2021
-- Host        : DESKTOP-R1K7JBB running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub C:/Users/bruno/lab3/lab3.srcs/sources_1/ip/vio_core/vio_core_stub.vhdl
-- Design      : vio_core
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_core is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_in1 : in STD_LOGIC_VECTOR ( 6 downto 0 );
    probe_in2 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    probe_out2 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    probe_out3 : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end vio_core;

architecture stub of vio_core is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[3:0],probe_in1[6:0],probe_in2[15:0],probe_out0[0:0],probe_out1[15:0],probe_out2[7:0],probe_out3[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2019.2";
begin
end;
