module fluxo_dados(
    input clk,
    input clk_real,
    input reset,
    input botao_esquerdo_cima,
    input botao_direito_cima,
    input botao_esquerdo_baixo,
    input botao_direito_baixo,
    input pausa,
    output [2:0] linha_bola,
    output [2:0] coluna_bola,
    output ganhou,
    output perdeu,
    output pulso_pausa,
    output [2:0] pontos,
    output [2:0] posicao_raquete_cima,
    output [2:0] posicao_raquete_baixo
);
wire pulso_botao_esquerdo_cima;
wire pulso_botao_direito_cima;
wire pulso_botao_esquerdo_baixo;
wire pulso_botao_direito_baixo;

wire [2:0] posicao_cima;
wire [2:0] posicao_baixo;

assign posicao_raquete_cima = posicao_cima;
assign posicao_raquete_baixo = posicao_baixo;

wire fim_contagem;

wire [2:0] posx;
wire [2:0] posy;

wire [2:0] seletor_mux;

wire pulso_pausa2;

assign pulso_pausa = pulso_pausa2;

edge_detector edge1 (.clock(clk),.reset(reset),.sinal(botao_esquerdo_cima),.pulso(pulso_botao_esquerdo_cima));
edge_detector edge2 (.clock(clk),.reset(reset),.sinal(botao_direito_cima),.pulso(pulso_botao_direito_cima));
edge_detector edge3 (.clock(clk),.reset(reset),.sinal(botao_esquerdo_baixo),.pulso(pulso_botao_esquerdo_baixo));
edge_detector edge4 (.clock(clk),.reset(reset),.sinal(botao_direito_baixo),.pulso(pulso_botao_direito_baixo));
edge_detector edge5 (.clock(clk_real),.reset(reset),.sinal(pausa),.pulso(pulso_pausa2));

posicao_raquete pos_cima(.clk(clk), .reset(reset), .botao_direita(pulso_botao_direito_cima), .botao_esquerda(pulso_botao_esquerdo_cima), .posicao(posicao_cima));
posicao_raquete pos_baixo(.clk(clk), .reset(reset), .botao_direita(pulso_botao_direito_baixo), .botao_esquerda(pulso_botao_esquerdo_baixo), .posicao(posicao_baixo));

posicao_bola pos_bola(.clk(clk), .reset(reset), .posicao_raquete_cima(posicao_cima), .posicao_raquete_baixo(posicao_baixo), .atualiza_posicao(fim_contagem), .posx(coluna_bola), .posy(linha_bola), .ganhou(ganhou), .perdeu(perdeu), .pontos(pontos));

contador_generico contador_tempo(.clock(clk), .zera_as(reset), .zera_s(reset), .conta(1'b1), .Q(), .fim(fim_contagem), .meio());

contador_generico #(.M(5), .N(3)) contador_mux(.clock(clk), .zera_as(reset), .zera_s(reset), .conta(1'b1), .Q(seletor_mux), .fim(), .meio());

endmodule