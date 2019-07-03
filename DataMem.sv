//Alex Marlow & Graham Boyer

//module acceses the data Memory
module DataMem(CLK, addr, wr, W_data, R_data);

input CLK;           //clock
input [0:7]addr;   //data address
input wr;   //data read/write selector
input [0:15]W_data;     //write data input
output reg [0:15] R_data;   //read data output

//data Memory intance
Data	D1(addr ,CLK, W_data ,~wr , wr, R_data ); 

endmodule 