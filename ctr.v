//----------//
//CONTROLLER//
//----------//
module ctr(clk, rst, zflag, opcode, muxPC, muxMAR, muxACC, loadMAR, loadPC, loadACC,
			loadMDR, loadIR, opALU, MemRW);
  input clk, rst, zflag;
  input [7:0] opcode;
  output reg muxPC, muxMAR, muxACC, loadMAR, loadPC, loadACC, loadMDR, loadIR, MemRW;
  output reg [1:0] opALU;
  reg [3:0] state, next_state;
  

  
// 0x01 ADD
// 0x02 SUB
// 0x03 MUL
// 0x04 DIV
// 0x05 XOR
// 0x06 JUMP
// 0x07 JUMPZ
// 0x08 STORE
// 0x09 LOAD

  
  always @(posedge clk)
    if(rst) begin
      state <= 0;
    end else begin 
    state <= next_state;
    end
    
    
    always @(*) begin
    
    muxPC = (state == 11) ? 1 : 0;
    muxMAR = (state == 3) ? 1 : 0;
    muxACC = (state == 9) ? 1 : 0;
    loadMAR = (state == 0 || state == 3) ? 1 : 0;
    loadPC = (state == 0 || state == 11) ? 1 : 0;
    loadACC = (state == 5 || state == 7 || state == 9 ||
               state == 13 || state == 15) ? 1 : 0;
    loadMDR = (state == 1 || state == 6 || state == 12 ||
               state == 4 || state == 8 || state == 14) ? 1 : 0;
    loadIR = (state == 2) ? 1 : 0;
    MemRW = (state == 10) ? 1 : 0;
    opALU = (state == 5 && opcode == 1) ? 1 : 0;
    opALU = (state == 5 && opcode == 2) ? 3 : 0;
    
    
    case(state)
      00: begin //Fetch 1

        next_state = 1;
      end
      01: begin //Fetch 2

        next_state = 2;
      end
      02: begin //Fetch 3
        next_state = 3;
      end
      03: begin //Decode
        if(opcode == 1) begin
          next_state = 4; //add with no s
        end
        if(opcode == 2) begin
          next_state = 4; //add but with an s
        end
        if(opcode == 3) begin
          next_state = 14; //mult
        end
        if(opcode == 04) begin
          next_state = 12; //div
        end
        if(opcode == 5) begin
          next_state = 6;
        end
        if(opcode == 6) begin
          next_state = 11;
        end
        if(opcode == 7) begin
          next_state = 0;
        end
        if(opcode == 8) begin
          next_state = 10;
        end
        if(opcode == 9) begin
          next_state = 8;
        end
      end
      4: begin //ADD_1
        next_state = 5;
      end
      5: begin //ADD_2
        next_state = 0;
        
      end
      6: begin //XOR_1
        next_state = 7;
      end
      7: begin //XOR_2
        next_state = 0;

      
      end
      8: begin //LOAD_1
        next_state = 9;
      
      end
      9: begin //LOAD_2
        next_state = 0;
      end
      10: begin //STORE_1
        next_state = 0;
      
      end
      11: begin //JUMP
        next_state = 0;
      
      end
      12: begin //DIV_1
        next_state = 13;
      
      end
      13: begin //DIV_WAIT
        //if(my 8 bit divider is done)
        //next_state = 0;
      end
      14: begin //MULT_1
        next_state = 15;
      end
      15: begin //MULT_WAIT
        next_state = 0;
      end
    endcase
  end
endmodule