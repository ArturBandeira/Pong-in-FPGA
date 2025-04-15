module posicao_bola(
    input clk,
    input reset,
    input [2:0] posicao_raquete_cima,
    input [2:0] posicao_raquete_baixo,
    input atualiza_posicao,
    output reg [2:0] posx,
    output reg [2:0] posy,
    output perdeu,
    output ganhou,
	 output reg [2:0] pontos
);
reg vetx;
reg vety;

assign perdeu = (posy == 3'd0 || posy == 3'd7) ? 1'b1 : 1'b0;
assign ganhou = (pontos == 3'd5) ? 1'b1 : 1'b0;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        posx <= 3'd4;
        posy <= 3'd4;
        vetx <= 1'd1;
        vety <= 1'd1;
        pontos <= 3'd0;
    end
    else if (~atualiza_posicao) begin

        if(posy == 3'd6 && vety) begin
            if(posx == posicao_raquete_cima || posx == posicao_raquete_cima+3'd1) begin
                vety <= ~vety;
                pontos <= pontos + 3'd1;
            end
            if((posx == posicao_raquete_cima-3'd1 && vetx) || (posx == posicao_raquete_cima+3'd2 && ~vetx)) begin
                vetx <= ~vetx;
                vety <= ~vety;
                pontos <= pontos + 3'd1;
            end
        end

        if(posy == 3'd1 && ~vety) begin
            if(posx == posicao_raquete_baixo || posx == posicao_raquete_baixo+3'd1) begin
                vety <= ~vety;
                pontos <= pontos + 3'd1;
            end
            if((posx == posicao_raquete_baixo-3'd1 && vetx) || (posx == posicao_raquete_baixo+3'd2 && ~vetx)) begin
                vetx <= ~vetx;
                vety <= ~vety;
                pontos <= pontos + 3'd1;
            end
        end

 
        if(posx == 3'd7 || posx == 3'd0) begin
            vetx <= ~vetx;
        end
    end
    else if (atualiza_posicao && ~reset) begin
 
        if(vetx) 
            posx <= posx + 3'd1;
        else
            posx <= posx - 3'd1;

        if(vety)
            posy <= posy + 3'd1;
        else
            posy <= posy - 3'd1;
    end
end

endmodule
