//Alex Marlow & Graham Boyer

//DataPath top level module, Conects all modules of DataPath
module Datapath(ALU_s, CLK, D_addr, D_wr, MuxSel, RF_W_Addr, RF_W_en, RF_A_addr, RF_B_addr, ALU_A, ALU_B, ALU_Out, R_data);

input [2:0] ALU_s;    //ALU selector 
input CLK, D_wr, MuxSel, RF_W_en;    //Clock, Data memory and Regster file read/write, Mux selector
input [7:0] D_addr;     //Data Memory read/write address
input [3:0] RF_W_Addr;   //Register File write address
input [3:0] RF_A_addr, RF_B_addr;    //Register File read addresses
output reg [15:0] ALU_A, ALU_B, ALU_Out;   //ALU inputs and outputs

output logic [15:0] R_data;    //output of DataMemory
logic [15:0]  MuxOut;     //output of Mux


//ALU instance
ALU A1(ALU_s, ALU_A, ALU_B, ALU_Out);
//Register File Instance
RegisterFile R1(MuxOut, RF_W_Addr, RF_W_en, RF_A_addr, RF_B_addr, ALU_A, ALU_B, CLK);
//Mux instance for ALU output and DataMemory output
Mux_16w_2_to_1 M1( MuxOut, MuxSel, ALU_Out, R_data);
//DataMemory instance
DataMem D1(CLK, D_addr , D_wr , ALU_A, R_data);




endmodule 