#include "partida.h"
#include "freeglut.h"
#include "ETSIDI.h"

void partida::inicializa()
{
	x_ojo = 31.9f;
	y_ojo = 100.0f;
	z_ojo = 32.0f;

    ETSIDI::play("sonidos/inicioPartida.mp3");
    piezas.cargarPartida(nombreFichero);
}

void partida::inicializaAleatoriamente()
{
    x_ojo = 31.9f;
    y_ojo = 100.0f;
    z_ojo = 32.0f;

    ETSIDI::play("sonidos/inicioPartida.mp3");
    piezas.crearPiezasAleatoriamente();
}

void partida::inicializaAjedrez960()
{
    x_ojo = 31.9f;
    y_ojo = 100.0f;
    z_ojo = 32.0f;

    ETSIDI::play("sonidos/inicioPartida.mp3");
    piezas.crearPiezasAleatoriamente();
    //piezas.crearMismoTipo(PEON);
    piezas.crearAjedrez960();
}

void partida::inicializaTipo(tipo_pieza tipo)
{
    x_ojo = 31.9f;
    y_ojo = 100.0f;
    z_ojo = 32.0f;

    ETSIDI::play("sonidos/inicioPartida.mp3");
    piezas.crearMismoTipo(tipo);
}

void partida::mover()
{
    //Si tenemos IA, si el turno es el de la IA y no está ya calculando, ejecutamos el algoritmo
    if (existeIA) {
        if (piezas.proximoTurno == colorIA) {
            if (calculando == false) {
                std::cout<<endl<<"--------------------------------------------------------------------------------"<<endl<<"Entramos al calculo" << endl;
                calculando = true;
                piezas.algoritmoIA();
                
            }
        }
        else calculando = false;
    }
 
}

void partida::dibuja()
{

	gluLookAt(x_ojo, y_ojo, z_ojo,  // posicion del ojo
		32.0, 0.0, 32.0,      // hacia que punto mira  (0,0,0) 
		0.0, 1.0, 0.0);      // definimos hacia arriba (eje Y) 

	glDisable(GL_LIGHTING);
	glColor3ub(255, 255, 255);
	glBegin(GL_POLYGON);
	glTexCoord2d(0, 1); glVertex3f(-25.0f, -1.0f, -25.0f);
	glTexCoord2d(1, 1); glVertex3f(-25.0f, -1.0f, 85.0f);
	glTexCoord2d(1, 0); glVertex3f(85.0f, -1.0f, 85.0f);
	glTexCoord2d(0, 0); glVertex3f(85.0f, -1.0f, -25.0f);
	glEnd();

    glColor3ub(0, 0, 0);
    glBegin(GL_POLYGON);
    glTexCoord2d(0, 1); glVertex3f(-1.0f, -0.5f, 65.0f);
    glTexCoord2d(1, 1); glVertex3f(65.0f, -0.5f, 65.0f);
    glTexCoord2d(1, 0); glVertex3f(65.0f, -0.5f, -1.0f);
    glTexCoord2d(0, 0); glVertex3f(-1.0f, -0.5f, -1.0f);
    glEnd();

    glColor3ub(255, 255, 255);
    //PONER LETRAS EN EL TABLERO
    for (int i = 0; i < 8; i++) {
        switch (i) {
        case 0:
            glEnable(GL_TEXTURE_2D);  
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/A.png").id);
            break;
        case 1:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/B.png").id);
            break;
        case 2:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/C.png").id);
            break;
        case 3:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/D.png").id);
            break;
        case 4:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/E.png").id);
            break;
        case 5:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/F.png").id);
            break;
        case 6:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/G.png").id);
            break;
        case 7:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/H.png").id);
            break;
        }

        glBegin(GL_POLYGON);
        glTexCoord2d(0, 0); glVertex3f(-1.0f, -0.5f, -1.0f + i * 8.0f);
        glTexCoord2d(1, 0); glVertex3f(-1.0f, -0.5f, 9.0f + i * 8.0f);
        glTexCoord2d(1, 1); glVertex3f(-9.0f, -0.5f, 9.0f + i * 8.0f);
        glTexCoord2d(0, 1); glVertex3f(-9.0f, -0.5f, -1.0f + i * 8.0f);
        glEnd();
    }
    //PONER NUMEROS EN EL TABLERO
    for (int i = 0; i < 8; i++) {
        switch (i) {
        case 0:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/1.png").id);
            break;
        case 1:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/2.png").id);
            break;
        case 2:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/3.png").id);
            break;
        case 3:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/4.png").id);
            break;
        case 4:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/5.png").id);
            break;
        case 5:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/6.png").id);
            break;
        case 6:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/7.png").id);
            break;
        case 7:
            glEnable(GL_TEXTURE_2D);
            glBindTexture(GL_TEXTURE_2D, ETSIDI::getTexture("imagenes/8.png").id);
            break;
        }

        glBegin(GL_POLYGON);
        glTexCoord2d(1, 1); glVertex3f(-1.0f + i * 8.0f, -0.5f, -1.0f);
        glTexCoord2d(0, 1); glVertex3f(-1.0f + i * 8.0f, -0.5f, -9.0f);
        glTexCoord2d(0, 0); glVertex3f(9.0f + i * 8.0f, -0.5f, -9.0f);
        glTexCoord2d(1, 0); glVertex3f(9.0f + i * 8.0f, -0.5f, -1.0f);
        glEnd();
    }
    glEnable(GL_LIGHTING);

    //Liberar memoria de la textura
    glBindTexture(GL_TEXTURE_2D, 0);

	tablero.dibuja();
    piezas.dibuja();
    //Dibujar los movmientos posibles
    if (piezas.si) {
        tablero.PintarMovPosibles(piezas.coordenadaPintar, piezas.coordenadaComer);
     
    }
}

