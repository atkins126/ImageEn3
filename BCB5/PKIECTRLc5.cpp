//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("PKIECTRLc5.res");
USEUNIT("VideoCap.pas");
USEUNIT("GIFFilter.pas");
USEUNIT("GifLZW.pas");
USEUNIT("HistogramBox.pas");
USEUNIT("HSVBox.pas");
USEUNIT("IEGradientBar.pas");
USEUNIT("IEMIO.pas");
USEUNIT("IEMView.pas");
USEUNIT("IEOpenSaveDlg.pas");
USEUNIT("IEVect.pas");
USEUNIT("IEVfw.pas");
USEUNIT("ImageEn.pas");
USEUNIT("ImageEnIO.pas");
USEUNIT("ImageEnProc.pas");
USEUNIT("ImageEnView.pas");
USEUNIT("imscan.pas");
USEUNIT("jpegfilt.pas");
USEUNIT("NeurQuant.pas");
USEUNIT("PCXFilter.pas");
USEUNIT("pngfilt.pas");
USEUNIT("pngfiltw.pas");
USEUNIT("RulerBox.pas");
USEUNIT("TIFCCITT.pas");
USEUNIT("Tiffilt.pas");
USEUNIT("TIFLZW.pas");
USEUNIT("BMPFilt.pas");
USEUNIT("ietwain.pas");
USEUNIT("stdquant.pas");
USEUNIT("iewords.pas");
USEUNIT("iefft.pas");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("bcbsmp50.bpi");
USEUNIT("ietgafil.pas");
USEUNIT("hvideocap.pas");
USEUNIT("hyieutils.pas");
USEUNIT("hyiedefs.pas");
USEUNIT("ieview.pas");
USEFORMNS("ieprnform2.pas", Ieprnform2, fieprnform2);
USEFORMNS("ieprnform1.pas", Ieprnform1, fieprnform1);
USEUNIT("iej2000.pas");
USEUNIT("iewia.pas");
USEUNIT("ietextc.pas");
USEUNIT("ieds.pas");
USEFORMNS("ieprnform3.pas", Ieprnform3, fieprnform3);
USEUNIT("iezlib.pas");
USEUNIT("ielcms.pas");
USEUNIT("ieXtraTransitions.pas");
USEUNIT("iepresetim.pas");
USEUNIT("ieraw.pas");
USEUNIT("iepsd.pas");
USEUNIT("iedicom.pas");
USEUNIT("iegdiplus.pas");
USEUNIT("iewic.pas");
USEUNIT("ieXCanvasUtils.pas");
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
