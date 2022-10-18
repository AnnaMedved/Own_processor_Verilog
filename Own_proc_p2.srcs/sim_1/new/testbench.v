`timescale 1ns / 1ps

module testbench();

        reg [31:0] A;
        reg [31:0] B;
        reg Pin;
        wire Pout;
        wire [31:0] S;
	
        fulladder32 DUT(         // <- Подключаем проверяемый модуль
                          .A(A),
                          .B(B),
                          .Pin(Pin),
                          .S(S),
                          .Pout(Pout)
        );
	
        initial begin
            A = 32'd1; B = 32'd2; Pin = 32'd3;
            #5;                    
            
            A = 32'd10; B = 32'd20; Pin = 32'd30;
            #5;                  
                                 
            A = 32'd100; B = 32'd200; Pin = 32'd300;	
            #5;
            
            A = 32'd1000; B = 32'd2000; Pin = 32'd3000;
            #5;
        end
	
endmodule