//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("DPKIECTRLc5.res");
USEPACKAGE("PKIECTRLc5.bpi");
USEUNIT("IERegCtrl.pas");
USERES("IERegCtrl.dcr");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
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
