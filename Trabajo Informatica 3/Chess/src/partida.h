#pragma once
#include "ListaPiezas.h"
#include "tablero.h"
#include "coordenada.h"
#include "stdlib.h"


using namespace std;

class partida
{
	//Atributos IA
	bool existeIA = false;
	bool calculando = false;
	color colorIA = NEGRO;

	string nombreFichero = "ESTANDAR.txt";

public:
	tablero tablero;
	ListaPiezas piezas;

	//Camara
	float x_ojo;
	float y_ojo;
	float z_ojo;

	void inicializa();
	void inicializaAleatoriamente();
	void inicializaAjedrez960();
	void inicializaTipo(tipo_pieza tipo);
	void mover();
	void dibuja();
	
	void guardarPartida();
	void guardarHistorial();
	void promocionar(tipo_pieza tipo);

	//Mouse
	void mouse(int button, int state, int x, int y);
	void getColFilMouse(int x, int y, int &fila, int &columna);

	//Getters
	bool getJaqueMateBlanco() { return piezas.getJaqueMateBlanco(); }
	bool getJaqueMateNegro() { return piezas.getJaqueMateNegro(); }

	//Setters
	void setIA(bool IA, color colorIA);
	void setFichero(string fichero) { nombreFichero = fichero; }
};

