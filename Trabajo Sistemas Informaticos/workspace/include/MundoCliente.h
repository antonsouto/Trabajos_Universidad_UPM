// Mundo.h: interface for the CMundo class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_MUNDO_H__9510340A_3D75_485F_93DC_302A43B8039A__INCLUDED_)
#define AFX_MUNDO_H__9510340A_3D75_485F_93DC_302A43B8039A__INCLUDED_

#include <vector>
#include "Plano.h"

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Esfera.h"
#include "DatosMemCompartida.h"
#include "Socket.h"

class CMundo  
{
public:
	void Init();
	CMundo();
	virtual ~CMundo();	
	
	void InitGL();	
	void OnKeyboardDown(unsigned char key, int x, int y);
	void OnTimer(int value);
	void OnDraw();

	Esfera esfera;
	std::vector<Plano> paredes;
	Plano fondo_izq;
	Plano fondo_dcho;
	Raqueta jugador1;
	Raqueta jugador2;
	DatosMemCompartida datos;
	DatosMemCompartida* direccion;
	
	Socket comunicacion;
	const char* ip = "127.0.0.1";
	int puerto=6000;

	int puntos1;
	int puntos2;
	
	int fd1;
};

#endif // !defined(AFX_MUNDO_H__9510340A_3D75_485F_93DC_302A43B8039A__INCLUDED_)
