
unit ieregctrl;

interface

{$I ie.inc}

procedure Register;

implementation

uses Classes,
{$IFDEF IEFIXFILTEDIT}
DesignIntf, FiltEdit,
{$ENDIF}
{$IFNDEF IECPPBUILDER}
  FiltEdit,
{$IFDEF IEFIXDESIGNINT}
  DesignIntf,
{$ELSE}
  DsgnIntf,
{$ENDIF}
{$ENDIF}
  ImageEn, HSVBox, ImageEnProc, ImageEnView, ImageEnIO, HistogramBox, RulerBox, IEGradientBar,
  VideoCap, IEVect, IEMView, Iemio, IEOpenSaveDlg, hvideocap, hyieutils;

procedure Register;
begin
{$IFDEF IEINCLUDETIMAGEEN}
  RegisterComponents('ImageEn', [TImageEn]);
{$ENDIF}
  RegisterComponents('ImageEn', [TImageEnProc]);
  RegisterComponents('ImageEn', [TImageEnView]);
  RegisterComponents('ImageEn', [TImageEnVect]);
{$IFDEF IEINCLUDEVIDEOCAPTURE}
  RegisterComponents('ImageEn', [TImageEnVideoView]);
  RegisterComponents('ImageEn', [TImageEnVideoCap]);
{$ENDIF}
{$IFDEF IEINCLUDEMULTIVIEW}
  RegisterComponents('ImageEn', [TImageEnMIO]);
  RegisterComponents('ImageEn', [TImageEnMView]);
{$ENDIF}
  RegisterComponents('ImageEn', [TImageEnIO]);
  RegisterComponents('ImageEn', [THistogramBox]);
  RegisterComponents('ImageEn', [TIEGradientBar]);
  RegisterComponents('ImageEn', [THSVBox]);
  RegisterComponents('ImageEn', [TOpenImageEnDialog]);
  RegisterComponents('ImageEn', [TSaveImageEnDialog]);
  RegisterComponents('ImageEn', [TRulerBox]);
{$IFNDEF IECPPBUILDER}
  RegisterPropertyEditor(TypeInfo(string), TOpenImageEnDialog, 'Filter', TFilterProperty);
{$ENDIF}
{$IFDEF IEFIXFILTEDIT}
  RegisterPropertyEditor(TypeInfo(string), TOpenImageEnDialog, 'Filter', TFilterProperty);
{$ENDIF}
end;

end.
