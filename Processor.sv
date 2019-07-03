//Alex Marlow & Graham Boyer

//Processor top module connects the Controller and DataPath of the Processor
module Processor(Clk, Reset, IR_Out, PC_Out, State, NextState, ALU_A, ALU_B, ALU_Out);

input Clk, Reset;  //clock and reset
output logic [15:0] IR_Out, ALU_A, ALU_B, ALU_Out;   //ALU inputs and outputs and IR
output logic [6:0] PC_Out;   //PC adress out
output logic [3:0] State, NextState;    //state of state machine, Next State does not exist

assign NextState = 4'b0000;     //assigning 0 to nextState

logic [2:0] ALU_s0;         //ALU selector
logic MuxSel;               //Mux selector
logic D_wr;                 //Data memory write/read selector
logic [7:0] D_addr;         //Data memory read/write address
logic [3:0] RF_W_Addr,RF_W_en;     //Register File write/read address and enable
logic [3:0] RF_A_addr, RF_B_addr;   //Register File addresses for output


//outputs used in Controller testing but not Processor testing
logic RF_s, PC_up, IR_id, PC_clr;
logic[15:0] DATA;
logic [15:0] R_data;

//Controller Instance
Controller C1(Clk, Reset, D_wr, RF_s, PC_up, IR_id, PC_clr, ALU_s0, RF_W_Addr, RF_W_en, RF_A_addr, RF_B_addr, D_addr, DATA, IR_Out, State, PC_Out);

//DataPath Instance
Datapath D1(ALU_s0, Clk, D_addr, D_wr, RF_s, RF_W_Addr, RF_W_en, RF_A_addr, RF_B_addr, ALU_A, ALU_B, ALU_Out, R_data);



endmodule 