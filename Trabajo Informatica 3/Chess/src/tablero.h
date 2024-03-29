#pragma once
#include "ETSIDI.h"
#include "coordenada.h"

class tablero
{
public:
	void dibuja();
	void PintarMovPosibles(coordenada coord[], coordenada coord2[]);
};

