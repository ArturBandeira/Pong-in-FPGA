module posicao_raquete (
    input clk,
    input botao_direita,
    input botao_esquerda,
    input reset,
    output reg [2:0] posicao
    );

always @(posedge clk or posedge reset) begin
    if(reset) begin
        posicao <= 3'd3;
    end
    else begin
        if(botao_direita && posicao!=3'd6) begin
            posicao <= posicao + 1'b1;
        end
        else if(botao_esquerda && posicao!=0) begin
            posicao <= posicao - 1'b1;
        end
        else begin
            posicao <= posicao;
        end
    end
end

endmodule