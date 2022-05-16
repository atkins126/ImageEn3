//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("PKIEDBc5.res");
USEUNIT("DBImageEn.pas");
USEPACKAGE("PKIECTRLc5.bpi");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("vcldbx50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclbde50.bpi");
USEUNIT("dbimageenvect.pas");
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
