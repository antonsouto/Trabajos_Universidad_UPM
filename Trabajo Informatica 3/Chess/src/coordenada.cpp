#pragma once

#include "coordenada.h"
#include "vector2D.h"

coordenada::coordenada()
{
	letra = "a";
	numero = 1;
}

coordenada::coordenada(string letra, int numero)
{
	this->letra = letra;
	this->numero = numero;
}

coordenada::coordenada(int fila, int columna)
{
	setFil(fila);
	setCol(columna);
}

vector2D coordenada::toVector()
{
	float x=0, y=0;

	if (letra == "a") x = 0.0f;
	else if (letra == "b") x = 8.0f;
	else if (letra == "c") x = 16.0f;
	else if (letra == "d") x = 24.0f;
	else if (letra == "e") x = 32.0f;
	else if (letra == "f") x = 40.0f;
	else if (letra == "g") x = 48.0f;
	else if (letra == "h") x = 56.0f;
	else if (letra == "z") x = -100.0f;

	for (int i = 1; i < 9; i++) {
		if (numero == i) {
			y = i * 8.0f - 8.0f;
		}
	}
	vector2D vector(x, y);
	return vector;
}

string coordenada::toLetraCol(int numero)
{
	string letra2;
	switch (numero) {
	case 1:
		letra2 = 'a';
		break;
	case 2:
		letra2 = 'b';
		break;
	case 3:
		letra2 = 'c';
		break;
	case 4:
		letra2 = 'd';
		break;
	case 5:
		letra2 = 'e';
		break;
	case 6:
		letra2 = 'f';
		break;
	case 7:
		letra2 = 'g';
		break;
	case 8:
		letra2 = 'h';
		break;
	default:
		letra2 = 'a';
		break;
	}
	return letra2;
}

int coordenada::getFila()
{
	
	return numero;
}

int coordenada::getColumna()
{

	int columna = 0;

	if (letra == "a") columna = 1;
	else if (letra == "b") columna = 2;
	else if (letra == "c") columna = 3;
	else if (letra == "d") columna = 4;
	else if (letra == "e") columna = 5;
	else if (letra == "f") columna = 6;
	else if (letra == "g") columna = 7;
	else if (letra == "h") columna = 8;
	else if (letra == "z") columna = 100;

	return columna;
}

void coordenada::setCol(int columna)
{
	
	this->letra = toLetraCol(columna);
}

void coordenada::setFil(int fila)
{

	this->numero = fila ;
}

color coordenada::getColorCasilla()
{
	int columna = getColumna();
	int fila = getFila();

	//Casillas negras
	if (((fila % 2 != 0) && (columna % 2 != 0)) || ((fila % 2 == 0) && (columna % 2 == 0))) {
		return NEGRO;
	}
	else {
		return BLANCO;
	}
}

bool coordenada::operator==(coordenada coord)
{
	if ((getFila() == coord.getFila())&&(getColumna() == coord.getColumna())) {
		return true;
	}
	return false;
}

coordenada coordenada::operator-(coordenada coord)
{
	coordenada aux;
	aux.setFil(getFila() - (coord.getFila()));
	aux.setCol(getColumna() - (coord.getColumna()));
	return aux;
}


