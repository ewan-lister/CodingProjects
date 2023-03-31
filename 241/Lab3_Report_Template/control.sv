// This module receives an 11 bit opcode and outputs
// resulting signals in order to select a specific datapath out of the different modules
// found in the total datapath. It is configured to execute R, I, D, B, and CB
// type instructions

module control(Reg2Loc, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, opcode, clk, reset);
    output logic Reg2Loc, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite;
    input logic [10:0] opcode;

    
endmodule

module control_testbench();


endmodule

