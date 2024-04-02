INCLUDE_DIRECTORIES("${PROJECT_INCLUDE_DIR}")

SET(COMMON_SRCS 
	MundoCliente.cpp 
	Esfera.cpp
	Socket.cpp
	Plano.cpp
	Raqueta.cpp
	Vector2D.cpp)
				
ADD_EXECUTABLE(cliente cliente.cpp ${COMMON_SRCS})

TARGET_LINK_LIBRARIES(cliente glut GL GLU)

SET(COMMON_SRCS 
	MundoServidor.cpp
	Socket.cpp 
	Esfera.cpp
	Plano.cpp
	Raqueta.cpp
	Vector2D.cpp)
ADD_EXECUTABLE(servidor servidor.cpp ${COMMON_SRCS})
TARGET_LINK_LIBRARIES(servidor pthread glut GL GLU)

ADD_EXECUTABLE(logger logger.cpp)
ADD_EXECUTABLE(bot bot.cpp)
