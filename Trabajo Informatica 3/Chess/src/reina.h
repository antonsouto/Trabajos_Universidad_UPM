#pragma once
#include "pieza.h"
#include <fstream>
#include <string>

class reina : public pieza {
	int puntPosNegras[8][8] = {
	-20,-10,-10, -5, -5,-10,-10,-20,
	-10,  0,  0,  0,  0,  0,  0,-10,
	-10,  0,  5,  5,  5,  5,  0,-10,
	 -5,  0,  5,  5,  5,  5,  0, -5,
	  0,  0,  5,  5,  5,  5,  0, -5,
	-10,  5,  5,  5,  5,  5,  0,-10,
	-10,  0,  5,  0,  0,  0,  0,-10,
	-20,-10,-10, -5, -5,-10,-10,-20
	};
	int puntPosBlancas[8][8] = {
	-20,-10,-10, -5, -5,-10,-10,-20
	- 10,  0,  5,  0,  0,  0,  0,-10,
	-10,  5,  5,  5,  5,  5,  0,-10,
	  0,  0,  5,  5,  5,  5,  0, -5,
	 -5,  0,  5,  5,  5,  5,  0, -5,
	-10,  0,  5,  5,  5,  5,  0,-10,
	-10,  0,  0,  0,  0,  0,  0,-10,
	-20,-10,-10, -5, -5,-10,-10,-20,
	};


public:
	reina(color color, coordenada coord);
	reina();

	void dibuja();
	bool movimientoLegal(coordenada destino);
	int getValorPos(int fila, int columna);
	void guardarHistorial();

};

