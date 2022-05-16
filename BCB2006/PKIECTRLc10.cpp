//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEFORMNS("ieprnform2.pas", Ieprnform2, fieprnform2);
USEFORMNS("ieprnform1.pas", Ieprnform1, fieprnform1);
USEFORMNS("ieprnform3.pas", Ieprnform3, fieprnform3);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
	return 1;
}
//---------------------------------------------------------------------------
