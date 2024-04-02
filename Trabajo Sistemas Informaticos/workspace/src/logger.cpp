#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include "stdio.h"

int main()
{
	int fd;
	char ch[56];
	char* nombre = "/tmp/FIFOlogger";

	if(mkfifo(nombre,0666) == 0)
	{
		fd = open(nombre, O_RDONLY);
		if(fd==-1) {
			perror("open");
			return 1;
		}
		
		while(read(fd,&ch,sizeof(ch)))
		{
			int longitud=0;
			for(int i=0;i<56;i++)
			{
				if(ch[i]!='\0')
					longitud++;
				else break;
			}
			char cad[longitud];
			for(int i=0; i<longitud;i++)
				cad[i]=ch[i];
			write(1, &cad,sizeof(cad));
		}
		
		close(fd);
		unlink(nombre);
	}
	else{
		perror("Error al crear la FIFO");
	}
	return 1;
}
