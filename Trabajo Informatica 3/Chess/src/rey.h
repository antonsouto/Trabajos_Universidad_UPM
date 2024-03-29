#pragma once
#include "pieza.h"
#include <fstream>
#include <string>

class rey : public pieza
{
	bool enroque = true;

	int puntPosNegras[8][8] = {
	-30,-40,-40,-50,-50,-40,-40,-30,
	-30,-40,-40,-50,-50,-40,-40,-30,
	-30,-40,-40,-50,-50,-40,-40,-30,
	-30,-40,-40,-50,-50,-40,-40,-30,
	-20,-30,-30,-40,-40,-30,-30,-20,
	-10,-20,-20,-20,-20,-20,-20,-10,
	 20, 20,  0,  0,  0,  0, 20, 20,
	 20, 30, 10,  0,  0, 10, 30, 20
	};
	int puntPosBlancas[8][8] = {
	20, 30, 10,  0,  0, 10, 30, 20,
	20, 20,  0,  0,  0,  0, 20, 20,
	-10,-20,-20,-20,-20,-20,-20,-10,
	-20,-30,-30,-40,-40,-30,-30,-20,
	-30,-40,-40,-50,-50,-40,-40,-30,
	-30,-40,-40,-50,-50,-40,-40,-30,
	-30,-40,-40,-50,-50,-40,-40,-30,
	-30,-40,-40,-50,-50,-40,-40,-30,
	};

public:
	rey(color color, coordenada coord);
	rey();

	void dibuja();
	bool movimientoLegal(coordenada destino);
	int getValorPos(int fila, int columna);
	void guardarHistorial();
	void pararEnroque() {
		enroque = false;
	}






};

