/*
 *	Alex Marlow & Graham Boyer
 *	TCES 330
 * Spring 2017
 *	StateMachine
 *
 */
 
module stateMachine(	input logic Clock, Reset,
							input logic[15:0] IR, 
							output logic PC_clr, IR_id, PC_up, D_wr, RF_s, 
							output logic[2:0] ALU_s0,
							output logic[3:0] RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, 
							output logic[7:0] D_addr, output logic[3:0] stateOut);

// FSM state
logic[3:0] state;
logic [3:0] decoder;

localparam	NOOP		= 4'b0000,
				STORE		= 4'b0001,
				LOAD_A	= 4'b1001,
				LOAD_B	= 4'b0010,
				ADD		= 4'b0011,
				SUB		= 4'b0100,
				HALT		= 4'b0101,
				Init 		= 4'b0110,
				Fetch		= 4'b0111,
				Decode	= 4'b1000;

assign decoder = IR[15:12];
assign stateOut =  state;

always @(posedge Clock) begin
	case(Reset)
		1'b0	:	begin
					case(state)
					Init		:	begin
									PC_clr <= 1;
									PC_up <= 0;
									IR_id <= 1;
									state <= Fetch;
									end
					Fetch		:	begin
					            RF_W_en <= 0;
									PC_up <= 1;
									IR_id <= 1;
									state <= Decode;
									ALU_s0 <= 3;
									end // Fetch
					Decode	:	begin 
									case(decoder)
									4'b0000	: state <= NOOP;
									4'b0001	: state <= STORE;
									4'b0010	: state <= LOAD_A;
									4'b0011	: state <= ADD;
									4'b0100	: state <= SUB;
									4'b0101	: state <=	HALT;
									endcase // endcase Decode
									PC_up <= 0;
									PC_clr <= 0;
									end // Decode
					HALT		:	state <= HALT;
					SUB		:	begin
									RF_Ra_addr <= IR[11:8];
									RF_Rb_addr <= IR[7:4];
									RF_W_addr <= IR[3:0];
									RF_W_en <= 1;
									ALU_s0 <= 2;
									state <= Fetch;
									RF_s <= 0;
									end
					ADD		:	begin
									RF_Ra_addr <= IR[11:8];
									RF_Rb_addr <= IR[7:4];
									RF_W_addr <= IR[3:0];
									RF_W_en <= 1;  
									ALU_s0 <= 1;
									state <= Fetch;
									RF_s <= 0;
									end // ADD
					STORE		:	begin
									RF_Ra_addr <= IR[11:8];
									D_addr <= IR[7:0];
									D_wr <= 1;
									state <= Fetch;
									end // STORE
					LOAD_A	:	begin
									D_addr <= IR[11:4];
									RF_W_addr <= IR[3:0];
									RF_s <= 1;
									state <= LOAD_B;
									D_wr <= 0;
									end // LOAD_A
					LOAD_B	:	begin
									D_addr <= IR[11:4];
									RF_W_addr <= IR[3:0];
									RF_s <= 1;
									RF_W_en <= 1;
									state <= Fetch;
									end // LOAD_B
					NOOP		:	begin
									state <= Fetch;
									end
					default	:	begin
									state <= Init;
									PC_clr <= 0;
									PC_up <= 0;
									IR_id <= 0;
									end
					endcase // stateMachine endcase
					end
		1'b1	:	begin
		         RF_Ra_addr <= 0;
					RF_Rb_addr <= 0;
					state <= Init;
					PC_clr <= 0;
					PC_up <= 0;
					IR_id <= 0;
					end // Rest
	endcase // case(Reset)
end // end always @(posedge Clock)

endmodule


//test bench for State machine
module stateMachine_testBench();

logic Clock, Reset; // input
logic[15:0] IR; // input
logic PC_clr, IR_id, PC_up, D_wr, RF_s; // output
logic[2:0] ALU_s0; // output
logic[3:0] RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr; // output
logic [7:0] D_addr; // output
			
//state machine instace			
stateMachine dut(Clock, Reset, IR, PC_clr, IR_id, PC_up, D_wr, RF_s, ALU_s0,
							RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, D_addr);

always begin
Clock = 0; #5;
Clock = 1; #5;
end

initial begin
Reset = 1'b1;
IR = 16'h0731;
#100;
Reset = 1'b0;
#50;
IR = 16'h1731;
#50;
IR = 16'h2731;
#50;
IR = 16'h3731;
#50;
IR = 16'h4731;
#50;
IR = 16'h5731;
#50;
IR = 16'h6731;
#100;
Reset = 1'b1;
#1000;
$stop;
end
endmodule




