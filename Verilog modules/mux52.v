module mux52 (
    input [2:0] posy,
    input [2:0] seletor_mux,
    output reg [2:0] saida_mux
    );

always @(*) begin
    case(seletor_mux)
    3'd0: saida_mux = 3'd7;
    3'd1: saida_mux = 3'd7;
    3'd2: saida_mux = posy;
    3'd3: saida_mux = 3'd0;
    3'd4: saida_mux = 3'd0;
    default: saida_mux = 0;
    endcase
end

endmodule