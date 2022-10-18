`timescale 1ns / 1ps

module fulladder32(
            input  [31:0]  A,
            input  [31:0]  B,
            input          Pin,
            output [31:0]  S,
            output         Pout
); 
        parameter N = 32;
        wire [N-2:0] P;
        
                fulladder a0(
                         .a(A[0]),
                         .b(B[0]),
                         .Pin(Pin),
                         .S(S[0]),
                         .Pout(P[0])
                );
           
genvar i;
generate 
        for (i=1; i<(N-1); i=i+1) begin : newgen
                fulladder a (
                        .a(A[i]),
                        .b(B[i]),
                        .Pin(P[i-1]),
                        .S(S[i]),
                        .Pout(P[i])
                );
        end
        
endgenerate

                fulladder a_last(
                                 .a(A[N-1]),
                                 .b(B[N-1]),
                                 .Pin(P[N-2]),
                                 .S(S[N-1]),
                                 .Pout(Pout)
                        );
        
endmodule
