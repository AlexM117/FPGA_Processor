//Alex Marlow & Graham Boyer


//ALU module
module ALU(s0, A, B, out);

input [2:0] s0;     //ALU selector
input [15:0] A, B;   //ALU inputs
output [15:0] out;    //ALU output
reg [15:0] temp;     //temporary

assign out = temp;    //assigning temp to out

always @(s0, A, B) begin    //selects the correct type of math function
   if(s0 == 0) begin
			temp <= 0;
	end
	else if(s0 == 1) begin
		temp <= A + B;
	end
	else if(s0 == 2) begin
		temp <= A - B;
	end
	else if(s0 == 3) begin
		temp <= A;
	end
	else if(s0 == 4) begin
		temp <= A^B;
	end
	else if(s0 == 5) begin
		temp <= A | B;
	end
	else if(s0 == 6) begin
		temp <= A & B;
	end
	else if(s0 == 7) begin
		temp <= A + 1;
	end
	
end

endmodule 