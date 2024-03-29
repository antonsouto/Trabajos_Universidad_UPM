#pragma once
#include "ETSIDI.h"
#include "pieza.h"
#include "rey.h"
#include "reina.h"
#include "caballo.h"
#include "Peon.h"
#include "Alfil.h"
#include "Torre.h"

#include <math.h>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <string>


#define MAX_PIEZAS 100


class ListaPiezas
{
private: 
	//Lista
	pieza* listaPiezas[MAX_PIEZAS];
	int nPiezas = 0;
	int nPosibles=0;
	
	//Variables relacionadas con el enroque
	bool enroqueBlanco = true;
	bool enroqueNegro = true;
	bool torreBlancaIzq = true;
	bool torreBlancaDrc = true;
	bool torreNegraIzq = true;
	bool torreNegraDrc = true;

	//Variables relacionadas con el jaque
	int PosiblesJaque = 0;
	bool jaqueBlanco=false;
	bool jaqueNegro=false;
	bool jaqueMateBlanco = false;
	bool jaqueMateNegro = false;

	//Color de la IA
	color colorIA =	NEGRO;

public:
	//Variables para pintar las coordenadas
	coordenada movimientosPosibles[64];
	coordenada coordenadaPintar[64];
	coordenada coordenadaComer[8];
	bool si = false;

	//Turno
	color proximoTurno = BLANCO;

	tipo_pieza tipo_promocion;
	tipo_pieza modo_loco;
	bool promocionar;

	pieza* apuntar;

	//Constructores
	ListaPiezas();
	~ListaPiezas();

	//Agregar y eliminar piezas
	void crearPiezasAleatoriamente();
	void crearMismoTipo(tipo_pieza tipo);
	void crearAjedrez960();
	bool agregarPieza(pieza* pieza);
	void eliminar(int index);
	void eliminar(pieza* pieza);
	void borrarContenido();

	void guardarPartida();
	void guardarHistorial();
	void cargarPartida(string nombreFichero);

	void dibuja();

	//Getters
	bool getJaqueMateBlanco() { return jaqueMateBlanco; }
	bool getJaqueMateNegro() { return jaqueMateNegro; }

	//Funciones del enroque
	void enroque(pieza* pieza, int fila, int columna);				//Realiza el enroque, moviendo la torre correspondiente
	void anularEnroque(pieza* pieza, int fila, int columna);		//Si se mueve alguna de las piezas del enroque, impide que se realice

	//Movimiento de las piezas
	void moverPieza(pieza* pieza, int fila, int columna);			//Hace las comprobaciones necesarias para mover la pieza
	bool movimientoLegal(pieza* pieza, int fila, int columna);		//Devuelve true si es un movimiento legal
	bool movimientoLegalJaque(pieza* pieza, int fila, int columna); //Igual que movimientoLegal pero sin la comprobacion del jaquePosible
	bool comprobarTurno(pieza* pieza);								//Devuelve el color del proximo movimiento
	bool comprobarColor(int index, coordenada coord);				//Comprueba el color de la pieza que le pasas con el de la posible pieza de esa posicion
	void movPosibles(pieza* aux);									//Funcion para imprimir los movimientos posibles de las piezas al clickarlas

	//Funciones para la colision de piezas
	bool comprobarAlfil(pieza* pieza, int fila, int columna);
	bool comprobarTorre(pieza* pieza, int fila, int columna);
	bool comprobarReina(pieza* pieza, int fila, int columna);
	bool comprobarPeon(pieza* pieza, int fila, int columna);
	bool comprobarRey(pieza* pieza, int fila, int columna);

	bool comerPieza(pieza* pieza, int fila, int columna);	//Devuelve true si se puede comer una pieza

	//Funciones para el jaque
	void jaque(color Color);								//Comprueba que haya jaque al color que se pasa
	bool jaqueBool(color Color);							//Lo mismo que jaque(color color) pero devuelve true si hay jaque en vez de modificar el atributo de la clase
	bool jaquePosible(pieza* pieza,int fila, int columna);	//Comprueba que un movimiento no provoque jaque, para impedir movimientos
	bool jaqueMate(color color);							//Comprueba si hay jaque mate


	//Busqueda de piezas o de casillas
	pieza* buscarPieza(int fila, int columna);
	bool mirarCasilla(int fila, int columna);
	bool comprobarPieza(pieza* aux, int fila, int columna);

	void Promocion(pieza* pieza);
	void comprobarPromocion(pieza* pieza);

	//IA
	void setColorIA(color colorIA);
	void algoritmoIA();
	void algoritmoIAv2(int iteraciones, int profundidad=1);
	int evaluacion(int fila, int columna);
	int evaluacionCompleta();

	//Funciones para la IA que no funcionan
	int maxi(pieza* pieza1,color color, int profundidad, int fila, int columna);
	int mini(pieza* pieza1,color color, int profundidad, int fila, int columna);

};

