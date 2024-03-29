#pragma once

#include<iostream>

enum{};
using namespace std;
class vector2D;
enum color{NEGRO, BLANCO, NONE};

class coordenada
{
	string letra;
	int numero;
public:

	//Constructores
	coordenada();
	coordenada(string letra, int numero);
	coordenada(int fila, int columna);

	//Getters
	int getFila();
	int getColumna();
	vector2D toVector();
	string getLetra() { return letra; }
	color getColorCasilla();

	//Setters
	void setCol(int columna);
	void setFil(int fila);
 
	//Convertidores y operadores
	string toLetraCol(int numero);
	bool operator==(coordenada coord);
	coordenada operator-(coordenada coord);

};

