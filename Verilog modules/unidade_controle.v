module unidade_controle(
    input clk,
    input reset,
    input iniciar,
    input perdeu,
    input ganhou,
    input pulso_pausa,
    output reg reseta_fd,
    output reg venceu_jogo,
    output reg perdeu_jogo,
    output reg pausa_fd,
    output [2:0] db_estado
);

    parameter inicio = 3'b000;
    parameter comeca_jogo = 3'b001;
    parameter jogando = 3'b010;
    parameter derrota = 3'b011;
    parameter vitoria = 3'b100;
    parameter pausado = 3'b101;

reg [2:0] Eatual;
reg [2:0] Eprox;


always @(posedge clk or posedge reset) begin
    if(reset) 
        Eatual <= inicio;
    else 
        Eatual <= Eprox;
end
 
always @(*) begin
    case(Eatual) 
    inicio: Eprox = iniciar ? comeca_jogo : inicio;
    comeca_jogo: Eprox = jogando;
    jogando: Eprox = pulso_pausa ? pausado : (perdeu ? derrota : (ganhou ? vitoria : jogando));
    pausado: Eprox = pulso_pausa ? jogando : pausado;
    derrota: Eprox = iniciar ? comeca_jogo : derrota;
    vitoria: Eprox = iniciar ? comeca_jogo : vitoria;
    endcase

    reseta_fd   = (Eatual == inicio || Eatual == comeca_jogo || Eatual == vitoria || Eatual == derrota) ? 1'b1 : 1'b0;
    venceu_jogo = (Eatual == vitoria)     ? 1'b1 : 1'b0;
    perdeu_jogo = (Eatual == derrota)     ? 1'b1 : 1'b0;
    pausa_fd    = (Eatual == pausado)     ? 1'b1 : 1'b0;
end

assign db_estado = Eatual;

endmodule