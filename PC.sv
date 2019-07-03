/*
 *	Alex Marlow & Graham Boyer
 *	TCES 330
 * Spring 2017
 *	PC: program counter
 *
 */

module PC(	input logic Up, Reset, Clock, 
				output logic[6:0] Addr );

initial begin
	Addr = 5'b00000;
end
				
always @(posedge Clock) begin
	case(Reset)
		1'b0		:	begin
						case(Up)
						1'b0	:	Addr <= Addr;
						1'b1	:	Addr <= Addr + 1'b1;
						endcase
						end
		1'b1		:	Addr = 5'b00000;
	endcase // clear
end // always @(posedge Clock) begin

endmodule

module PC_testBench();

logic Up;
logic Reset;
logic Clock;
logic[4:0] Addr;


PC pc(Up, Reset, Clock, Addr );

always begin
	Clock = 1'b0; #5;
	Clock = 1'b1; #5;
end
	
initial begin
Reset = 1'b1;
Up = 1'b0;
#50;
Up = 1'b1;
#50;
Reset = 1'b0;
Up = 1'b0;
#100;
Up = 1'b1;
#1000;
Reset = 1'b1;
#200;
$stop;
end	
	
endmodule
