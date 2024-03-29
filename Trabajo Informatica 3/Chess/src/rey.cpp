#include "rey.h"
#include<iostream>

rey::rey( color color, coordenada coord) : pieza(color,coord)
{
	tipo = REY;
	valor = 60;
}

rey::rey()
{
	tipo = REY;
	valor = 60;
}

void rey::dibuja()
{
	pieza::dibuja();

	//Se crea un vector2D con las coordenadas de la pieza
	coordenada coordPieza = getCoordenada();
	vector2D vector = coordPieza.toVector();

	//Se añade un offset para centrar las piezas
	float x = vector.x+1.0f;
	float y = vector.y;



	//textura
	if (getColor() == BLANCO) {
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/reyBlanco.png").id);
	}
	else {
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/reyNegro.png").id);
	}

	glDisable(GL_LIGHTING);
	glBegin(GL_POLYGON);
	glTexCoord2d(0, 1); glVertex3f(y + 0.2f, 0.2f, x + 0.2f);
	glTexCoord2d(1, 1); glVertex3f(y + 0.2f, 0.2f, x + getAncho() - 0.2f);
	glTexCoord2d(1, 0); glVertex3f(y + getAltura() - 0.2f, 0.2f, x + getAncho() - 0.2f);
	glTexCoord2d(0, 0); glVertex3f(y - 0.2f + getAltura(), 0.2f, x + 0.2f);
	glEnd();
	glEnable(GL_LIGHTING);

	//Liberar memoria de la textura
	glBindTexture(GL_TEXTURE_2D, 0);
}

bool rey::movimientoLegal(coordenada destino)
{
	coordenada coordInicio = getCoordenada();

	//NO movimiento a la misma casilla

	if (((destino.getColumna() - coordInicio.getColumna()) == 0) && ((destino.getFila() - coordInicio.getFila()) == 0)) {
		return false;
	}

	// movimiento esquinas 

	else if ((abs(destino.getColumna() - coordInicio.getColumna()) == 1) && (abs(destino.getFila() - coordInicio.getFila()) == 1)) {
		return true;
	}

	//movimiento columna y lateral
	else if ((abs(destino.getColumna() - coordInicio.getColumna()) == 0) && (abs(destino.getFila() - coordInicio.getFila()) == 1)) {
		return true;
	}
	else if ((abs(destino.getColumna() - coordInicio.getColumna()) == 1) && (abs(destino.getFila() - coordInicio.getFila()) == 0)) {
		return true;
	}


	//Movimientos para el enroque
	if (icolor == BLANCO) {
		if (getCoordenada().getFila() == 1 && getCoordenada().getColumna() == 5) {
			if (destino.getFila() == 1 && destino.getColumna() == 3) return true;
			if (destino.getFila() == 1 && destino.getColumna() == 7) return true;
		}
	}
	else {
		if (getCoordenada().getFila() == 8 && getCoordenada().getColumna() == 5) {
			if (destino.getFila() == 8 && destino.getColumna() == 3) return true;
			if (destino.getFila() == 8 && destino.getColumna() == 7) return true;
		}
	}

	return false;
}

int rey::getValorPos(int fila, int columna)
{
	if (getColor() == BLANCO) {
		return puntPosBlancas[fila-1][columna-1];
	}
	else {
		return puntPosNegras[fila-1][columna-1];
	}
}

void rey::guardarHistorial()
{

	ofstream archivo;
	archivo.open("Historial.txt", ios::app);
	if (archivo.fail()) {//comprobar si el archivo se ha abierto correctamente
		cout << "no se pudo abrir el archivo";
		exit(1);
	}
	archivo << "K" << getCoordenada().getLetra() << getFila() << " ";
	archivo.close();
}
