#pragma once
#include "pieza.h"
#include <math.h>
#include <fstream>
#include <string>

class caballo : public pieza {

	int puntPosNegras[8][8] = {
	-50,-40,-30,-30,-30,-30,-40,-50,
	-40,-20,  0,  0,  0,  0,-20,-40,
	-30,  0, 10, 15, 15, 10,  0,-30,
	-30,  5, 15, 20, 20, 15,  5,-30,
	-30,  0, 15, 20, 20, 15,  0,-30,
	-30,  5, 10, 15, 15, 10,  5,-30,
	-40,-20,  0,  5,  5,  0,-20,-40,
	-50,-40,-30,-30,-30,-30,-40,-50,
	};
	int puntPosBlancas[8][8] = {
	-50,-40,-30,-30,-30,-30,-40,-50,
	-40,-20,  0,  5,  5,  0,-20,-40,
	-30,  5, 10, 15, 15, 10,  5,-30,
	-30,  0, 15, 20, 20, 15,  0,-30,
	-30,  5, 15, 20, 20, 15,  5,-30,
	-30,  0, 10, 15, 15, 10,  0,-30,
	-40,-20,  0,  0,  0,  0,-20,-40,
	-50,-40,-30,-30,-30,-30,-40,-50,
	};

public:
	//Constructores
	caballo();
	caballo(color color, coordenada coord);

	void dibuja();
	bool movimientoLegal(coordenada destino);
	int getValorPos(int fila, int columna);
	void guardarHistorial();


};

