/*
 *	Alex Marlow & Graham Boyer
 *	TCES 330
 * Spring 2017
 *	IR: feeds instruction memory to the state machine
 *
 */

module IR(	input logic[15:0] DATA, 
				input logic IR_id, Clock, Reset, 
				output logic[15:0] IR);

 


always @(posedge Clock) begin
	case(Reset) 
		1'b0	:	begin
					case(IR_id)
					1'b0	:	IR <= IR;
					1'b1	:	IR	<= DATA;
					endcase
					end
		1'b1	:	begin
					IR <= 16'h0000;
					end
	endcase // (Reset)

end // always @(Clock) begin

endmodule

module IR_testBench();

logic[15:0] DATA;
logic IR_id, Clock, Reset;
logic[15:0] IR;


IR ir(DATA, IR_id, Clock, Reset, IR);

always begin
Clock = 0; #5;
Clock = 1; #5;
end

initial begin
Reset = 1;
DATA = 16'hFA43;
IR_id = 1'b0;
#100;
IR_id = 1'b1;
#100;
Reset = 1'b0;
#100;
IR_id = 1'b1;
#10;
IR_id = 1'b0;
DATA = 16'hF0F0;
#100;
IR_id = 1'b1;
#10;
IR_id = 1'b0;
#100;
Reset = 1'b1;
#1000;
$stop;
end

endmodule
