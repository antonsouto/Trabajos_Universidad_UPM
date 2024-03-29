#include "pieza.h"

pieza::pieza(color color, coordenada coord)
{
	this->icolor = color;
	this->coord = coord;
}

pieza::pieza()
{
	coordenada icoord;
	coord = icoord;
	icolor = BLANCO;
}

pieza::~pieza()
{
}

color pieza::getColor()
{
	return icolor;
}

coordenada pieza::getCoordenada()
{
	return coord;
}

void pieza::setColumna(int columna)
{
	coord.setCol(columna);
}

void pieza::setFila(int fila)
{
	coord.setFil(fila);
}

int pieza::getColumna()
{
	return coord.getColumna();
}

int pieza::getFila()
{
	return coord.getFila();
}

void pieza::dibuja(){

	if (coord.getColorCasilla() == NEGRO) {
		unsigned int r = 129;
		unsigned int g = 96;
		unsigned int b = 79;
		glColor3ub(r, g, b);
	}
	else {
		unsigned int r = 195;
		unsigned int  g = 159;
		unsigned int b = 129;
		glColor3ub(r, g, b);
	}

}
