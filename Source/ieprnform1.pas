(*
Copyright (c) 1998-2010 by HiComponents. All rights reserved.

This software comes without express or implied warranty.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE.

ImageEn, IEvolution and ImageEn ActiveX may not be included in any
commercial, shareware or freeware libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com
*)

(*
File version 1002
*)

unit ieprnform1;

{$R-}
{$Q-}

{$I ie.inc}

{$IFDEF IEINCLUDEPRINTDIALOGS}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ImageEnView, ImageEnIO, ComCtrls,
  ExtCtrls, Menus, ieview, hyiedefs, hyieutils, imageenproc, ievect;

type
  TfiePrnForm1 = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    UpDown7: TUpDown;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    SpeedButton12: TSpeedButton;
    procedure Button3Click(Sender: TObject);
    procedure PrintPreview(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown4Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown7Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown5Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown6Click(Sender: TObject; Button: TUDBtnType);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure incdecmargins(text: TEdit; Button: TUDBtnType);
    function XMult:double;
  public
    { Public declarations }
    fDialogsMeasureUnit: TIEDialogsMeasureUnit;
    io: TImageEnIO;
    fTaskName: string;
    fPrintPreviewParams:TIOPrintPreviewParams;
    PrintAnnotations:boolean;
    activating:boolean;
    procedure SetLanguage(l: TMsgLanguage);
    procedure LoadParameters;
    procedure SaveParameters;
  end;

implementation

uses printers;

{$R *.DFM}

const
  FLOATINC = 0.01;

procedure tfiePrnForm1.LoadParameters;
begin
  // get parameters from fPrintPreviewParams
  Edit1.Text:=FloatToStrF(fPrintPreviewParams.MarginTop, ffGeneral,4,4);
  Edit2.Text:=FloatToStrF(fPrintPreviewParams.MarginLeft, ffGeneral,4,4);
  Edit3.Text:=FloatToStrF(fPrintPreviewParams.MarginRight, ffGeneral,4,4);
  Edit4.Text:=FloatToStrF(fPrintPreviewParams.MarginBottom, ffGeneral,4,4);
  case fPrintPreviewParams.Position of
    ppTopLeft:      SpeedButton1.Down:=True;
    ppTop:          SpeedButton2.Down:=True;
    ppTopRight:     SpeedButton3.Down:=True;
    ppLeft:         SpeedButton4.Down:=True;
    ppCenter:       SpeedButton5.Down:=True;
    ppRight:        SpeedButton6.Down:=True;
    ppBottomLeft:   SpeedButton7.Down:=True;
    ppBottom:       SpeedButton8.Down:=True;
    ppBottomRight:  SpeedButton9.Down:=True;
  end;
  ComboBox1.ItemIndex:=integer(fPrintPreviewParams.Size);
  if fPrintPreviewParams.Size=psSpecifiedSize then
  begin
    Edit5.Enabled:=true;
    Edit6.Enabled:=true;
    UpDown5.Enabled:=true;
    UpDown6.Enabled:=true;
    Edit5.Visible:=true;
    Edit6.Visible:=true;
    UpDown5.Visible:=true;
    UpDown6.Visible:=true;
  end;

  if fPrintPreviewParams.Width<=0 then
    Edit5.Text:=FloatToStrF( (io.IEBitmap.Width/IO.Params.DpiX)*xmult , ffGeneral,4,4)
  else
    Edit5.Text:=FloatToStrF(fPrintPreviewParams.Width, ffGeneral,4,4);

  if fPrintPreviewParams.Height<=0 then
    Edit6.Text:=FloatToStrF( (io.IEBitmap.Height/io.Params.DpiY)*xmult, ffGeneral,4,4)
  else
    Edit6.Text:=FloatToStrF(fPrintPreviewParams.Height, ffGeneral,4,4);

  Edit7.Text:=FloatToStrF(fPrintPreviewParams.Gamma, ffGeneral,4,4);
end;

procedure tfiePrnForm1.SaveParameters;
begin
  // put parameters to fPrintPreviewParams
  fPrintPreviewParams.MarginTop:=IEStrToFloatDefS(Edit1.Text,1);
  fPrintPreviewParams.MarginLeft:=IEStrToFloatDefS(Edit2.Text,1);
  fPrintPreviewParams.MarginRight:=IEStrToFloatDefS(Edit3.Text,1);
  fPrintPreviewParams.MarginBottom:=IEStrToFloatDefS(Edit4.Text,1);
  if SpeedButton1.Down then
    fPrintPreviewParams.Position:=ppTopLeft
  else if SpeedButton2.Down then
    fPrintPreviewParams.Position:=ppTop
  else if SpeedButton3.Down then
    fPrintPreviewParams.Position:=ppTopRight
  else if SpeedButton4.Down then
    fPrintPreviewParams.Position:=ppLeft
  else if SpeedButton5.Down then
    fPrintPreviewParams.Position:=ppCenter
  else if SpeedButton6.Down then
    fPrintPreviewParams.Position:=ppRight
  else if SpeedButton7.Down then
    fPrintPreviewParams.Position:=ppBottomLeft
  else if SpeedButton8.Down then
    fPrintPreviewParams.Position:=ppBottom
  else if SpeedButton9.Down then
    fPrintPreviewParams.Position:=ppBottomRight;
  fPrintPreviewParams.Size:=TIOPrintPreviewSize(ComboBox1.ItemIndex);

  // 2.2.4
  if (fPrintPreviewParams.Size=psSpecifiedSize) then
  begin
    fPrintPreviewParams.Width:=IEStrToFloatDefS(Edit5.Text,6);
    fPrintPreviewParams.Height:=IEStrToFloatDefS(Edit6.Text,4);
  end
  else
  begin
    fPrintPreviewParams.Width:=-1;
    fPrintPreviewParams.Height:=-1;
  end;

  fPrintPreviewParams.Gamma:=IEStrToFloatDefS(Edit7.Text,1);
end;


procedure tfiePrnForm1.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages; // first draws all controls (to avoid "Swiss Cheese")
  activating:=true;
  LoadParameters;
  if ComboBox1.ItemIndex<0 then
    ComboBox1.ItemIndex := 1;
  activating:=false;
  PrintPreview(Sender);
end;

procedure tfiePrnForm1.Button3Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
  PrintPreview(self);
end;

function tfiePrnForm1.XMult:double;
begin
  if (fDialogsMeasureUnit = ieduCm) or (fDialogsMeasureUnit = ieduSelectableDefCm) then
    xmult := 2.54
  else
    xmult := 1;
end;

// preview or print

procedure tfiePrnForm1.PrintPreview(Sender: TObject);
var
  VerticalPos: TIEVerticalPos;
  HorizontalPos: TIEHorizontalPos;
  Size: TIESize;
  MarginLeft, MarginTop, MarginRight, MarginBottom, SpecWidth, SpecHeight, GammaCorrection: double;
  ie:TImageEnVect;
  lc:TCursor;
begin
  if activating then
    exit;
  if (Width < 100) or (Height < 100) then
    exit; // to disallow AV
  VerticalPos := ievpCENTER;
  HorizontalPos := iehpCENTER;
  if SpeedButton1.Down or SpeedButton2.Down or SpeedButton3.Down then
    VerticalPos := ievpTOP;
  if SpeedButton7.Down or SpeedButton8.Down or SpeedButton9.Down then
    VerticalPos := ievpBOTTOM;
  if SpeedButton1.Down or SpeedButton4.Down or SpeedButton7.Down then
    HorizontalPos := iehpLEFT;
  if SpeedButton3.Down or SpeedButton6.Down or SpeedButton9.Down then
    HorizontalPos := iehpRIGHT;
  Size := iesFITTOPAGE;
  case ComboBox1.ItemIndex of
    0: Size := iesNORMAL;
    1: Size := iesFITTOPAGE;
    2: Size := iesFITTOPAGESTRETCH;
    3: Size := iesSPECIFIEDSIZE;
  end;
  MarginLeft := IEStrToFloatDefS(Edit2.Text, 0) / xmult;
  MarginTop := IEStrToFloatDefS(Edit1.Text, 0) / xmult;
  MarginRight := IEStrToFloatDefS(Edit3.Text, 0) / xmult;
  MarginBottom := IEStrToFloatDefS(Edit4.text, 0) / xmult;
  SpecWidth := IEStrToFloatDefS(Edit5.Text, 1) / xmult; if SpecWidth=0 then SpecWidth:=0.001;
  SpecHeight := IEStrToFloatDefS(Edit6.Text, 1) / xmult; if SpecHeight=0 then SpecHeight:=0.001;
  GammaCorrection := IEStrToFloatDefS(Edit7.Text, 1);
  lc:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  if PrintAnnotations then
  begin

    if Sender = SpeedButton11 then
    begin
      // print
      Printer.Title := fTaskName;
      Printer.BeginDoc;
      ie:=TImageEnVect.Create(nil);
      ie.IEBitmap.Assign( io.IEBitmap );

      {$ifdef IEINCLUDEIMAGINGANNOT}
      if io.Params.ImagingAnnot.ObjectsCount>0 then
      begin
        io.Params.ImagingAnnot.CopyToTImageEnVect(ie);
        ie.IEBitmap.PixelFormat:=ie24RGB;
        ie.CopyObjectsToBack(false);
        ie.RemoveAllObjects;
        ie.Update;
      end;
      {$endif}

      ie.IO.Params.DpiX:=io.Params.DpiX;
      ie.IO.Params.DpiY:=io.Params.DpiY;
      ie.IO.PrintingFilterOnSubsampling:=io.PrintingFilterOnSubsampling;
      ie.io.PrintImage(Printer.Canvas, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos,
        Size, SpecWidth, SpecHeight, GammaCorrection);
      FreeAndNil(ie);
      Printer.EndDoc;
    end
    else
    begin
      // preview
      ie:=TImageEnVect.Create(nil);
      ie.IEBitmap.Assign( io.IEBitmap );

      {$ifdef IEINCLUDEIMAGINGANNOT}
      if io.Params.ImagingAnnot.ObjectsCount>0 then
      begin
        io.Params.ImagingAnnot.CopyToTImageEnVect(ie);
        ie.IEBitmap.PixelFormat:=ie24RGB;
        ie.CopyObjectsToBack(false);
        ie.RemoveAllObjects;
        ie.Update;
      end;
      {$endif}

      ie.IO.Params.DpiX:=io.Params.DpiX;
      ie.IO.Params.DpiY:=io.Params.DpiY;
      ie.IO.PrintingFilterOnSubsampling:=io.PrintingFilterOnSubsampling;
      ie.io.PreviewPrintImage(ImageEnView1.Bitmap, ImageEnView1.Width, ImageEnView1.Height, Printer, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos,
        Size, SpecWidth, SpecHeight, GammaCorrection);
      ImageEnView1.Update;
      ImageEnView1.Fit;
      FreeAndNil(ie);
    end;

  end
  else
  begin

    if Sender = SpeedButton11 then
    begin
      // print
      Printer.Title := fTaskName;
      Printer.BeginDoc;
      io.PrintImage(Printer.Canvas, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos,
        Size, SpecWidth, SpecHeight, GammaCorrection);
      Printer.EndDoc;
    end
    else
    begin
      // preview
      io.PreviewPrintImage(ImageEnView1.Bitmap, ImageEnView1.Width, ImageEnView1.Height, Printer, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos,
        Size, SpecWidth, SpecHeight, GammaCorrection);
      ImageEnView1.Update;
      ImageEnView1.Fit;
    end;

  end;
  Screen.Cursor:=lc;
end;

procedure tfiePrnForm1.ComboBox1Change(Sender: TObject);
var
  en: boolean;
begin
  en := ComboBox1.ItemIndex = 3; // true when Specified Sizes
  Edit5.Enabled := en;
  Edit6.Enabled := en;
  UpDown5.Enabled:=en;
  UpDown6.Enabled:=en;
  Edit5.Visible:=en;
  Edit6.Visible:=en;
  UpDown5.Visible:=en;
  UpDown6.Visible:=en;
  printpreview(Sender);
end;

procedure tfiePrnForm1.Exit1Click(Sender: TObject);
begin
  modalresult := mrOK;
  Close;
end;

procedure tfiePrnForm1.SpeedButton12Click(Sender: TObject);
begin
  SaveParameters;
  modalresult := mrOK;
  Close;
end;

procedure tfiePrnForm1.SpeedButton10Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
  PrintPreview(self);
end;

procedure TfiePrnForm1.Print1Click(Sender: TObject);
begin
  PrintPreview(SpeedButton11);
end;

procedure tfiePrnForm1.SetLanguage(l: TMsgLanguage);
begin
  Caption := iemsg(IEMSG_PRINT, l);
  Print1.Caption := iemsg(IEMSG_PRINT, l);
  PrintSetup1.Caption := iemsg(IEMSG_PRINTSETUP, l) + '...';
  Exit1.Caption := iemsg(IEMSG_CLOSE2, l);
  Edit1.Hint := iemsg(IEMSG_TOPMARGIN, l);
  Edit2.Hint := iemsg(IEMSG_LEFTMARGIN, l);
  Edit3.Hint := iemsg(IEMSG_RIGHTMARGIN, l);
  Edit4.hint := iemsg(IEMSG_BOTTOMMARGIN, l);
  ComboBox1.Hint := iemsg(IEMSG_LOCATIONSIZE, l);
  Edit5.Hint := iemsg(IEMSG_WIDTH, l);
  Edit6.Hint := iemsg(IEMSG_HEIGHT, l);
  SpeedButton1.Hint := iemsg(IEMSG_TOPLEFT, l);
  SpeedButton2.Hint := iemsg(IEMSG_TOPCENTER, l);
  SpeedButton3.hint := iemsg(IEMSG_TOPRIGHT, l);
  SpeedButton4.hint := iemsg(IEMSG_CENTERLEFT, l);
  SpeedButton5.hint := iemsg(IEMSG_CENTER, l);
  SpeedButton6.hint := iemsg(IEMSG_CENTERRIGHT, l);
  SpeedButton7.hint := iemsg(IEMSG_BOTTOMLEFT, l);
  SpeedButton8.hint := iemsg(IEMSG_BOTTOMCENTER, l);
  SpeedButton9.hint := iemsg(IEMSG_BOTTOMRIGHT, l);
  Edit7.hint := iemsg(IEMSG_GAMMACORRECTION, l);
  SpeedButton10.hint := iemsg(IEMSG_PRINTSETUP, l);
  SpeedButton11.hint := iemsg(IEMSG_PRINT, l);
  SpeedButton12.caption := iemsg(IEMSG_CLOSE2, l);
end;

procedure TfiePrnForm1.incdecmargins(text: TEdit; Button: TUDBtnType);
begin
  case button of
    btNext:
      text.Text := FloatToStrF(dmax(IEStrToFloatDefS(text.Text, 0) + FLOATINC, 0), ffGeneral,4,4);
    btPrev:
      text.Text := FloatToStrF(dmax(IEStrToFloatDefS(text.Text, 0) - FLOATINC, 0), ffGeneral,4,4);
  end;
end;

procedure TfiePrnForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit1, Button);
end;

procedure TfiePrnForm1.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit2, Button);
end;

procedure TfiePrnForm1.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit3, Button);
end;

procedure TfiePrnForm1.UpDown4Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit4, Button);
end;

procedure TfiePrnForm1.UpDown7Click(Sender: TObject; Button: TUDBtnType);
begin
  case button of
    btNext:
      Edit7.Text := FloatToStrF(dmax(IEStrToFloatDefS(Edit7.Text, 0) + 0.1, 0), ffGeneral,4,4);
    btPrev:
      Edit7.Text := FloatToStrF(dmax(IEStrToFloatDefS(Edit7.Text, 0) - 0.1, 0), ffGeneral,4,4);
  end;
end;

procedure TfiePrnForm1.UpDown5Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit5, Button);
end;

procedure TfiePrnForm1.UpDown6Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit6, Button);
end;

procedure TfiePrnForm1.FormResize(Sender: TObject);
begin
  PrintPreview(self);
end;

{$ELSE} // {$ifdef IEINCLUDEPRINTDIALOGS}

interface
implementation

{$ENDIF}

end.
