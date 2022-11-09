//--------//
//DATAPATH//
//--------//
module datapath(clk,rst,muxPC,muxMAR,muxACC,loadMAR,loadPC,loadACC,loadMDR,
loadIR,opALU,zflag,opcode,MemAddr,MemD,MemQ, div_out, isDivide, ACC_reg, MDR_reg);
  input [15:0] div_out;
  input isDivide;
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
  output reg [7:0]opcode;
  
  output reg [7:0]MemAddr;
  output reg [15:0]MemD;
  
  input [15:0]MemQ;
  reg [7:0]PC_next;
  reg [15:0]IR_next;
  reg [15:0]ACC_next;
  reg [15:0]MDR_next;
  reg [7:0]MAR_next;
  reg zflag_next;
  
  wire [7:0]PC_reg;
  wire [15:0]IR_reg;
  output wire [15:0]ACC_reg;
  output wire [15:0]MDR_reg;
  wire [7:0]MAR_reg;
  wire zflag_reg;
  wire [15:0]ALU_out;
  
  registers regs(clk, rst, PC_reg, PC_next, IR_reg, IR_next, ACC_reg, ACC_next,
                MDR_reg, MDR_next, MAR_reg, MAR_next, zflag_reg, zflag_next);
  
  
 alu arith(ACC_reg, MDR_reg, opALU, ALU_out);
 
 //my8bitdivider div(DIV_out, remainder, complete, ACC_reg, MDR_reg, DIV_load, clk, rst);

 

 
  always @ (*) begin
    if(loadPC) PC_next = PC_reg + 1;
    if(loadIR) IR_next = MDR_reg;     //???

    if(loadACC == 1) ACC_next = (muxACC) ? ALU_out: MDR_reg;

    ACC_next = (loadACC) ? ((isDivide) ? ALU_out : div_out) : MDR_reg; 
	
	
	
    if(loadMDR) MDR_next = MemQ;      //???
    MAR_next = (loadMAR) ? PC_reg : IR_reg[15:8];
    
    zflag_next = (ACC_reg==0) ? 1:0;
    opcode = IR_reg[7:0];
    MemAddr = MAR_reg;
    MemD = ACC_reg;
  
  end
  
  
  
  
endmodule