# Changelog

## [5.0] - 11/12/2020
##Añadido
- Conexión entre mundo y servidor mediante sockets a través de la clase Socket
##Eliminado
- FIFOs que conectaban el mundo cliente y el mundo servidor

## [4.0] - 2/12/2020
## Añadido
- Se ha implementado una estructura de cliente servidor en el juego. El servidor está conectado con el logger y envía datos al cliente a trravés de una FIFO. El cliente es desde donde se pulsan las teclas, información que pasa al servidor a través de una FIFO, y este último lo recibe gracias a un hilo. EL cliente a su vez está conectado con el bot.
- Tratamiento de señales SIGINT, SIGPIPE, SIGTERM y SIGUSR2.
## Modificado
- Archivos bot.cpp y logger.cpp para que correspondan con la nueva estructura cliente-servidor.
- Archivo workspace/CMakeLists.txt para poder generar ejecutables distintos para el servidor y el cliente, ademñas de añadir la libreería pthread para el servidor.
## Eliminado
- Mundo.cpp, Mundo.h y tenis.cpp dado que ya no hacían falta.

## [3.0] - 18/11/2020
## Añadido
- logger.cpp el cual generará un ejecutable para comunicarse con mundo a través de un tubería llamada FIFOtenis
- bot.cpp otro ejecutable que se encargará de controlar la raqueta del jugador 1, para ello se comunicará con mundo a través de un archivo proyectado en memoria compartida. Además podrrá controlar la raqueta del jugador 2 cuando este no haya pulsado ninguna tecla durante 10 segundos.
- DatosMemCompartida.h para implementar la comunicación entre bot y Mundo
## Modificado
- Archivo workspace/CMakeLists.txt para generar los ejecutables de logger y bot
- Mundo.cpp y Mundo.h para implementar las funciones de logger.cpp y bot.cpp. También se ha implementado en este archivo la finalización del programa cuando alguno de los jugadores llega a 3 puntos.

## [2.0] - 16/10/2020
## Añadido
- README para indicar con quñe teclas se manejan las raquetas
- Función que disminuye el tamaño de pelota según avanza el tiempo
## Modificado
- Se han modificado las funciones mueve de la clase Raqueta y Pelota para que se muevan

## [1.1] -  08/10/2020
## Añadido
- Changelog
## Modificado
- Cabeceras ficheros fuente para identificar al autor del código
