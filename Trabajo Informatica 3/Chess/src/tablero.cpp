#include "tablero.h"
#include "freeglut.h"


void tablero::dibuja()
{
	float A = 0.0f, B = 0.0f;
	unsigned int r, g, b;
	for (int i = 1; i < 9; i++) {
		for (int j = 1; j < 9; j++) {

			 if (((i % 2 != 0) && (j % 2 != 0)) || ((i % 2 == 0) && (j % 2 == 0))) {

				r = 129;
				g = 96;
				b = 79;
			}
			else {

				r = 195;
				g = 159;
				b = 129;
			}
			
			glDisable(GL_LIGHTING);
			glColor3ub(r, g, b);
			glBegin(GL_POLYGON);
			glTexCoord2d(0, 1); glVertex3f(B, 0.0f, A);
			glTexCoord2d(1, 1); glVertex3f(B, 0.0f, A+8.0f);
			glTexCoord2d(1, 0); glVertex3f(B + 8.0f, 0.0f, A + 8.0f);
			glTexCoord2d(0, 0); glVertex3f(B + 8.0f, 0.0f,A);
			glEnd();
			glEnable(GL_LIGHTING);
			
			//Liberar memoria de la textura
			glBindTexture(GL_TEXTURE_2D, 0);
			A = A + 8.0f;

		}
		A = 0.0f;
		B = B + 8.0f;
	}
}

void tablero::PintarMovPosibles(coordenada coord[], coordenada coord2[])
{
	int fil = 0;
	int col = 0;
	int a = 1;
	int b1 = 1;
	unsigned int r, g, b;

		for (int i = 1; i < 64; i++) {
			fil = coord[a].getFila()-1;
			col = (coord[a].getColumna()-1);
			a++;
			
			if ((fil == -1) || (col == -1)) {

				i=64;
				break;

			}
			//Diferenciamos el color de la casilla para cambiarle el color
			if (((col % 2 != 0) && (fil % 2 != 0)) || ((col % 2 == 0) && (fil % 2 == 0))) {

				r = 120;
				g = 120;
				b = 120;
			}
			else {

				r = 180;
				g = 180;
				b = 180;
			}
			glDisable(GL_LIGHTING);
			glColor3ub(r, g, b);
			glBegin(GL_POLYGON);
			glTexCoord2d(0, 1); glVertex3f(fil * 8, 0.1f, col * 8.0f);
			glTexCoord2d(1, 1); glVertex3f(fil * 8, 0.1f, (col * 8) + 8.0f);
			glTexCoord2d(1, 0); glVertex3f((fil * 8) + 8.0f, 0.1f, (col * 8) + 8.0f);
			glTexCoord2d(0, 0); glVertex3f((fil * 8) + 8.0f, 0.1f, col * 8);
			glEnd();
			glEnable(GL_LIGHTING);
		}

		for (int j = 1; j < 15; j++) {
			fil = coord2[b1].getFila() - 1;
			col = (coord2[b1].getColumna() - 1);
			b1++;

			if ((fil == -1) || (col == -1)) {
				j = 15;
				break;
			}
			glDisable(GL_LIGHTING);
			glColor3ub(100, 0, 0);
			glBegin(GL_POLYGON);
			glTexCoord2d(0, 1); glVertex3f(fil * 8, 0.1f, col * 8.0f);
			glTexCoord2d(1, 1); glVertex3f(fil * 8, 0.1f, (col * 8) + 8.0f);
			glTexCoord2d(1, 0); glVertex3f((fil * 8) + 8.0f, 0.1f, (col * 8) + 8.0f);
			glTexCoord2d(0, 0); glVertex3f((fil * 8) + 8.0f, 0.1f, col * 8);
			glEnd();
			glEnable(GL_LIGHTING);
		}
		
}
