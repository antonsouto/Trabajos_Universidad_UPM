#include "Coordinador.h"
#include "ETSIDI.h"
#include "freeglut.h"
#include <iostream>
#include <stdlib.h>

Coordinador::Coordinador()
{
	estado = INICIO;
	musica();
}
Coordinador::~Coordinador()
{

}
void Coordinador::dibuja()
{
	if (estado == INICIO) 
	{
		gluLookAt(31.9f, 100.0f, 32.0f, // posicion del ojo
			32.0, 0.0, 32.0, // hacia que punto mira (32.0,0.0,32.0)
			0.0, 1.0, 0.0); // definimos hacia arriba (eje Y)

		glEnable(GL_TEXTURE_2D);
		//glColor3f(1, 1, 1);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/fondoInicio.png").id);
		glDisable(GL_LIGHTING);
		glBegin(GL_POLYGON);
		glTexCoord2d(0, 1); glVertex3f(-5.0f, -1.0f, -17.0f);
		glTexCoord2d(1, 1); glVertex3f(-5.0f, -1.0f, 82.0f);
		glTexCoord2d(1, 0); glVertex3f(75.0f, -1.0f, 82.0f);
		glTexCoord2d(0, 0); glVertex3f(75.0f, -1.0f, -17.0f);
		glEnd();
		glEnable(GL_LIGHTING);
		glDisable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, 0);

	}
	else if (estado == JUEGO)
	{
		partida.dibuja();

		if (partida.getJaqueMateBlanco() == true) {
			estado = JAQUEMATE_BLANCO;
		}
		if (partida.getJaqueMateNegro() == true) {
			estado = JAQUEMATE_NEGRO;
		}
		if (partida.piezas.promocionar) {
			estado = PROMOCIONAR;
		}
	}
	else if (estado == MODOS)
	{
		gluLookAt(31.9f, 100.0f, 32.0f, // posicion del ojo
			32.0, 0.0, 32.0, // hacia que punto mira (0,7.5,0)
			0.0, 1.0, 0.0); // definimos hacia arriba (eje Y)

		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/Modos.png").id);
		glDisable(GL_LIGHTING);
		glBegin(GL_POLYGON);
		glTexCoord2d(0, 1); glVertex3f(-5.0f, -1.0f, -17.0f);
		glTexCoord2d(1, 1); glVertex3f(-5.0f, -1.0f, 82.0f);
		glTexCoord2d(1, 0); glVertex3f(80.0f, -1.0f, 82.0f);
		glTexCoord2d(0, 0); glVertex3f(80.0f, -1.0f, -17.0f);
		glEnd();
		glEnable(GL_LIGHTING);
		glDisable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, 0);
	}
	else if (estado == ELECCION_IA)
	{
		gluLookAt(31.9f, 100.0f, 32.0f, // posicion del ojo
			32.0, 0.0, 32.0, // hacia que punto mira (0,7.5,0)
			0.0, 1.0, 0.0); // definimos hacia arriba (eje Y)

		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/eleccionIA.png").id);
		glDisable(GL_LIGHTING);
		glBegin(GL_POLYGON);
		glTexCoord2d(0, 1); glVertex3f(-5.0f, -1.0f, -17.0f);
		glTexCoord2d(1, 1); glVertex3f(-5.0f, -1.0f, 82.0f);
		glTexCoord2d(1, 0); glVertex3f(80.0f, -1.0f, 82.0f);
		glTexCoord2d(0, 0); glVertex3f(80.0f, -1.0f, -17.0f);
		glEnd();
		glEnable(GL_LIGHTING);
		glDisable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, 0);
	}

	else if (estado == JAQUEMATE_BLANCO)
		{
		gluLookAt(31.9f, 100.0f, 32.0f, // posicion del ojo
			32.0, 0.0, 32.0, // hacia que punto mira (0,7.5,0)
			0.0, 1.0, 0.0); // definimos hacia arriba (eje Y)
		glColor3f(255, 255, 255);

		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/jaqueMateBlanco.png").id);
		glDisable(GL_LIGHTING);
		glBegin(GL_POLYGON);
		glTexCoord2d(0, 1); glVertex3f(-5.0f, 3.0f, -17.0f);
		glTexCoord2d(1, 1); glVertex3f(-5.0f, 3.0f, 82.0f);
		glTexCoord2d(1, 0); glVertex3f(70.0f, 3.0f, 82.0f);
		glTexCoord2d(0, 0); glVertex3f(70.0f, 3.0f, -17.0f);
		glEnd();
		glEnable(GL_LIGHTING);
		glDisable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, 0);
		
	}
	else if (estado == JAQUEMATE_NEGRO)
	{
		gluLookAt(31.9f, 100.0f, 32.0f, // posicion del ojo
			32.0, 0.0, 32.0, // hacia que punto mira (0,7.5,0)
			0.0, 1.0, 0.0); // definimos hacia arriba (eje Y)
		glColor3f(255, 255, 255);

		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/jaqueMateNegro.png").id);
		glDisable(GL_LIGHTING);
		glBegin(GL_POLYGON);
		glTexCoord2d(0, 1); glVertex3f(-10.0f, 3.0f, -17.0f);
		glTexCoord2d(1, 1); glVertex3f(-10.0f, 3.0f, 82.0f);
		glTexCoord2d(1, 0); glVertex3f(70.0f, 3.0f, 82.0f);
		glTexCoord2d(0, 0); glVertex3f(70.0f, 3.0f, -17.0f);
		glEnd();
		glEnable(GL_LIGHTING);
		glDisable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, 0);

	}
	else if (estado == PAUSA) 
	{
		gluLookAt(31.9f, 100.0f, 32.0f, // posicion del ojo
			32.0, 0.0, 32.0, // hacia que punto mira (0,7.5,0)
			0.0, 1.0, 0.0); // definimos hacia arriba (eje Y)
		glColor3f(255, 255, 255);

		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/pausa.png").id);
		glDisable(GL_LIGHTING);
		glBegin(GL_POLYGON);
		glTexCoord2d(0, 1); glVertex3f(-10.0f, 3.0f, -17.0f);
		glTexCoord2d(1, 1); glVertex3f(-10.0f, 3.0f, 82.0f);
		glTexCoord2d(1, 0); glVertex3f(70.0f, 3.0f, 82.0f);
		glTexCoord2d(0, 0); glVertex3f(70.0f, 3.0f, -17.0f);
		glEnd();
		glEnable(GL_LIGHTING);
		glDisable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, 0);

	}
	else if (estado == PROMOCIONAR) {

	gluLookAt(31.9f, 100.0f, 32.0f, // posicion del ojo
		32.0, 0.0, 32.0, // hacia que punto mira (0,7.5,0)
		0.0, 1.0, 0.0); // definimos hacia arriba (eje Y)
	glColor3f(255, 255, 255);

	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/promocion.png").id);
	glDisable(GL_LIGHTING);
	glBegin(GL_POLYGON);
	glTexCoord2d(0, 1); glVertex3f(-10.0f, 3.0f, -17.0f);
	glTexCoord2d(1, 1); glVertex3f(-10.0f, 3.0f, 82.0f);
	glTexCoord2d(1, 0); glVertex3f(70.0f, 3.0f, 82.0f);
	glTexCoord2d(0, 0); glVertex3f(70.0f, 3.0f, -17.0f);
	glEnd();
	glEnable(GL_LIGHTING);
	glDisable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, 0);

	}
	else if (estado == MODOS_LOCO) {

	gluLookAt(31.9f, 100.0f, 32.0f, // posicion del ojo
		32.0, 0.0, 32.0, // hacia que punto mira (0,7.5,0)
		0.0, 1.0, 0.0); // definimos hacia arriba (eje Y)
	glColor3f(255, 255, 255);

	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/loco.png").id);
	glDisable(GL_LIGHTING);
	glBegin(GL_POLYGON);
	glTexCoord2d(0, 1); glVertex3f(0.0f, 3.0f, -17.0f);
	glTexCoord2d(1, 1); glVertex3f(0.0f, 3.0f, 82.0f);
	glTexCoord2d(1, 0); glVertex3f(70.0f, 3.0f, 82.0f);
	glTexCoord2d(0, 0); glVertex3f(70.0f, 3.0f, -17.0f);
	glEnd();
	glEnable(GL_LIGHTING);
	glDisable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, 0);

	}
}

