#include "DatosMemCompartida.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <cstdio>
#include <cmath>

int main()
{
    DatosMemCompartida* puntero;
    int fd;

    struct stat info;
    void* tmp;
    fd = open("/tmp/memoria.dat", O_RDWR, 0666);
    if (fd == -1)
        perror("Error al abrir archivo memoria.dat en bot.cpp");
    fstat(fd, &info);
    tmp = mmap(NULL, info.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    close(fd);
    if (tmp == (void*)-1)
        perror("Error en bot.cpp al proyectar en memoria");
    else
        puntero = (DatosMemCompartida*)tmp;

    const float margen = 0.2f; // margen para evitar oscilaciones

    while (1)
    {
        // BOT jugador 1 (izquierda)
        if (puntero->tiempo1 >= 5.0f)
        {
            float centro1 = (puntero->raqueta1.y1 + puntero->raqueta1.y2) / 2.0f;
            float dy1 = puntero->esfera.centro.y - centro1;

            if (dy1 < -margen)
                puntero->accion = -1;
            else if (dy1 > margen)
                puntero->accion = 1;
            else
                puntero->accion = 0;
        }
        else
        {
            puntero->accion = 0;
        }

        // BOT jugador 2 (derecha)
        if (puntero->tiempo2 >= 5.0f)
        {
            float centro2 = (puntero->raqueta2.y1 + puntero->raqueta2.y2) / 2.0f;
            float dy2 = puntero->esfera.centro.y - centro2;

            if (dy2 < -margen)
                puntero->accion2 = -1;
            else if (dy2 > margen)
                puntero->accion2 = 1;
            else
                puntero->accion2 = 0;
        }
        else
        {
            puntero->accion2 = 0;
        }

        usleep(25000); // 25 ms
    }

    return 0;
}
