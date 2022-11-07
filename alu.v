//----------//
//ALU MODULE//
//----------//
module alu(A, B, opALU, Rout);
  input [15:0] A, B;
  input [1:0] opALU;
  output [16:0] Rout;
  wire dummy;
  wire [15:0] addOut;
  wire [15:0] xorOut;
  
  
  my16bitaddsub_gate(addOut, dummy, A, B, opALU[1]);
  muxxor16(xorOut, A, B);
  my16bitmux(Rout, xorOut, addOut, opALU[0]);
endmodule




  //-------------------------//
  //HW3 MODULES ADD, SUB, XOR//
  //-------------------------//
  
  // 2-to-1 Multiplexer module
module my1bitmux(output out, // header & ports
                 input i0, i1, sel);
  wire n_sel, x1, x2; // internal nets
  or (out, x1, x2); // output
  and (x1, i0, n_sel); // i0 & (~sel)
  and (x2, i1, sel); // i1 & sel
  not (n_sel, sel); // invert sel
endmodule



// And Gate using 2-1 mux
module muxand(output y, input a, input b);
  supply0 gnd;
  supply1 pwr;
  my1bitmux mux1(y,gnd,a,b);
endmodule


// Xor Gate using 2-1 mux
module muxxor(output y, input a, input b);
  supply0 gnd;
  supply1 pwr;
  wire between;
  my1bitmux mux2(between,pwr,gnd,b);
  my1bitmux mux3(y,b,between,a);
endmodule


// Or Gate using 2-1 mux
module muxor(output y, input a, input b);
  supply0 gnd;
  supply1 pwr;
  my1bitmux mux4(y,b,pwr,a);
endmodule

module muxxor16(output[15:0] y, input[15:0] a, input[15:0] b);
  supply0 gnd;
  supply1 pwr;
  muxxor mux1(y[0], a[0], b[0]);
  muxxor mux2(y[1], a[1], b[1]);
  muxxor mux3(y[2], a[2], b[2]);
  muxxor mux4(y[3], a[3], b[3]);
  muxxor mux5(y[4], a[4], b[4]);
  muxxor mux6(y[5], a[5], b[5]);
  muxxor mux7(y[6], a[6], b[6]);
  muxxor mux8(y[7], a[7], b[7]);
  muxxor mux9(y[8], a[8], b[8]);
  muxxor mux10(y[9], a[9], b[9]);
  muxxor mux11(y[10], a[10], b[10]);
  muxxor mux12(y[11], a[11], b[11]);
  muxxor mux13(y[12], a[12], b[12]);
  muxxor mux14(y[13], a[13], b[13]);
  muxxor mux15(y[14], a[14], b[14]);
  muxxor mux16(y[15], a[15], b[15]);
endmodule

module muxor16(output[15:0] y, input[15:0] a, input[15:0] b);
  supply0 gnd;
  supply1 pwr;
  muxor mux1(y[0], a[0], b[0]);
  muxor mux2(y[1], a[1], b[1]);
  muxor mux3(y[2], a[2], b[2]);
  muxor mux4(y[3], a[3], b[3]);
  muxor mux5(y[4], a[4], b[4]);
  muxor mux6(y[5], a[5], b[5]);
  muxor mux7(y[6], a[6], b[6]);
  muxor mux8(y[7], a[7], b[7]);
  muxor mux9(y[8], a[8], b[8]);
  muxor mux10(y[9], a[9], b[9]);
  muxor mux11(y[10], a[10], b[10]);
  muxor mux12(y[11], a[11], b[11]);
  muxor mux13(y[12], a[12], b[12]);
  muxor mux14(y[13], a[13], b[13]);
  muxor mux15(y[14], a[14], b[14]);
  muxor mux16(y[15], a[15], b[15]);
endmodule
  
  

// Not gate using 2-1 mux
module muxnot(output y, input a);
  supply0 gnd;
  supply1 pwr;
  my1bitmux mux5(y,pwr,gnd,a);
endmodule


// Half adder using Xor and And modules
module my1bithalfadder(output sum, carry, input A, B);
  muxxor o1(sum,A,B);
  muxand a1(carry,A,B);
endmodule


