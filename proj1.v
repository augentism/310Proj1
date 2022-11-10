

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
  wire [1:0] opALU;
  
  //wire MemRW;
  wire [15:0] MemD, MemQ;
  wire [7:0] MemAddr;
  //wire ACC_reg, MDR_reg;
  
  ram ram_ins(MemRW, MemD, MemQ, MemAddr);
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
  reg [15:0] mem256x16 [0:255];
  
  always@ (*) begin
	q <= mem256x16[addr];
    if(we) begin
      mem256x16[addr] <= d;
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


// module my8bitdivider(output reg [15:0] Q,R, output reg Done, input [15:0] A, B, 
                    // input Load,Clk,Reset);
// //  parameter default=3'bxx;
// //  parameter load=3'b000;
// //  parameter read=3'b001;
// //  parameter write=3'b010;
  // reg[2:0] state;

  // reg[15:0] A_reg, B_reg;
  // reg dummy;

  // reg [15:0] A_temp;
  // reg [15:0] B_temp;
  // reg S_temp;
  // wire [15:0] O_temp;
  // wire c_temp;
  // my16bitaddsub_gate a0(O_temp,c_temp,A_temp,B_temp,S_temp);
  
  
  
  
  // always @(posedge Clk)
    // begin
      // A_reg = A;
      // B_reg = B;
      // if(Reset==1) begin
        // state = 0;
      // end   
    // case(state)
    // 0:
    // begin
      // if(Load) begin
        // R = A_reg;
        // Q = 0;
        // Done = 0;
        // state = 1;
        
      // end  
    // end
    // 1:
    // //If ( R < B_reg ) state 2
    // //Else state 5
    // begin
      // if( R < B_reg ) begin
          // state = 5;
      // end else begin
          // state = 2;
      // end
    // end
    // 2:
    // begin

      // A_temp = R;
      // B_temp = B_reg;
      // S_temp = 1;
      // state = 3;
    // end
    // 3:
    // begin
      // R = O_temp;
      // dummy = c_temp;
      // A_temp = Q;
      // B_temp = 1;
      // S_temp = 0;
      // state = 4;
    // end
    // 4:
    // begin
      // Q = O_temp;
      // dummy = c_temp;
      // state = 1;
    // end
    // 5:
    // begin
      // Done = 1;
      // state = 0;
    // end
    // endcase
  // end
// endmodule

module my8bitdivider(output reg [15:0] Q, R, output reg Done, input [15:0] A, B, input Load, clk, Reset);
  parameter S0 = 3'b000,  
            S1 = 3'b001,  
            S2 = 3'b010,  
            S3 = 3'b011,  
            S4 = 3'b100,  
            S5 = 3'b101;
  
  // need 3 bits to represent 5 states     
  reg [2:0] state, next;
  
  wire C_out;
  reg S;
  
  reg [15:0] A_reg, B_reg, A_temp, B_temp;
  wire [15:0] O_temp;
  reg unused;
  
  always @ (posedge clk, posedge Reset)
  begin
    if (Reset)
      state <= S0;
    else
      state <= next;
  end
  
  my16bitaddsub_gate a0(O_temp, C_out, A_temp, B_temp, S);
  
  always @ (state or Load)
    case (state)
        S0: begin
              if (Load)
                begin A_reg=A; B_reg=B; R=A_reg; Q=0; Done=0; next = S1; end
              else next = S0;
            end
              
        S1: begin 
              if(R >= B_reg) next = S2;
              else next = S5; 
            end
        // select 1 for subtract                    
        S2: begin A_temp=R; B_temp=B_reg; S=1; next=S3; end
              
        S3: begin R=O_temp; unused=C_out; A_temp=Q; B_temp=1; S=0; next=S4; end
        
        S4: begin Q=O_temp; unused=C_out; next=S1; end
                      
        S5: begin Done=1; next=S0; end
        
        default: 
            begin 
              A_temp=0; B_temp=0; S=0; A_reg=0; B_reg=0; R=0; Q=0; Done=0; unused=0; next=S0;
            end
    endcase
endmodule

module proj1_tb();
reg clk, rst;
wire MemRW_IO;
wire [7:0] MemAddr_IO;
wire [15:0] MemD_IO;


proj1 dut(clk, rst, MemRW_IO, MemAddr_IO, MemD_IO);

always
#5 clk = !clk;
initial begin
clk=1'b0;
rst=1'b1;
$readmemh("memory.list", proj1_tb.dut.ram_ins.mem256x16);
#20 rst=1'b0;
#40000 //might need to be very large
$display("Final value\n");
$display("0x000e %d\n",proj1_tb.dut.ram_ins.mem256x16[16'h000e]);
$finish;
end
endmodule

