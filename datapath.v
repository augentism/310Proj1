//--------//
//DATAPATH//
//--------//
module datapath(clk,rst,muxPC,muxMAR,muxACC,loadMAR,loadPC,loadACC,loadMDR,
loadIR,opALU,zflag,opcode,MemAddr,MemD,MemQ);
  
  input clk;
  input rst;
  input muxPC;
  input muxMAR;
  input muxACC;
  input loadMAR;
  input loadPC;
  input loadACC;
  input loadMDR;
  input loadIR;
  input [1:0] opALU;
  output zflag;
  output [7:0]opcode;
  output [7:0]MemAddr;
  output [15:0]MemD;
  input [15:0]MemQ;
  reg [7:0]PC_next;
  wire [15:0]IR_next;
  reg [15:0]ACC_next;
  wire [15:0]MDR_next;
  reg [7:0]MAR_next;
  reg zflag_next;
  wire [7:0]PC_reg;
  wire [15:0]IR_reg;
  wire [15:0]ACC_reg;
  
endmodule