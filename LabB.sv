//Alex Marlow & Graham Boyer  Processor Project


//module connects Processor to the board as well as the Button sync, Key filter and output decoders
module LabB(SW, KEY, CLOCK_50, LEDG, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

input [17:0] SW;   //switches and Keys for input
input [3:0] KEY;
input CLOCK_50;    // 50 Mhz input clock from board
output reg [7:0] LEDG;    //LEDs
output reg [17:0] LEDR;
output reg [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;   //Hex outputs

//for Button sync and Key filter outputs
logic CLK, Bo;

//processor outputs and mux inputs
logic [15:0] ALU_A, ALU_B, ALU_Out, IR_Out, M;
logic [7:0] NextState_Out, PC_Out, State_Out;



//assigning LEDs to Keys
assign LEDG[3:0] = ~KEY[3:0];

//Button sync and Key Filter modules
ButtonSync B1(CLOCK_50, KEY[2], Bo);
KeyFilter K1(CLOCK_50, Bo, CLK);

//Processor instance
Processor P1(CLK, ~KEY[1], IR_Out, PC_Out, State_Out, NextState_Out, ALU_A, ALU_B, ALU_Out);

//Mux module for hex outputs
Mux8t1 M1(SW[17:15], {{1'b0,PC_Out[6:0]}, State_Out}, ALU_A, ALU_B, ALU_Out, {NextState_Out, 8'b0} , 16'h0, 16'h0, 16'h0, M);

//Hex output decoders
HexaHex H0(HEX0, IR_Out[3:0]);
HexaHex H1(HEX1, IR_Out[7:4]);
HexaHex H2(HEX2, IR_Out[11:8]);
HexaHex H3(HEX3, IR_Out[15:12]);
HexaHex H4(HEX4, M[3:0]);
HexaHex H5(HEX5, M[7:4]);
HexaHex H6(HEX6, M[11:8]);
HexaHex H7(HEX7, M[15:12]);





endmodule 