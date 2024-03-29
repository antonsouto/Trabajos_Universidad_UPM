#include "Peon.h"

Peon::Peon()
{
	tipo = PEON;
	valor = 10;
}

Peon::Peon(color color, coordenada coord) : pieza(color, coord)
{
	tipo = PEON;
	valor = 10;
}

void Peon::dibuja()
{
	pieza::dibuja();

	//Se crea un vector2D con las coordenadas de la pieza
	coordenada coordPieza = getCoordenada();
	vector2D vector = coordPieza.toVector();

	//Se añade un offset para centrar las piezas
	float x = vector.x + 1.0f;
	float y = vector.y;


	//textura
	if (getColor() == BLANCO) {
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/peonBlanco.png").id);
	}
	else {
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/peonNegro.png").id);
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

bool Peon::movimientoLegal(coordenada destino)
{
	//Comprobamos los movimientos posibles del peon, segun sea blanco o negro. Pusimos que se pueda mover hacia arriba a la izquierda, centro y derecha. Despues este
	//abanico de movimientos se limita para que en diagonal solo pueda capturar en ListaPiezas
	coordenada coordInicio = getCoordenada();
	if (pieza::getColor() == BLANCO) {
		if ((((coordInicio.getFila()) - (destino.getFila())) == (-1)) && ((coordInicio.getColumna()) == (destino.getColumna()))) {

			return true;
		}
		if (((destino.getColumna() - coordInicio.getColumna()) == 1) && ((destino.getFila() - coordInicio.getFila()) == 1)) {
			return true;
		}
		if (((destino.getColumna() - coordInicio.getColumna()) == -1) && ((destino.getFila() - coordInicio.getFila()) == 1)) {
			return true;
		}
	}
	else {
		if ((((coordInicio.getFila()) - (destino.getFila())) == (1)) && ((coordInicio.getColumna()) == (destino.getColumna()))) {

			return true;
		}
		if (((destino.getColumna() - coordInicio.getColumna()) == -1) && ((destino.getFila() - coordInicio.getFila()) == -1)) {
			return true;
		}
		if (((destino.getColumna() - coordInicio.getColumna()) == 1) && ((destino.getFila() - coordInicio.getFila()) == -1)) {
			return true;
		}
	}

	//Movimiento de 2 hacia delante
	if ((coordInicio.getFila()) == (2) || ((coordInicio.getFila()) == (7))) {

		if (pieza::getColor() == BLANCO) {
			if ((((coordInicio.getFila()) - (destino.getFila())) == (-2)) && ((coordInicio.getColumna()) == (destino.getColumna()))) {

				return true;
			}
		}
		else {
			if ((((coordInicio.getFila()) - (destino.getFila())) == (2)) && ((coordInicio.getColumna()) == (destino.getColumna()))) {

				return true;
			}
		}
	}
	return false;
}


int Peon::getValorPos(int fila, int columna)
{
	if (icolor == BLANCO) {
		return puntPosBlancas[fila-1][columna-1];
	}
	else {
		return puntPosNegras[fila-1][columna-1];
	}
}

void Peon::guardarHistorial()
{
	ofstream archivo;

	archivo.open("Historial.txt", ios::app);
	if (archivo.fail()) {//comprobar si el archivo se ha abierto correctamente
		cout << "no se pudo abrir el archivo";
		exit(1);
	}
	archivo << getCoordenada().getLetra() << getFila() << " ";
	archivo.close();
	

}
