// Mundo.cpp: implementation of the CMundo class.
//
//////////////////////////////////////////////////////////////////////
#include <fstream>
#include <iostream>
#include "MundoServidor.h"
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
#include <pthread.h>
#include <signal.h>
#include <sys/socket.h>

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CMundo::CMundo()
{
	Init();
}

CMundo::~CMundo()
{
	if(close(fd_logger)==-1)
		perror("Close FIFO");
	unlink(fifo_logger);
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
	jugador1.Mueve(0.025f);
	jugador2.Mueve(0.025f);
	esfera.Mueve(0.025f);
	esfera.Disminuye(0.025f);
	
	int i;
	for(i=0;i<paredes.size();i++)
	{
		paredes[i].Rebota(esfera);
		paredes[i].Rebota(jugador1);
		paredes[i].Rebota(jugador2);
	}

	jugador1.Rebota(esfera);
	jugador2.Rebota(esfera);
	if(fondo_izq.Rebota(esfera))
	{
		esfera.radio=0.5f;
		esfera.centro.x=0;
		esfera.centro.y=rand()/(float)RAND_MAX;
		esfera.velocidad.x=2+2*rand()/(float)RAND_MAX;
		esfera.velocidad.y=2+2*rand()/(float)RAND_MAX;
		puntos2++;
		char ch2[56];
		sprintf(ch2,"Jugador %d marca 1 punto, lleva un total de %d puntos.\n", (int)2, puntos2);
		write(fd_logger, ch2, sizeof(ch2));
	}

	if(fondo_dcho.Rebota(esfera))
	{
		esfera.radio=0.5f;
		esfera.centro.x=0;
		esfera.centro.y=rand()/(float)RAND_MAX;
		esfera.velocidad.x=-2-2*rand()/(float)RAND_MAX;
		esfera.velocidad.y=-2-2*rand()/(float)RAND_MAX;
		puntos1++;
		char ch[56];
		sprintf(ch,"Jugador %d marca 1 punto, lleva un total de %d puntos.\n", (int)1, puntos1);
		write(fd_logger, ch, sizeof(ch));
	}
	
	//Finaliza cuando algun jugador llega a los 3 puntos
	if(puntos1 == 3 || puntos2 == 3)
	{
		char ch1[17];
		sprintf(ch1,"Fin del juego.\n");
		write(fd_logger, ch1, sizeof(ch1));
		kill(getpid(), SIGUSR2);
	}
	
	char cad[200];
	sprintf(cad,"%f %f %f %f %f %f %f %f %f %f %f %d %d", esfera.centro.x,esfera.centro.y,esfera.radio, jugador1.x1,jugador1.y1,jugador1.x2,jugador1.y2,jugador2.x1,jugador2.y1,jugador2.x2,jugador2.y2, puntos1, puntos2);
	
	comunicacion.Send(cad, sizeof(cad));
}

void CMundo::OnKeyboardDown(unsigned char key, int x, int y)
{

}

void CMundo::RecibeComandosJugador()
{
	
	while (1) {
            usleep(10);
            char cad[5];
            unsigned char tecla;
            comunicacion.Receive(cad,sizeof(cad));
            sscanf(cad,"%c",&tecla);
			printf("Recibida tecla: %c\n", tecla); //DEBUGGING
            if(tecla=='s')jugador1.velocidad.y=-4;
            if(tecla=='w')jugador1.velocidad.y=4;
            if(tecla=='l')jugador2.velocidad.y=-4;
            if(tecla=='o')jugador2.velocidad.y=4;
	}
}

void* hilo_comandos(void* d)
{
      CMundo* p=(CMundo*) d;
      p->RecibeComandosJugador();
}

static void terminarProceso(int s)
{
	printf("\n%d\n",s);
	exit(0);
}

static void terminarProceso2(int s)
{
	printf("\n%d\n",s);
	exit(s);
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
	
	
	//Abrir la tubería del logger en modo escritura
	fd_logger = open(fifo_logger, O_WRONLY);
	if (fd_logger == -1)
		perror("Error al abrir la FIFO del logger");
	
	//Armado señal
	struct sigaction accion_senal;
	accion_senal.sa_handler=&terminarProceso;
	sigaction(SIGUSR2, &accion_senal, NULL);
	
	struct sigaction accion_resto;
	accion_resto.sa_handler=&terminarProceso2;
	sigaction(SIGINT,&accion_resto,NULL);
	sigaction(SIGTERM,&accion_resto,NULL);
	sigaction(SIGPIPE,&accion_resto,NULL);
	
	//Enlace de socket conexion
	if (conexion.InitServer(ip, puerto) == -1) {
    	fprintf(stderr, "Error al abrir el servidor\n");
    	exit(1);
	}
	
	//Socket comunicacion
	comunicacion=conexion.Accept();
	
	char n[30];
	comunicacion.Receive(n,sizeof(n));
	
	char ch[70];
	sprintf(ch,"%s se ha conectado a la partida\n",n);
	printf("%s",ch);

	//Crear thread después de recibir el cliente
	pthread_attr_init(&atrib);
	pthread_attr_setdetachstate(&atrib, PTHREAD_CREATE_JOINABLE);
	pthread_create(&thid1, &atrib, hilo_comandos, this);
}
