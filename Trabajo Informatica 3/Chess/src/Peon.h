#pragma once
#include "pieza.h"
#include <fstream>
#include <string>

using namespace std;
class Peon : public pieza
{
	int puntPosNegras[8][8] = {
	 0,  0,  0,  0,  0,  0,  0,  0,
	50, 50, 50, 50, 50, 50, 50, 50,
	10, 10, 20, 30, 30, 20, 10, 10,
	 5,  5, 10, 25, 25, 10,  5,  5,
	 0,  0,  0, 20, 20,  0,  0,  0,
	 5, -5,-10,  0,  0,-10, -5,  5,
	 5, 10, 10,-20,-20, 10, 10,  5,
	 0,  0,  0,  0,  0,  0,  0,  0
	};
	int puntPosBlancas[8][8] = {
	 0,  0,  0,  0,  0,  0,  0,  0,
	 5, 10, 10,-20,-20, 10, 10,  5,
	 5, -5,-10,  0,  0,-10, -5,  5,
	 0,  0,  0, 20, 20,  0,  0,  0,
	 5,  5, 10, 25, 25, 10,  5,  5,
	10, 10, 20, 30, 30, 20, 10, 10,
	50, 50, 50, 50, 50, 50, 50, 50,
	 0,  0,  0,  0,  0,  0,  0,  0
	};


public:
	//Constructores
	Peon();
	Peon(color color, coordenada coord);

	void dibuja();
	bool movimientoLegal(coordenada destino);
	int getValorPos(int fila, int columna);
	void guardarHistorial();


};

