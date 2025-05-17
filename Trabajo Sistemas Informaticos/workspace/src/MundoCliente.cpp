//Autor: Miguel Peñalver Saldaña
// Mundo.cpp: implementation of the CMundo class.
//
//////////////////////////////////////////////////////////////////////
#include <fstream>
#include "MundoCliente.h"
#include "glut.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CMundo::CMundo()
{
	Init();
}

CMundo::~CMundo()
{
	munmap(direccion, sizeof(datos));
}

void CMundo::InitGL()
{
	//Habilitamos las luces, la renderizacion y el color de los materiales
	glEnable(GL_LIGHT0);
	glEnable(GL_LIGHTING);
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_COLOR_MATERIAL);
	
	glMatrixMode(GL_PROJECTION);
	gluPerspective( 40.0, 800/600.0f, 0.1, 150);
}

void print(char *mensaje, int x, int y, float r, float g, float b)
{
	glDisable (GL_LIGHTING);

	glMatrixMode(GL_TEXTURE);
	glPushMatrix();
	glLoadIdentity();

	glMatrixMode(GL_PROJECTION);
	glPushMatrix();
	glLoadIdentity();
	gluOrtho2D(0, glutGet(GLUT_WINDOW_WIDTH), 0, glutGet(GLUT_WINDOW_HEIGHT) );

	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glLoadIdentity();

	glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	glDisable(GL_DEPTH_TEST);
	glDisable(GL_BLEND);
	glColor3f(r,g,b);
	glRasterPos3f(x, glutGet(GLUT_WINDOW_HEIGHT)-18-y, 0);
	int len = strlen (mensaje );
	for (int i = 0; i < len; i++) 
		glutBitmapCharacter (GLUT_BITMAP_HELVETICA_18, mensaje[i] );
		
	glMatrixMode(GL_TEXTURE);
	glPopMatrix();

	glMatrixMode(GL_PROJECTION);
	glPopMatrix();

	glMatrixMode(GL_MODELVIEW);
	glPopMatrix();

	glEnable( GL_DEPTH_TEST );
}
void CMundo::OnDraw()
{
	//Borrado de la pantalla	
   	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	//Para definir el punto de vista
	glMatrixMode(GL_MODELVIEW);	
	glLoadIdentity();
	
	gluLookAt(0.0, 0, 17,  // posicion del ojo
		0.0, 0.0, 0.0,      // hacia que punto mira  (0,0,0) 
		0.0, 1.0, 0.0);      // definimos hacia arriba (eje Y)    

	/////////////////
	///////////
	//		AQUI EMPIEZA MI DIBUJO
	char cad[100];
	sprintf(cad,"Jugador1: %d",puntos1);
	print(cad,10,0,1,1,1);
	sprintf(cad,"Jugador2: %d",puntos2);
	print(cad,650,0,1,1,1);
	int i;
	for(i=0;i<paredes.size();i++)
		paredes[i].Dibuja();

	fondo_izq.Dibuja();
	fondo_dcho.Dibuja();
	jugador1.Dibuja();
	jugador2.Dibuja();
	esfera.Dibuja();

	/////////////////
	///////////
	//		AQUI TERMINA MI DIBUJO
	////////////////////////////

	//Al final, cambiar el buffer
	glutSwapBuffers();
}

void CMundo::OnTimer(int value)
{			
	direccion->esfera=esfera;
	direccion->raqueta1=jugador1;
	direccion->raqueta2=jugador2;
	
	direccion->tiempo=direccion->tiempo+0.025f;
	
	switch (direccion->accion)
	{
	case 1:
		OnKeyboardDown('w',1,1);
		break;
		
	case 0: 
		//jugador1.velocidad.y=0;
		break;
		
	case -1:
		OnKeyboardDown('s',1,1);
		break;
	}
	
	switch (direccion->accion2)
	{
	case 1:
		jugador2.velocidad.y=4;
		break;
		
	case 0: 
		//jugador2.velocidad.y=0;
		break;
		
	case -1:
		jugador2.velocidad.y=-4;
		break;
	}
	
	char cad[200];
	comunicacion.Receive(cad,sizeof(cad));
	sscanf(cad,"%f %f %f %f %f %f %f %f %f %f %f %d %d",&esfera.centro.x,&esfera.centro.y,&esfera.radio,&jugador1.x1,&jugador1.y1,&jugador1.x2,&jugador1.y2,&jugador2.x1,&jugador2.y1,&jugador2.x2,&jugador2.y2,&puntos1, &puntos2);
}
	


void CMundo::OnKeyboardDown(unsigned char key, int x, int y)
{
	printf("Tecla pulsada: %c\n", key);
	char tecla[5]="0";
	switch(key)
	{
//	case 'a':jugador1.velocidad.x=-1;break;
//	case 'd':jugador1.velocidad.x=1;break;
	case 's':jugador1.velocidad.y=-4;sprintf(tecla,"s");break;
	case 'w':jugador1.velocidad.y=4;sprintf(tecla,"w");break;
	case 'l':
		jugador2.velocidad.y=-4;
		direccion->tiempo=0.0f;
		direccion->accion2=0;
		sprintf(tecla,"l");
		break;
	case 'o':
		jugador2.velocidad.y=4;
		direccion->tiempo=0.0f;
		direccion->accion2=0;
		sprintf(tecla,"o");
		break;
	}
	
	comunicacion.Send(tecla, sizeof(tecla));
}

void CMundo::Init()
{
	Plano p;
//pared inferior
	p.x1=-7;p.y1=-5;
	p.x2=7;p.y2=-5;
	paredes.push_back(p);

//superior
	p.x1=-7;p.y1=5;
	p.x2=7;p.y2=5;
	paredes.push_back(p);

	fondo_izq.r=0;
	fondo_izq.x1=-7;fondo_izq.y1=-5;
	fondo_izq.x2=-7;fondo_izq.y2=5;

	fondo_dcho.r=0;
	fondo_dcho.x1=7;fondo_dcho.y1=-5;
	fondo_dcho.x2=7;fondo_dcho.y2=5;

	//a la izq
	jugador1.g=0;
	jugador1.x1=-6;jugador1.y1=-1;
	jugador1.x2=-6;jugador1.y2=1;

	//a la dcha
	jugador2.g=0;
	jugador2.x1=6;jugador2.y1=-1;
	jugador2.x2=6;jugador2.y2=1;
		
	//Memoria compartida
	struct stat info;
	void* tmp;
	fd1=open("/tmp/memoria.dat", O_RDWR|O_CREAT|O_TRUNC, 0666);
	if (fd1 == -1)
		perror("Error al abrir archivo memoria.dat en Mundo.cpp");
	write(fd1,&datos,sizeof(datos));
	fstat(fd1,&info);
	tmp = mmap(NULL,info.st_size,PROT_READ|PROT_WRITE,MAP_SHARED,fd1,0);
	close(fd1);
	if(tmp==(void*)-1)
		perror("Error al proyectar en memoria");
	else direccion=(DatosMemCompartida*)tmp;
	
	//Enlace a socket
	char n[30];
	printf("Introduzca su nombre: ");
	scanf("%s", &n);
	
	comunicacion.Connect(ip,puerto);
	
	comunicacion.Send(n,sizeof(n));
}
