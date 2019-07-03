module InstructionMem(input Clock, input[6:0] Addr, output logic[15:0] DATA);

InstrMem M1(Addr, Clock, DATA);

endmodule 