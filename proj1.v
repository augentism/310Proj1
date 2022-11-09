



//----------------//
//TOP LEVEL MODULE//
//----------------//
module proj1(clk, rst, MemRW_IO, MemAddr_IO, MemD_IO);
  input clk;
  input rst;
  output MemRW_IO;
  output [7:0] MemAddr_IO;
  output [15:0] MemD_IO;
  wire isDivide;
  wire muxPC, muxMAR, muxACC, loadMAR, loadPC, loadACC, loadMDR,loadIR,MemRW,
       zflag;
  wire [7:0] opcode;
  wire [15:0] ACC_reg, MDR_reg, div_out;
  
  //wire MemRW;
  wire [15:0] MemD, MemQ;
  wire [7:0] MemAddr;
  //wire ACC_reg, MDR_reg;
  
  ram memory(MemRW, MemD, MemQ, MemAddr);
  datapath data(clk,rst,muxPC, muxMAR, muxACC,loadMAR,loadPC,loadACC,loadMDR,
            loadIR,opALU,zflag,opcode,MemAddr,MemD,MemQ, div_out, isDivide, 
            ACC_reg, MDR_reg);
  ctr controller(clk, rst, zflag, opcode, muxPC, muxMAR, muxACC, loadMAR, loadPC,
  loadACC,loadMDR, loadIR, opALU, MemRW, ACC_reg, MDR_reg, div_out, isDivide);

endmodule


//----------//
//RAM MODULE//
//----------//
module ram(we, d, q, addr);
  input we;
  input [15:0] d;
  output reg [15:0] q;
  input [7:0] addr;
  reg [15:0] MEM [0:16383];
  
  always@ (addr) begin
    if(we) begin
      MEM[addr] <= d;
    end else begin
      q <= MEM[addr];
    end
  end
endmodule






//---------//
//REGISTERS//
//---------//

module registers(clk, rst, PC_reg, PC_next, IR_reg, IR_next, ACC_reg, ACC_next,
MDR_reg, MDR_next, MAR_reg, MAR_next, Zflag_reg, zflag_next);
  input wire clk;
  input wire rst;
  output reg [7:0]PC_reg;
  input wire [7:0]PC_next;
  
  output reg [15:0]IR_reg;
  input wire [15:0]IR_next;
  
  output reg [15:0]ACC_reg;
  input wire [15:0]ACC_next;
  
  output reg [15:0]MDR_reg;
  input wire [15:0]MDR_next;
  
  output reg [7:0]MAR_reg;
  input wire [7:0]MAR_next;
  
  output reg Zflag_reg;
  input wire zflag_next;
  
  always @(posedge clk) begin
    case(rst)
      0: begin
        PC_reg <= PC_next;
        IR_reg <= IR_next;
        ACC_reg <= ACC_next;
        MDR_reg <= MDR_next;
        MAR_reg <= MAR_next;
      end
      1: begin  
        PC_reg <= 0;
        IR_reg <= 0;
        ACC_reg <= 0;
        MDR_reg <= 0;
        MAR_reg <= 0;
      end
    endcase
  end
endmodule


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  



  
module my8bitdivider(output reg [15:0] Q,R, output reg Done, input [15:0] A, B, 
                    input Load,Clk,Reset);
//  parameter default=3'bxx;
//  parameter load=3'b000;
//  parameter read=3'b001;
//  parameter write=3'b010;
  reg[2:0] state;

  reg[15:0] A_reg, B_reg;
  reg dummy;

  reg [15:0] A_temp;
  reg [15:0] B_temp;
  reg S_temp;
  wire [15:0] O_temp;
  wire c_temp;
  my16bitaddsub_gate a0(O_temp,c_temp,A_temp,B_temp,S_temp);
  
  
  
  
  always @(posedge Clk)
    begin
      A_reg = A;
      B_reg = B;
      if(Reset==1) begin
        state = 0;
      end   
    case(state)
    0:
    begin
      if(Load) begin
        R = A_reg;
        Q = 0;
        Done = 0;
        state = 1;
        
      end  
    end
    1:
    //If ( R < B_reg ) state 2
    //Else state 5
    begin
      if( R < B_reg ) begin
          state = 5;
      end else begin
          state = 2;
      end
    end
    2:
    begin

      A_temp = R;
      B_temp = B_reg;
      S_temp = 1;
      state = 3;
    end
    3:
    begin
      R = O_temp;
      dummy = c_temp;
      A_temp = Q;
      B_temp = 1;
      S_temp = 0;
      state = 4;
    end
    4:
    begin
      Q = O_temp;
      dummy = c_temp;
      state = 1;
    end
    5:
    begin
      Done = 1;
      state = 0;
    end
    endcase
  end
endmodule