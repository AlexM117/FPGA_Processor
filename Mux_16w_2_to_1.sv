//Alex Marlow & Graham Boyer TCES 330 

//Mux module for ALU output and Data Memory output
module Mux_16w_2_to_1( M, S, X, Y);
input S;    //mux selector
input [15:0] X, Y;  //mux inputs
output reg [15:0] M;   //output of mux

//mux logic
always_comb begin

case(S)

     1'b0: M = X;
	  
	  1'b1: M = Y;

endcase
end

endmodule