// Full adder from half adder
module my1bitfulladder(output Cout, S, input A,B,Cin);
  wire x1,x2,x3;
  my1bithalfadder m0(x2,x1,A,B);
  my1bithalfadder m1(S,x3,x2,Cin);
  muxor O1(Cout,x1,x3);
endmodule


//4bit full addder from 1 bit full adder
module my8bitfulladder(output [7:0] S, output Cout, input [7:0] A, B, input Cin);
  wire [6:0] c;
  my1bitfulladder a0(c[0], S[0], A[0],B[0],Cin);
  my1bitfulladder a1(c[1], S[1], A[1],B[1],c[0]);
  my1bitfulladder a2(c[2], S[2], A[2],B[2],c[1]);
  my1bitfulladder a3(c[3], S[3], A[3],B[3],c[2]);
  my1bitfulladder a4(c[4], S[4], A[4],B[4],c[3]);
  my1bitfulladder a5(c[5], S[5], A[5],B[5],c[4]);
  my1bitfulladder a6(c[6], S[6], A[6],B[6],c[5]);
  my1bitfulladder a7(Cout, S[7], A[7],B[7],c[6]);
endmodule

module my16bitfulladder(output [15:0] S, output Cout, input [15:0] A, B, input Cin);
  wire c;

  my8bitfulladder a1(c, S[7:0], A[7:0],B[7:0],Cin);
  my8bitfulladder a2(Cout, S[15:8], A[15:8],B[15:8],c);
endmodule

//4bit multiplexer
module my8bitmux(output [7:0] Out, input [7:0] A, B, input sel);
 my1bitmux m7 (Out[7], A[7], B[7], sel);
 my1bitmux m6 (Out[6], A[6], B[6], sel);
 my1bitmux m5 (Out[5], A[5], B[5], sel);
 my1bitmux m4 (Out[4], A[4], B[4], sel);
 my1bitmux m3 (Out[3], A[3], B[3], sel);
 my1bitmux m2 (Out[2], A[2], B[2], sel);
 my1bitmux m1 (Out[1], A[1], B[1], sel);
 my1bitmux m0 (Out[0], A[0], B[0], sel);
endmodule

module my16bitmux(output [15:0] Out, input [15:0] A, B, input sel);
 my1bitmux m1 (Out[15:8], A[15:8], B[15:8], sel);
 my1bitmux m0 (Out[7:0], A[7:0], B[7:0], sel);
endmodule

//add and sub from 4bit full adder
module my8bitaddsub_gate(output [7:0] O, output Cout, input [7:0] A, B, input S);  
  supply0 gnd;
  wire [7:0] b_n,b_carry;
  muxnot n0(b_n[0], B[0]);
  muxnot n1(b_n[1], B[1]);
  muxnot n2(b_n[2], B[2]);
  muxnot n3(b_n[3], B[3]);
  muxnot n4(b_n[4], B[4]);
  muxnot n5(b_n[5], B[5]);
  muxnot n6(b_n[6], B[6]);
  muxnot n7(b_n[7], B[7]);
  my8bitmux m0(b_carry,B,b_n,S);
  my8bitfulladder fa0(O,Cout,A,b_carry,S);
endmodule

module my16bitaddsub_gate(output [15:0] O, output Cout, input [15:0] A, B, input S);  
  supply0 gnd;
  wire [15:0] b_n;
  wire b_carry;
  muxnot n0(b_n[0], B[0]);
  muxnot n1(b_n[1], B[1]);
  muxnot n2(b_n[2], B[2]);
  muxnot n3(b_n[3], B[3]);
  muxnot n4(b_n[4], B[4]);
  muxnot n5(b_n[5], B[5]);
  muxnot n6(b_n[6], B[6]);
  muxnot n7(b_n[7], B[7]);
  muxnot n8(b_n[8], B[0]);
  muxnot n9(b_n[9], B[1]);
  muxnot nA(b_n[10], B[10]);
  muxnot nB(b_n[11], B[11]);
  muxnot nC(b_n[12], B[12]);
  muxnot nD(b_n[13], B[13]);
  muxnot nE(b_n[14], B[14]);
  muxnot nF(b_n[15], B[15]);
  my16bitmux m0(b_carry,B,b_n,S);
  my16bitfulladder fa0(O,Cout,A,b_carry,S);
endmodule