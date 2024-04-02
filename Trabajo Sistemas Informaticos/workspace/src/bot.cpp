#include "DatosMemCompartida.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>


int main()
{
	DatosMemCompartida* puntero;
	int fd;
	
	struct stat info;
	void* tmp;
	fd=open("/tmp/memoria.dat", O_RDWR, 0666);
	if (fd == -1)
		perror("Error al abrir archivo memoria.dat en bot.cpp");
	fstat(fd,&info);
	tmp = mmap(NULL,info.st_size,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);
	close(fd);
	if(tmp==(void*)-1)
		perror("Error en bot.cpp al proyectar en memoria");
	else puntero=(DatosMemCompartida*)tmp;
	
	
	
	while(1)
	{
		
		if(puntero->esfera.centro.y < (puntero->raqueta1.y1+puntero->raqueta1.y2)/2)
			puntero->accion = -1;
		else if(puntero->esfera.centro.y > (puntero->raqueta1.y1+puntero->raqueta1.y2)/2)
			puntero->accion = 1;
		else puntero->accion = 0;
		
		if(puntero->tiempo >= 10.0)
		{
			if(puntero->esfera.centro.y < (puntero->raqueta2.y1+puntero->raqueta2.y2)/2)
				puntero->accion2 = -1;
			else if(puntero->esfera.centro.y > (puntero->raqueta2.y1+puntero->raqueta2.y2)/2)
				puntero->accion2 = 1;
			else puntero->accion2 = 0;
		}
		
		usleep(25000);
	}
}