void Coordinador::mouse(int button, int state, int x, int y)
{
	if (estado != PAUSA) {
		partida.mouse(button, state, x, y);
	}
}

void Coordinador::mueve() //funcion a modificar para el jaque mate
{
	if (estado == JUEGO)
	{
		partida.mover();
	}
}

void Coordinador::Tecla(unsigned char key) {

	if (key == 'm' || key == 'M') {
		musica();
	}

	else if (estado == INICIO) {

		if (key == 'e' ||  key== 'E') {
			estado = MODOS;
		}
		if (key == 's' ||  key== 'S' )exit(0);
	}

	else if (estado == MODOS) {
		if (key == '1') {
			estado = JUEGO;
			partida.inicializa();
		}
		if (key == '2') {
			estado = ELECCION_IA;
		}
		if (key == '3') {
			estado = MODOS_LOCO;
		}
		if (key == 's' ||  key== 'S' )exit(0);
		if (key == 'c' || key == 'C') {
			cout << "Introduzca el nombre del fichero con la extension .txt:";
			string nombre;
			cin >> nombre;
			partida.setFichero(nombre);
		}

	}

	else if (estado == ELECCION_IA) {
		if (key == 'B'||key=='b') {
			estado = JUEGO;
			partida.setIA(true, BLANCO);
			partida.inicializa();
		}
		if (key == 'N'||key=='n') {
			estado = JUEGO;
			partida.setIA(true, NEGRO);
			partida.inicializa();
		}
	}

	else if (estado == JUEGO) {
		if (key == 's' || key == 'S')exit(0);

		if (key == 'p' || key == 'P') {
			estado = PAUSA;
		}
	}

	else if (estado == PAUSA) {
		if (key == 'p' || key == 'P') {
			estado = JUEGO;
		}
		if (key == 'r' || key == 'R') {
			partida.setFichero("ESTANDAR.txt");
			partida.inicializa();
			estado = JUEGO;
		}
		if (key == 'g' || key == 'G') {
			partida.guardarPartida();
		}
		if (key == 't' || key == 'T') {
			partida.setIA(false, BLANCO);
			estado = INICIO;
		}
		if (key == 's' || key == 'S') {
			exit(0);
		}
	}

	else if ((estado == JAQUEMATE_BLANCO)|| (estado == JAQUEMATE_NEGRO)) {
		if (key == 't' || key == 'T') {
			partida.setFichero("ESTANDAR.txt");
			partida.setIA(false, BLANCO);
			estado = INICIO;
		}
		if (key == 'r' || key == 'R') {
			partida.setFichero("ESTANDAR.txt");
			partida.inicializa();
			estado = JUEGO;
		}
		if (key == 's' || key == 'S') exit(0);
		if (key == 'g' || key == 'G') {
			partida.guardarHistorial();
		}
	}

	else if ((estado == PROMOCIONAR)) {

		if (key == 'r' || key == 'R') {

			partida.promocionar(REINA);
			estado = JUEGO;

		}
		else if (key == 'c' || key == 'C') {

			partida.promocionar(CABALLO);
			estado = JUEGO;

		}
		else if (key == 'a' || key == 'A') {

			partida.promocionar(ALFIL);
			estado = JUEGO;
		}
		else if (key == 't' || key == 'T') {

			partida.promocionar(TORRE);
			estado = JUEGO;

		}
	}
	else if (estado == MODOS_LOCO) {
		if (key == '1') {
			estado = JUEGO;
			partida.inicializaAjedrez960();
		}
		else if (key == '2') {
			estado = JUEGO;
			partida.inicializaAleatoriamente();
		}
		else if (key == '3') {
			estado = JUEGO;
			partida.inicializaTipo(REINA);
		}
		else if (key == '4') {
			estado = JUEGO;
			partida.inicializaTipo(ALFIL);
		}
		else if (key == '5') {
			estado = JUEGO;
			partida.inicializaTipo(TORRE);
		}
		else if (key == '6') {
			estado = JUEGO;
			partida.inicializaTipo(PEON);
		}
		else if (key == '7') {
			estado = JUEGO;
			partida.inicializaTipo(CABALLO);
		}
		else if (key == 't' || key == 'T') {
			estado = MODOS;
		}
	}
}

void Coordinador::musica() {
	if (modoMusica==true){
		modoMusica = false;
		ETSIDI::stopMusica();
	}
	else if (modoMusica == false) {
		modoMusica = true;
		ETSIDI::playMusica("sonidos/ambiente.mp3", true);
	}
}