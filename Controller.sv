/*
 *	Alex Marlow & Graham Boyer
 *	TCES 330
 * Spring 2017
 *	Controller
 *
 */

module Controller(input logic Clock, Reset, 
						output logic D_wr, RF_s, PC_up, IR_id, PC_clr, 
						output logic[2:0] ALU_s0,
						output logic[3:0] RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, 
						output logic[7:0] D_addr, output logic[15:0] DATA, IR, output logic[3:0] state, output logic[6:0] Addr);

						
						
//logic[4:0] Addr;

// InstructionMem(input CLK, 
//						input [4:0] Addr, 
//						output reg [15:0] DATA);

InstructionMem mem(Clock, Addr, DATA);

// PC( 	input logic Up, Clear, Clock, 
//			output logic[4:0] Addr );						
PC pc(PC_up, Reset, Clock, Addr);


//IR(	input logic[15:0] DATA, 
//		input logic IR_id, Clock, Reset, 
//		output logic[15:0] IR);
				
IR ir(DATA, IR_id, Clock, Reset, IR);

// stateMachine(	input logic Clock, Reset,
//							input logic[15:0] IR, 
//							output logic PC_clr, IR_id, PC_up, D_wr, RF_s, 
//							output logic[2:0] ALU_s0,
//							output logic[3:0] RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, 
//							output logic[7:0] D_addr);

stateMachine sam(Clock, Reset, IR, PC_clr, IR_id, PC_up, D_wr, RF_s,ALU_s0,
					RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, D_addr, state);
													


endmodule
