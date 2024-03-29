#pragma once
#include "partida.h"
#include "freeglut.h"
#include "ETSIDI.h"

enum Estado { INICIO, MODOS, JUEGO, PAUSA, JAQUEMATE_BLANCO, JAQUEMATE_NEGRO, ELECCION_IA, PROMOCIONAR, MODOS_LOCO };

class Coordinador
{
public:
	//Constructores
	Coordinador();
	virtual ~Coordinador();

	void mouse(int button, int state, int x, int y);
	void Tecla(unsigned char key);

	void mueve();
	void musica();
	void dibuja();
	
protected:
	partida partida;
	Estado estado;

private:
	bool modoMusica=false;

};
