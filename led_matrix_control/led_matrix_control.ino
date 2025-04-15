#include <LedControl.h>

#define DIN 19
#define CLK 18
#define CS 5

#define pin_raquete_cima_0 14
#define pin_raquete_cima_1 12
#define pin_raquete_cima_2 13

#define pin_raquete_baixo_0 25
#define pin_raquete_baixo_1 26 
#define pin_raquete_baixo_2 27

#define pin_linha_bola_0 35
#define pin_linha_bola_1 32 
#define pin_linha_bola_2 33

#define pin_coluna_bola_0 4 //menos significativo
#define pin_coluna_bola_1 2
#define pin_coluna_bola_2 15  //mais significativo

LedControl lc = LedControl(DIN,CLK,CS,0);

int linha_bola;
int coluna_bola;
int coluna_raquete_cima;
int coluna_raquete_baixo;
byte *matrix;

void setup() {
  
lc.shutdown(0,false);       
lc.setIntensity(0,8);       
lc.clearDisplay(0);
pinMode(pin_linha_bola_2, INPUT);
pinMode(pin_linha_bola_1, INPUT);
pinMode(pin_linha_bola_0, INPUT);
pinMode(pin_coluna_bola_2, INPUT);
pinMode(pin_coluna_bola_1, INPUT);
pinMode(pin_coluna_bola_0, INPUT);
pinMode(pin_raquete_cima_2, INPUT);
pinMode(pin_raquete_cima_1, INPUT);
pinMode(pin_raquete_cima_0, INPUT);
pinMode(pin_raquete_baixo_2, INPUT);
pinMode(pin_raquete_baixo_1, INPUT);
pinMode(pin_raquete_baixo_0, INPUT);
pinMode(CLK, OUTPUT);
pinMode(CS, OUTPUT);
pinMode(DIN, OUTPUT);

}

void loop() {
linha_bola = bin_to_dec(pin_linha_bola_2, pin_linha_bola_1, pin_linha_bola_0);
coluna_bola = bin_to_dec(pin_coluna_bola_2, pin_coluna_bola_1, pin_coluna_bola_0);
coluna_raquete_cima = bin_to_dec(pin_raquete_cima_2, pin_raquete_cima_1, pin_raquete_cima_0);
coluna_raquete_baixo = bin_to_dec(pin_raquete_baixo_2, pin_raquete_baixo_1, pin_raquete_baixo_0);

matrix = matriz(linha_bola, coluna_bola, coluna_raquete_baixo, coluna_raquete_cima);

for(int i = 0; i < 8; i++) lc.setRow(0, i, matrix[i]);

}

byte *matriz(int linha_bola, int coluna_bola, int coluna_raquete_baixo, int coluna_raquete_cima){
  static byte matrix[8];
  matrix[0] = decoded_paddle(coluna_raquete_cima);
  matrix[7] = decoded_paddle(coluna_raquete_baixo);
  for(int i = 1; i < 7; i++){
    if(i == 7-linha_bola) matrix[i] = decoded_ball(7-coluna_bola);
    else matrix[i] = B00000000;
  }
  return matrix;
}

byte decoded_ball(int coluna){
  byte retorno;
  switch(coluna){
    case 0: 
          retorno = B10000000;
          break;
    case 1: 
          retorno = B01000000;
          break;
    case 2: 
          retorno = B00100000;
          break;
    case 3: 
          retorno = B00010000;
          break;      
    case 4: 
          retorno = B00001000;
          break;
    case 5: 
          retorno = B00000100;
          break;
    case 6: 
          retorno = B00000010;
          break;
    case 7:
          retorno = B00000001;
          break;
    default:
          retorno = B00000000;
          break;
  }
  return retorno;
}

byte decoded_paddle (int coluna){
  byte retorno;
  switch(coluna){
    case 0: 
          retorno = B11000000;
          break;
    case 1: 
          retorno = B01100000;
          break;
    case 2: 
          retorno = B00110000;
          break;
    case 3: 
          retorno = B00011000;
          break;      
    case 4: 
          retorno = B00001100;
          break;
    case 5: 
          retorno = B00000110;
          break;
    case 6: 
          retorno = B00000011;
          break;
    default:
          retorno = B00000000;
          break;
  }
  return retorno;
}

int bin_to_dec(int pin2, int pin1, int pin0){
  int bin0 = digitalRead(pin0);
  int bin1 = digitalRead(pin1);
  int bin2 = digitalRead(pin2);
  return bin0 + (bin1 << 1) + (bin2 << 2);
}
