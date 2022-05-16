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
File version 1003
*)

unit ieprnform2;

{$R-}
{$Q-}

{$I ie.inc}

{$IFDEF IEINCLUDEPRINTDIALOGS}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ImageEnView, ImageEnIO, ieview, hyiedefs, hyieutils,
  ComCtrls, ImageEnProc, ievect, ExtCtrls;

type
  TfiePrnForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    GroupBox2: TGroupBox;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    Label7: TLabel;
    Edit6: TEdit;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    Edit7: TEdit;
    Label9: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox5: TGroupBox;
    ImageEnView1: TImageEnView;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    UpDown7: TUpDown;
    Button4: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    GroupBox6: TGroupBox;
    Label10: TLabel;
    ComboBox2: TComboBox;
    Image1: TImage;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure printpreview(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown4Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown7Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown5Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown6Click(Sender: TObject; Button: TUDBtnType);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure incdecmargins(text: TEdit; Button: TUDBtnType);
    procedure SetLanguage_units;
    function XMult:double;
  public
    { Public declarations }
    io: TImageEnIO;
    fDialogsMeasureUnit: TIEDialogsMeasureUnit;
    fLanguage: TMsgLanguage;
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

procedure tfiePrnForm2.LoadParameters;
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
    Label5.Enabled:=true;
    Label6.Enabled:=true;
    Label7.Enabled:=true;
    Label8.Enabled:=true;
    Edit5.Visible:=true;
    Edit6.Visible:=true;
    UpDown5.Visible:=true;
    UpDown6.Visible:=true;
    Label5.Visible:=true;
    Label6.Visible:=true;
    Label7.Visible:=true;
    Label8.Visible:=true;
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

procedure tfiePrnForm2.SaveParameters;
begin
  // put parameters to fPrintPreviewParams
  fPrintPreviewParams.MarginTop    := IEStrToFloatDefS(Edit1.Text,1);
  fPrintPreviewParams.MarginLeft   := IEStrToFloatDefS(Edit2.Text,1);
  fPrintPreviewParams.MarginRight  := IEStrToFloatDefS(Edit3.Text,1);
  fPrintPreviewParams.MarginBottom := IEStrToFloatDefS(Edit4.Text,1);
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
    fPrintPreviewParams.Width :=IEStrToFloatDefS(Edit5.Text,6);
    fPrintPreviewParams.Height:=IEStrToFloatDefS(Edit6.Text,4);
  end
  else
  begin
    fPrintPreviewParams.Width:=-1;
    fPrintPreviewParams.Height:=-1;
  end;

  fPrintPreviewParams.Gamma:=IEStrToFloatDefS(Edit7.Text,1);
end;

procedure TfiePrnForm2.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages; // first draws all controls (to avoid "Swiss Cheese")  
  activating:=true;
  LoadParameters;
  if ComboBox1.ItemIndex<0 then
    ComboBox1.ItemIndex := 1;
  GroupBox6.visible := (fDialogsMeasureUnit = ieduSelectableDefInches) or (fDialogsMeasureUnit = ieduSelectableDefCm);
  if (fDialogsMeasureUnit = ieduSelectableDefInches) then
    ComboBox2.ItemIndex := 0
  else if (fDialogsMeasureUnit = ieduSelectableDefCm) then
    ComboBox2.ItemIndex := 1;
  activating:=false;
  printpreview(Sender);
end;

// Changes Size combobox

procedure TfiePrnForm2.ComboBox1Change(Sender: TObject);
var
  en: boolean;
begin
  en := ComboBox1.ItemIndex = 3; // true when Specified Sizes
  Label5.Enabled := en;
  Label6.Enabled := en;
  Label7.Enabled := en;
  Label8.Enabled := en;
  Edit5.Enabled := en;
  Edit6.Enabled := en;
  UpDown5.Enabled:=en;
  UpDown6.Enabled:=en;
  Edit5.Visible:=en;
  Edit6.Visible:=en;
  UpDown5.Visible:=en;
  UpDown6.Visible:=en;
  Label5.Visible := en;
  Label6.Visible := en;
  Label7.Visible := en;
  Label8.Visible := en;
  printpreview(Sender);
end;

// Preview

procedure TfiePrnForm2.Button3Click(Sender: TObject);
begin
  printpreview(Sender);
end;

// OK (print)

procedure TfiePrnForm2.Button1Click(Sender: TObject);
begin
  SaveParameters;
  printpreview(Sender);
end;

function tfiePrnForm2.XMult:double;
begin
  if (fDialogsMeasureUnit = ieduCm) or (fDialogsMeasureUnit = ieduSelectableDefCm) then
    xmult := 2.54
  else
    xmult := 1;
end;

// preview or print

procedure TfiePrnForm2.printpreview(Sender: TObject);
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

    if Sender = Button1 then
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

    if Sender = Button1 then
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

procedure tfiePrnForm2.SetLanguage_units;
begin
  if (fDialogsMeasureUnit = ieduInches) or (fDialogsMeasureUnit = ieduSelectableDefInches) then
  begin
    // inches
    GroupBox1.Caption := ' ' + iemsg(IEMSG_MARGINS, fLanguage) + ' (' + iemsg(IEMSG_INCHES, fLanguage) + ') ';
    Label7.Caption := iemsg(IEMSG_INCHES, fLanguage);
    Label8.Caption := iemsg(IEMSG_INCHES, fLanguage);
  end
  else
  begin
    // centimeters (Cm)
    GroupBox1.Caption := ' ' + iemsg(IEMSG_MARGINS, fLanguage) + ' (cm) ';
    Label7.Caption := 'cm';
    Label8.Caption := 'cm';
  end;
end;

procedure tfiePrnForm2.SetLanguage(l: TMsgLanguage);
begin
  fLanguage := l;
  Caption := iemsg(IEMSG_PRINT, l);
  SetLanguage_units;
  Label1.Caption := iemsg(IEMSG_TOP, l);
  Label2.Caption := iemsg(IEMSG_LEFT, l);
  Label3.Caption := iemsg(IEMSG_RIGHT, l);
  Label4.Caption := iemsg(IEMSG_BOTTOM, l);
  GroupBox2.Caption := ' ' + iemsg(IEMSG_POSITION, l) + ' ';
  GroupBox5.Caption := ' ' + iemsg(IEMSG_PREVIEW, l) + ' ';
  GroupBox3.Caption := ' ' + iemsg(IEMSG_SIZE, l) + ' ';
  ComboBox1.Items[0] := iemsg(IEMSG_NORMAL, l);
  ComboBox1.Items[1] := iemsg(IEMSG_FITTOPAGE, l);
  ComboBox1.Items[2] := iemsg(IEMSG_STRETCHTOPAGE, l);
  ComboBox1.Items[3] := iemsg(IEMSG_SPECIFIEDSIZE, l);
  Label5.Caption := iemsg(IEMSG_WIDTH, l);
  Label6.Caption := iemsg(IEMSG_HEIGHT, l);
  GroupBox4.Caption := ' ' + iemsg(IEMSG_GAMMACORRECTION, l) + ' ';
  Label9.Caption := iemsg(IEMSG_VALUE2, l);
  Button1.Caption := iemsg(IEMSG_OK, l);
  Button2.Caption := iemsg(IEMSG_CANCEL, l);
  Button4.Caption := iemsg(IEMSG_PRINTSETUP, l) + '...';
  GroupBox6.Caption := iemsg(IEMSG_MEASUREUNITS, l);
  Label10.Caption := iemsg(IEMSG_UNITS, l);
  ComboBox2.Items[0] := iemsg(IEMSG_INCHES, l);
end;

procedure TfiePrnForm2.incdecmargins(text: TEdit; Button: TUDBtnType);
begin
  case button of
    btNext:
      text.Text := FloatToStrF(dmax(IEStrToFloatDefS(text.Text, 0) + FLOATINC, 0), ffGeneral,4,4);
    btPrev:
      text.Text := FloatToStrF(dmax(IEStrToFloatDefS(text.Text, 0) - FLOATINC, 0), ffGeneral,4,4);
  end;
end;

procedure TfiePrnForm2.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit1, Button);
end;

