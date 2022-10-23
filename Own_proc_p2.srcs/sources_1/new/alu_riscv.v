`timescale 1ns / 1ps
`include "define_file.v"

module alu_riscv (
    input       [31:0]  A,
    input       [31:0]  B,
    input       [4:0]   ALUOp,
    output  reg         Flag,   // reg потому что тебе потребуется мультиплексор
    output  reg [31:0]  Result  // описанный в case внутри always 
);                            // а в always, слева от "равно", всегда стоит reg


always @ *
    case(ALUOp)
        `ADD:  begin 
                 Result[31:0] = A[31:0] + B[31:0];
                 Flag = 0;
               end
        `SUB:  begin
                 Result[31:0] = A[31:0] - B[31:0];
                 Flag = 0; 
               end
        `SLL:  begin
                 Result[31:0] = A[31:0] << B[31:0];
                 Flag = 0; 
               end
        `SLT:  begin
                 Result[31:0] = $signed(A[31:0]) < $signed(B[31:0]);
                 Flag = 0; 
               end
        `SLTU: begin
                 Result[31:0] = A[31:0] < B[31:0];
                 Flag = 0; 
               end
        `XOR:  begin
                 Result[31:0] = A[31:0] ^ B[31:0];
                 Flag = 0;
               end
        `SRL:  begin
                 Result[31:0] = A[31:0] >> B[31:0];
                 Flag = 0;
               end
        `SRA:  begin
                 Result[31:0] = $signed(A[31:0]) >>> B[31:0];
                 Flag = 0;
               end
        `OR:   begin
                 Result[31:0] = A[31:0] | B[31:0];
                 Flag = 0; 
               end
        `AND:  begin
                 Result[31:0] = A[31:0] & B[31:0];
                 Flag = 0;
               end
        `BEQ:  begin 
                 Result[31:0] = 0;
                 Flag = A[31:0] == B[31:0]; 
               end 
        `BNE:  begin 
                 Result[31:0] = 0;
                 Flag = A[31:0] != B[31:0]; 
               end 
        `BLT:  begin 
                 Result[31:0] = 0;
                 Flag = $signed(A[31:0]) < $signed(B[31:0]); 
               end 
        `BGE:  begin 
                 Result[31:0] = 0;
                 Flag = $signed(A[31:0]) >= $signed(B[31:0]); 
               end 
        `BLTU: begin 
                 Result[31:0] = 0;
                 Flag = A[31:0] < B[31:0]; 
               end 
        `BGEU: begin 
                 Result[31:0] = 0;
                 Flag = A[31:0] >= B[31:0]; 
               end 
         default: begin
                  Result[31:0] = 32'b0;
                  end
    endcase
endmodule