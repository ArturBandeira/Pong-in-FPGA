module mux51 (
    input [2:0] posicao_raquete_cima,
    input [2:0] posicao_raquete_baixo,
    input [2:0] posx,
    input [2:0] seletor_mux,
    output reg [2:0] saida_mux
    );

always @(*) begin
    case(seletor_mux)
    3'd0: saida_mux = posicao_raquete_cima;
    3'd1: saida_mux = posicao_raquete_cima+3'd1;
    3'd2: saida_mux = posx;
    3'd3: saida_mux = posicao_raquete_baixo;
    3'd4: saida_mux = posicao_raquete_baixo+3'd1;
    default: saida_mux = 0;
    endcase
end

endmodule