void partida::guardarPartida()
{
    piezas.guardarPartida();
}

void partida::guardarHistorial()
{
    piezas.guardarHistorial();
}

void partida::promocionar(tipo_pieza tipo)
{
    piezas.tipo_promocion = tipo;
    piezas.promocionar = false;
    piezas.Promocion(piezas.apuntar);
}

void partida::mouse(int button, int state, int x, int y)
{
    printf_s("%d, %d\n", button, state);

    static int columna = 0;
    static int fila = 0;
    static pieza* aux;
    
    //Si apretamos el boton izquierdo del raton se muestran los movimientos posibles
    if ((button == GLUT_LEFT_BUTTON) && (state == GLUT_DOWN )) {
        getColFilMouse(x, y, fila, columna);
        aux = piezas.buscarPieza(fila, columna);
        piezas.movPosibles(aux);

    }

    //Si soltamos el raton movemos la pieza
    if ((button == GLUT_LEFT_BUTTON) && (state == GLUT_UP)) {
        getColFilMouse(x, y, fila, columna);
        piezas.moverPieza(aux, fila, columna);
        piezas.si = false;

    }
}


void partida::getColFilMouse(int x, int y, int &fila, int &columna)
{
    int x0 = 0, y0 = 0; // ESTE ES EL NUEVO 0,0 QUE SE DEFINE MAS ABAJO
    int c, f;

//te dice en que coordenadas has hecho clik exactamente con el (0,0) en la esquina de abajo del tablero (LAS X TIENES SENTIDO POSITIVO Y LAS Y NEGATIVO, SE TRABAJA EN EL CUARTO CUADRANTE)
    x0 = x - 170;
    y0 = y - 657;
    printf_s("x0: %d y0: %d\n", x0, y0);
    c = 0;
    f = 0;
    if (((x0 > -1) && (x0 < 661)) && ((y0 < 1) && (y0 > -620))) {
        for (int i = 1; i < 9; i++) {

            if ((x0 > c) && (x0 < (c + 82))) {

                columna = i; //te estable la columna un intervalo 

            }


            if ((y0 < -f) && (y0 > -(f + 75))) {

                fila = i; // te establece la fila un intervalo
            }

            //esto varia si se cambian las dimensiones de la ventada creada por freeglut
            c = c + 82; //82 son los pixeles que ocupa una casilla en x
            f = f + 77; //77 son los pixeles que ocupa una casilla en y
        }
        printf_s("columna: %d, fila: %d \n", columna, fila); //te dice la columna y la fila que has hecho click
    }
    else std::cout << "MOVIMIENTO INCORRECTO: FUERA DE RANGO" << endl;
}

void partida::setIA(bool IA, color colorIA)
{
    existeIA = IA;
    this->colorIA = colorIA;
    piezas.setColorIA(colorIA);
}