procedure TfiePrnForm2.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit2, Button);
end;

procedure TfiePrnForm2.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit3, Button);
end;

procedure TfiePrnForm2.UpDown4Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit4, Button);
end;

procedure TfiePrnForm2.UpDown7Click(Sender: TObject; Button: TUDBtnType);
begin
  case button of
    btNext:
      Edit7.Text := FloatToStrF(dmax(IEStrToFloatDefS(Edit7.Text, 0) + 0.1, 0), ffGeneral,4,4);
    btPrev:
      Edit7.Text := FloatToStrF(dmax(IEStrToFloatDefS(Edit7.Text, 0) - 0.1, 0), ffGeneral,4,4);
  end;
end;

procedure TfiePrnForm2.UpDown5Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit5, Button);
end;

procedure TfiePrnForm2.UpDown6Click(Sender: TObject; Button: TUDBtnType);
begin
  incdecmargins(Edit6, Button);
end;

// setup

procedure TfiePrnForm2.Button4Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
  printpreview(self);
end;

// units

procedure TfiePrnForm2.ComboBox2Change(Sender: TObject);
var
  pred: TIEDialogsMeasureUnit;
  xmult: double;
begin
  pred := fDialogsMeasureUnit;
  if ComboBox2.ItemIndex = 0 then
    fDialogsMeasureUnit := ieduSelectableDefInches
  else
    fDialogsMeasureUnit := ieduSelectableDefCm;
  if pred <> fDialogsMeasureUnit then
  begin
    if pred = ieduSelectableDefCm then
      xmult := 1 / 2.54
    else
      xmult := 2.54;
    Edit1.Text := FloatToStrF(IEStrToFloatDefS(Edit1.Text, 0) * xmult, ffGeneral,4,4);
    Edit2.Text := FloatToStrF(IEStrToFloatDefS(Edit2.Text, 0) * xmult, ffGeneral,4,4);
    Edit3.Text := FloatToStrF(IEStrToFloatDefS(Edit3.Text, 0) * xmult, ffGeneral,4,4);
    Edit4.Text := FloatToStrF(IEStrToFloatDefS(Edit4.Text, 0) * xmult, ffGeneral,4,4);
    Edit5.Text := FloatToStrF(IEStrToFloatDefS(Edit5.Text, 0) * xmult, ffGeneral,4,4);
    Edit6.Text := FloatToStrF(IEStrToFloatDefS(Edit6.Text, 0) * xmult, ffGeneral,4,4);
    SetLanguage_units;
  end;
end;

procedure TfiePrnForm2.FormCreate(Sender: TObject);
begin
  // 2.2.7
  case iegDialogsBackground of
    iedbPaper:
      begin
        ImageEnView1.Background:=clWhite;
        IECreateOSXBackgroundPaper(Image1.Picture.Bitmap,Image1.Width,Image1.Height);
        Image1.Update;
      end;
    iedbMetal:
      begin
        ImageEnView1.Background:=clSilver;
        IECreateOSXBackgroundMetal(Image1.Picture.Bitmap,Image1.Width,Image1.Height);
        Image1.Update;
      end;
  end;
end;

{$ELSE} // {$ifdef IEINCLUDEPRINTDIALOGS}

interface
implementation

{$ENDIF}


end.
