//Alex Marlow & Graham Boyer

//* to 1 mux module used for Hex output selection
module Mux8t1(S, X0, X1, X2, X3, X4, X5, X6, X7, M);

input [2:0] S; //select input
input [15:0] X0, X1, X2, X3, X4, X5, X6, X7;  //inputs for different display options
output reg [15:0] M;   //output for Hex decoders

always@ (S, X0, X1, X2, X3, X4, X5, X6, X7) begin

    case(S)    //cases for select input
	                    //outputs for the processor
	 3'b000 : M = X0;   //PC and State outputed
	 3'b001 : M = X1;   //ALU_A outputed
	 3'b010 : M = X2;   //ALU_B outputed
	 3'b011 : M = X3;   //ALU_Out outputed
	 3'b100 : M = X4;   //There is no NextState in Processor build, so will be 0
	 3'b101 : M = X5;   //last three will be 0 in current Processor build
	 3'b110 : M = X6;
	 3'b111 : M = X7;
	 
	 endcase

end

endmodule 