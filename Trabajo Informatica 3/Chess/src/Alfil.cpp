#include "Alfil.h"

Alfil::Alfil()
{
	tipo = ALFIL;
	valor = 30;
}

Alfil::Alfil(color color, coordenada coord) : pieza(color, coord)
{
	tipo = ALFIL;
	valor = 30;
}

void Alfil::dibuja()
{
	//Modificamos el color del fondo segun su casilla en el metodo pieza::dibuja()
	pieza::dibuja();

	//Se crea un vector2D con las coordenadas de la pieza
	coordenada coordPieza = getCoordenada();
	vector2D vector = coordPieza.toVector();

	//Se añade un offset para centrar las piezas
	float x = vector.x + 1.0f;
	float y = vector.y;


	//Cargamos la textura
	if (getColor() == BLANCO) {
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/alfilBlanco.png").id);
	}
	else {
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/alfilNegro.png").id);
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

bool Alfil::movimientoLegal(coordenada destino)
{
	coordenada coordInicio = getCoordenada();

	//Comprobacion de que el movimiento es en diagonal
	if (((destino.getColumna() - coordInicio.getColumna()) == 0) && ((destino.getFila() - coordInicio.getFila()) == 0)) { return false; }
	else if (abs(destino.getColumna() - getCoordenada().getColumna()) == abs(destino.getFila() - getCoordenada().getFila())) {
		return true;
	}
	else return false;
}

int Alfil::getValorPos(int fila, int columna)
{
	if (getColor() == BLANCO) {
		return puntPosBlancas[fila-1][columna-1];
	}
	else {
		return puntPosNegras[fila-1][columna-1];
	}
}

void Alfil::guardarHistorial()
{
	ofstream archivo;
	
	archivo.open("Historial.txt", ios::app);
	if (archivo.fail()) {//comprobar si el archivo se ha abierto correctamente
		cout << "no se pudo abrir el archivo";
		exit(1);
	}
	archivo << "B" << getCoordenada().getLetra() <<getFila() << " ";
	archivo.close();
}

