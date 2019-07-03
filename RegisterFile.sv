//Alex Marlow & Graham Boyer

//module contains register memory for ALU inputs
module RegisterFile(W_data, W_addr, W_wr, Ra_addr, Rb_addr, Ra_data, Rb_data, CLK);

input [15:0] W_data;    //Write data
input [3:0] W_addr, Ra_addr, Rb_addr;  //write adress and addresses for output
input W_wr, CLK;                     //write enable and clock
output reg [15:0] Ra_data, Rb_data;   //output data for ALU

//register memory
logic [15:0] regfile [0:15];

assign Ra_data = regfile[Ra_addr];   //assigns output to correct register memory
assign Rb_data = regfile[Rb_addr];

always@(posedge CLK) begin      //writes to register memory
	if(W_wr) begin
		regfile[W_addr] <= W_data;
	end
end



endmodule 