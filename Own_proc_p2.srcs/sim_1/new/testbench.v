`timescale 1ns / 1ps

module testbench();

        reg  [31:0] A;
        reg  [31:0] B;
        reg  [4:0]  ALUOp;
        wire        Flag;
        wire [31:0] Result;
	
        alu_riscv DUT(A, B, ALUOp, Flag, Result);
	    
	    initial begin 
	      task_all_actions(7, 3, 5'b00000); // adder 
	      task_all_actions(7, 3, 5'b01000); // subtraction 
	      task_all_actions(7, 3, 5'b00001); // left shift 
	      task_all_actions(-7, -3, 5'b00010); // signed comparsion 
	      task_all_actions(7, 3, 5'b00011); // unsigned comparsion 
	      task_all_actions(5'b00000, 5'b11111, 5'b00100); // XOR
	      task_all_actions(5'b10010, 5'b11111, 5'b00101); // right shift 
	      task_all_actions(5'b10010, 5'b11111, 5'b01101); // arithmetic right shift 
	      task_all_actions(7, 3, 5'b00110); // or 
	      task_all_actions(7, 3, 5'b00111); // and
	      task_all_actions(7, 3, 5'b11000); // equality 
	      task_all_actions(7, 3, 5'b11001); // inequality 
	      task_all_actions(-7, -3, 5'b11100); // signed < 
	      task_all_actions(-7, -3, 5'b11101); // signed >= 
	      task_all_actions(7, 3, 5'b11110); // unsigned < 
	      task_all_actions(7, 3, 5'b11111); // unsigned >= 
	    end
	    
	    task task_all_actions;
	    
	    input [31:0]   a_op;
	    input [31:0]   b_op;
	    input [4:0]  action; // Selecting current of 16 types of actions 
        begin
          A = a_op;
          B = b_op; 
          ALUOp = action;
          
          #100
          
          if (ALUOp == 5'b00000)
            $display("%d + %d = %d", A, B, Result);
            
          else if (ALUOp == 5'b01000)
            $display("%d - %d = %d", A, B, Result);
            
          else if (ALUOp == 5'b00001)
            $display("%d << %d = %d", A, B, Result);
          
          else if ((ALUOp == 5'b00010) & (Result == 1))
            $display("%d < %d", $signed(A), $signed(B));
          
          else if ((ALUOp == 5'b00011) & (Result == 1))
            $display("%d < %d", A, B);
          
          else if (ALUOp == 5'b00100) 
            $display("%d ^ %d = %d", A, B, Result); 
          
          else if (ALUOp == 5'b00101) 
            $display("%d >> %d = %d", A, B, Result);
                        
          else if (ALUOp == 5'b01101) 
            $display("%d >>> %d = %d", $signed(A), B, $signed(Result));
          
          else if (ALUOp == 5'b00110)
            $display("%d | %d = %d", A, B, Result);
                    
          else if (ALUOp == 5'b00111)
            $display("%d & %d = %d", A, B, Result);
          
          else if ((ALUOp == 5'b11000) & (A == B))
            $display("%d = %d", A, B);
          
          else if ((ALUOp == 5'b11001) & (A != B))
            $display("%d != %d", A, B);
                    
          else if ((ALUOp == 5'b11100) & (Flag == 1))
            $display("%d < %d", $signed(A), $signed(B));
                    
          else if ((ALUOp == 5'b11101) & (Flag == 1))
            $display("%d >= %d", $signed(A), $signed(B));
          
          else if ((ALUOp == 5'b11110) & (Flag == 1))
            $display("%d < %d", A, B);
            
          else if ((ALUOp == 5'b11111) & (Flag == 1))
            $display("%d >= %d", A, B);
            
          else
            $display("Invalid expression ");
        end
        
        endtask
	
endmodule