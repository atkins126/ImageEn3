//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("DPKIEDBc5.res");
USEUNIT("IERegDB.pas");
USERES("IERegDB.dcr");
USEPACKAGE("PKIEDBc5.bpi");
USEPACKAGE("vcl50.bpi");
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
