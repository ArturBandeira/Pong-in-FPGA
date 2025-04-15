module top_level (
    input reset,
    input clock,
    input iniciar,
    input botao_direito_cima,
    input botao_esquerdo_cima,
    input botao_direito_baixo,
    input botao_esquerdo_baixo,
    input pausa,
    output perdeu_jogo,
    output venceu_jogo,
    output [2:0] coluna_bola,
    output [2:0] linha_bola,
    output [2:0] db_estado,
    output [6:0] pontos_7seg,
    output [2:0] posicao_cima,
    output [2:0] posicao_baixo
);

wire ganhou;
wire perdeu;
wire reseta_fd;
wire pulso_pausa;
wire pausa_fd;
wire clock_fd;
wire [2:0] pontos;

assign clock_fd = clock && ~pausa_fd;

assign botao_direito_baixo_proj = ~botao_direito_baixo;
assign botao_esquerdo_baixo_proj = ~botao_esquerdo_baixo;
assign botao_direito_cima_proj = ~botao_direito_cima;
assign botao_esquerdo_cima_proj = ~botao_esquerdo_cima; 
assign pausa_proj = ~pausa;

fluxo_dados fd(.clk(clock_fd), .clk_real(clock),.reset(reseta_fd), .botao_direito_baixo(botao_direito_baixo_proj), .botao_esquerdo_baixo(botao_esquerdo_baixo_proj), .botao_direito_cima(botao_direito_cima_proj), .botao_esquerdo_cima(botao_esquerdo_cima_proj), .coluna_bola(coluna_bola), .linha_bola(linha_bola), .ganhou(ganhou), .perdeu(perdeu), .pausa(pausa_proj), .pulso_pausa(pulso_pausa), .pontos(pontos), .posicao_raquete_cima(posicao_cima), .posicao_raquete_baixo(posicao_baixo));

unidade_controle uc(.clk(clock), .reset(reset), .iniciar(iniciar), .perdeu(perdeu), .ganhou(ganhou), .reseta_fd(reseta_fd), .venceu_jogo(venceu_jogo), .perdeu_jogo(perdeu_jogo),.pulso_pausa(pulso_pausa),.pausa_fd(pausa_fd), .db_estado(db_estado));

hexa7seg seg(.hexa(pontos), .display(pontos_7seg));

endmodule