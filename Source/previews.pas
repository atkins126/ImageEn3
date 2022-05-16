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
File version 1007
*)

unit previews;

{$R-}
{$Q-}

{$I ie.inc}

{$IFDEF IEINCLUDEDIALOGIP}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  {$ifdef IEHASTYPES} Types, {$endif}
  StdCtrls, ComCtrls, ImageEn, ExtCtrls, HSVBox, ImageEnProc, ImageEnView,
  checklst, HistogramBox, RulerBox, Buttons, ImageEnIO, hyiedefs, iefft,
  ieview, Dialogs;

const
  PREVIEWSTABCOUNT = 14;

type
  TfPreviews = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label3: TLabel;
    Edit1: TEdit;
    TrackBar1: TTrackBar;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar5: TTrackBar;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    TrackBar6: TTrackBar;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    GroupBox1: TGroupBox;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    UpDown7: TUpDown;
    UpDown8: TUpDown;
    UpDown9: TUpDown;
    GroupBox3: TGroupBox;
    ListBox1: TListBox;
    ResultToSourceButton: TButton;
    TabSheet5: TTabSheet;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    TrackBar9: TTrackBar;
    TrackBar10: TTrackBar;
    TrackBar11: TTrackBar;
    Label13: TLabel;
    Label14: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Button4: TButton;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Edit20: TEdit;
    UpDown10: TUpDown;
    Label15: TLabel;
    TabSheet6: TTabSheet;
    Panel5: TPanel;
    GroupBox4: TGroupBox;
    CheckListBox1: TCheckListBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    SpeedButton3: TSpeedButton;
    Label22: TLabel;
    Edit21: TEdit;
    TrackBar12: TTrackBar;
    HSVBox3: THSVBox;
    HSVBox1: THSVBox;
    RulerBox2: TRulerBox;
    RulerBox1: TRulerBox;
    HistogramBox1: THistogramBox;
    PreviewButton: TButton;
    ImageEn1: TImageEnView;
    ImageEn2: TImageEnView;
    TabSheet7: TTabSheet;
    GroupBox2: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Panel1: TPanel;
    HSVBox2: THSVBox;
    Label27: TLabel;
    Label28: TLabel;
    Label25: TLabel;
    Edit22: TEdit;
    UpDown11: TUpDown;
    UpDown12: TUpDown;
    Edit23: TEdit;
    Edit24: TEdit;
    UpDown13: TUpDown;
    Edit25: TEdit;
    UpDown14: TUpDown;
    Edit26: TEdit;
    UpDown15: TUpDown;
    TabSheet8: TTabSheet;
    GroupBox5: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Edit27: TEdit;
    UpDown16: TUpDown;
    UpDown17: TUpDown;
    Edit28: TEdit;
    Edit29: TEdit;
    UpDown18: TUpDown;
    Edit30: TEdit;
    UpDown19: TUpDown;
    Label31: TLabel;
    UpDown20: TUpDown;
    Edit31: TEdit;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    GroupBox6: TGroupBox;
    Label34: TLabel;
    Edit32: TEdit;
    UpDown21: TUpDown;
    UpDown22: TUpDown;
    Edit33: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    Edit34: TEdit;
    UpDown23: TUpDown;
    CheckBox2: TCheckBox;
    GroupBox7: TGroupBox;
    Label37: TLabel;
    ListBox2: TListBox;
    Label38: TLabel;
    Edit35: TEdit;
    UpDown24: TUpDown;
    TabSheet11: TTabSheet;
    TrackBarRotate: TTrackBar;
    EditRotate: TEdit;
    LabelRotate: TLabel;
    TabSheet12: TTabSheet;
    GroupBox8: TGroupBox;
    ImageEnView1: TImageEnView;
    ImageEnProc2: TImageEnProc;
    Clear: TButton;
    Button7: TButton;
    ProgressBar1: TProgressBar;
    CheckBox1: TCheckBox;
    tabGamma: TTabSheet;
    GroupBox9: TGroupBox;
    cbxGamma: TCheckListBox;
    Label39: TLabel;
    edtGamma: TEdit;
    trkGamma: TTrackBar;
    ImageEnView2: TImageEnView;
    Label41: TLabel;
    Label42: TLabel;
    Label40: TLabel;
    Label43: TLabel;
    TabSheet14: TTabSheet;
    Label44: TLabel;
    Edit36: TEdit;
    TrackBar4: TTrackBar;
    Label45: TLabel;
    Edit37: TEdit;
    UpDown25: TUpDown;
    chkLockPreview: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label46: TLabel;
    Image1: TImage;
    ResetButton: TButton;
    procedure FormActivate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ResultToSourceButtonClick(Sender: TObject);
    procedure ImageEn1ViewChange(Sender: TObject; Change: Integer);
    procedure TrackBar6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure TrackBar9Change(Sender: TObject);
    procedure Edit19Change(Sender: TObject);
    procedure HSVBox3Change(Sender: TObject);
    procedure ImageEn2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBox1Click(Sender: TObject);
    procedure RulerBox2RulerPosChange(Sender: TObject; Grip: Integer);
    procedure RulerBox1RulerPosChange(Sender: TObject; Grip: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PreviewButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit22Change(Sender: TObject);
    procedure HSVBox2Change(Sender: TObject);
    procedure Edit27Change(Sender: TObject);
    procedure Edit32Change(Sender: TObject);
    procedure Edit35Change(Sender: TObject);
    procedure TrackBarRotateChange(Sender: TObject);
    procedure EditRotateChange(Sender: TObject);
    procedure SpeedButtonFlipHorClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ImageEnProc2Progress(Sender: TObject; per: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure trkGammaChange(Sender: TObject);
    procedure cbxGammaClick(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure Edit36Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
  private
    { Private declarations }
    mr, mg, mb: integer;  // contrast: median values
    domod: boolean;       // used by user filters
    dochange: boolean;    // if true, controls can change their status
    doProgress: boolean;
    fResized:boolean;
    NeedToFlip: boolean;  // true when image must be flipped
    procedure applyAct(im: TImageEnView);
    procedure CopyOrg;
    procedure CopyModToOrg;
    procedure LoadFilt;
    procedure ResetParameters(rs: boolean);
    procedure UpdatePreviewZoom;
    procedure UpdatePreview;
    procedure DrawGammaGraph(g: double);
    procedure GetIPParams;
    procedure WMEXITSIZEMOVE(var Message: TMessage); message WM_EXITSIZEMOVE;
  public
    { Public declarations }
    Contrast: integer;          // contrast (output)
    Brightness: integer;        // Brightness (output) = luminosity
    Hue, Sat, Lum: integer;     // Hue/Sat/Lum (output)
    bHue, bSat, bVal: integer;  // Hue/Sat/Val (output)
    Red, Green, Blue: integer;  // RGB (output)
    Filter: TGraphFilter;       // Filter (output)
    DownLimit, UpLimit: TRGB;   // threshold
    EDownLimit, EUpLimit: TRGB; // equalize
    AutoEqualize: boolean;      // autoequalize
    BumpLeft, BumpTop, BumpWidth, BumpHeight: integer; // bump map
    BumpCol: TRGB;    // bump map light color
    BumpSrc: integer; // bump map % image
    LensLeft, LensTop, LensWidth, LensHeight: integer; // Lens
    LensRef: double;  // Lens reflection
    WaveAmplitude: integer;
    WaveWaveLength: integer;
    WavePhase: integer;
    WaveReflect: boolean;
    MorphFilter: integer;
    MorphWinSize: integer;
    RotationAngle: double; // rotate
    Sharpen: integer;
    SharpenSize: integer;
    // FFT
    FFTProgressPos: integer;
    FTImage: TIEFtImage;

    pe: TPreviewEffects;
    Progress: TProgressRec;
    DefaultLockPreview: boolean;
    ars: array[0..PREVIEWSTABCOUNT - 1] of boolean;
    undos: array[0..PREVIEWSTABCOUNT - 1] of string;
    InitialPage: TTabSheet;
    UndoCaption:string;

    fIPDialogParams:TIPDialogParams;

    ShowReset:boolean;
    HardReset:boolean;
    ResetAllTabs:boolean;

    OpList:TStringList;  // list of operations done (NOT CREATED HERE!)
    CurrentOp:string;

    procedure SetLanguage(l: TMsgLanguage);

  end;

implementation

uses hyieutils, iegdiplus;

{$R-}

{$R *.DFM}



procedure TfPreviews.FormDestroy(Sender: TObject);
begin
  if assigned(FTImage) then
    FreeAndNil(FTImage);
end;



procedure TfPreviews.FormCreate(Sender: TObject);
{$IFDEF IEFIXPREVIEWS}
var
  q: integer;
{$ENDIF}
begin
  CurrentOp:='';
  with ImageEn1.IO do
  begin
    PreviewFont.Charset := DEFAULT_CHARSET;
    PreviewFont.Color := clWindowText;
    PreviewFont.Height := -11;
    PreviewFont.Name := 'MS Sans Serif';
    PreviewFont.Style := [];
  end;
  with ImageEn2.IO do
  begin
    PreviewFont.Charset := DEFAULT_CHARSET;
    PreviewFont.Color := clWindowText;
    PreviewFont.Height := -11;
    PreviewFont.Name := 'MS Sans Serif';
    PreviewFont.Style := [];
  end;
  ImageEn2.Proc.AutoUndo := False;
{$IFDEF IEFIXPREVIEWS}
  for q := 0 to ComponentCount - 1 do
    if (Components[q] is TTrackBar) then
      (Components[q] as TTrackBar).ThumbLength := 20; // 3.0.3
{$ENDIF}
  FTImage := nil;
  PageControl1.ActivePage := TabSheet1;
  ImageEn2.Proc.UndoLocation := ieMemory;
  UndoCaption:='';
end;


// if rs is True initialize all
procedure TfPreviews.ResetParameters(rs: boolean);
var
  i, x:integer;
  w, h, ww:integer;
begin
  if rs then
    for x := 0 to high(ars) do
      ars[x] := false;
  //
  dochange := false;
  // contrast and brightness
  if (PageControl1.ActivePage = TabSheet1) and not ars[0] then
  begin
    _getmediacontrastRGB(imageen1.IEBitmap, mR, mG, mB);
    Contrast := fIPDialogParams.CONTRAST_Contrast;
    Brightness := fIPDialogParams.CONTRAST_Brightness;
    edit1.text := IntToStr(Contrast);
    edit21.text := IntToStr(Brightness);
    trackbar1.position := Contrast;
    trackbar12.position := Brightness;
    ars[0] := true;
    undos[0]:='Contrast/Brightness';
  end;
  // HSL
  if (PageControl1.ActivePage = TabSheet2) and not ars[1] then
  begin
    Hue := fIPDialogParams.HSL_H;
    Sat := fIPDialogParams.HSL_S;
    Lum := fIPDialogParams.HSL_L;
    trackbar2.Position := Hue;
    trackbar3.Position := Sat;
    trackbar5.Position := Lum;
    edit4.text := IntToStr(Hue);
    edit2.text := IntToStr(Sat);
    edit3.text := IntToStr(Lum);
    ars[1] := true;
    undos[1]:='HSL adjust';
  end;
  // rgb
  if (PageControl1.ActivePage = TabSheet3) and not ars[2] then
  begin
    red := fIPDialogParams.RGB_R;
    green := fIPDialogParams.RGB_G;
    blue := fIPDialogParams.RGB_B;
    trackbar6.Position := red;
    trackbar7.Position := green;
    trackbar8.Position := blue;
    edit7.text := IntToStr(red);
    edit6.text := IntToStr(green);
    edit5.texT := IntToStr(blue);
    ars[2] := true;
    undos[2]:='RGB adjust';
  end;
  // user filter
  if (PageControl1.ActivePage = TabSheet4) and not ars[3] then
  begin
    Filter:=fIPDialogParams.USERFILTER_Values;
    listbox1.itemindex := 0;
    LoadFilt;
    ars[3] := true;
    undos[3]:='Convolution Filter';
  end;
  // HSV
  if (PageControl1.ActivePage = TabSheet5) and not ars[4] then
  begin
    bHue := fIPDialogParams.HSV_H;
    bSat := fIPDialogParams.HSV_S;
    bVal := fIPDialogParams.HSV_V;
    trackbar9.Position := bHue;
    trackbar10.Position := bSat;
    trackbar11.Position := bVal;
    edit19.text := IntToStr(bHue);
    edit18.text := IntToStr(bSat);
    edit17.text := IntToStr(bVal);
    ars[4] := true;
    undos[4]:='HSV adjust';
  end;
  // threshold (histogram)
  if (PageControl1.ActivePage = TabSheet6) and not ars[5] then
  begin
    DownLimit:=fIPDialogParams.EQUALIZATION_ThresholdDown;
    UpLimit:=fIPDialogParams.EQUALIZATION_ThresholdUp;
    EDownLimit:=fIPDialogParams.EQUALIZATION_EqDown;
    EUpLimit:=fIPDialogParams.EQUALIZATION_EqUp;
    AutoEqualize := fIPDialogParams.EQUALIZATION_EqualizeButton;
    CheckListBox1.Checked[0] := false;
    CheckListBox1.Checked[1] := false;
    CheckListBox1.Checked[2] := false;
    CheckListBox1.Checked[3] := true;
    HistogramBox1.HistogramKind := [hkGray];
    with RulerBox1 do
    begin
      GripsPos[0] := DownLimit.r;
      GripsColor[0] := clGray;
      GripsKind[0] := gkArrow2;
      GripsPos[1] := UpLimit.r;
      GripsColor[1] := clGray;
      GripsKind[1] := gkArrow2;
    end;
    with RulerBox2 do
    begin
      GripsPos[0] := EDownLimit.r;
      GripsColor[0] := clGray;
      GripsPos[1] := EUpLimit.r;
      GripsColor[1] := clGray;
    end;
    speedbutton3.down := AutoEqualize;
    ars[5] := true;
    undos[5]:='Histogram adjust';
  end;
  // bump map
  if (PageControl1.ActivePage = TabSheet7) and not ars[6] then
  begin
    if fIPDialogParams.BUMPMAP_Auto then
    begin
      BumpLeft := ImageEn1.IEBitmap.Width div 2;
      BumpTop := ImageEn1.IEBitmap.Height div 2;
      BumpWidth := imax(ImageEn1.IEBitmap.Width, ImageEn1.IEBitmap.Height) div 2;
      BumpHeight := BumpWidth;
    end
    else
    begin
      BumpLeft := fIPDialogParams.BUMPMAP_Left;
      BumpTop := fIPDialogParams.BUMPMAP_Top;
      BumpWidth := fIPDialogParams.BUMPMAP_Width;
      BumpHeight := fIPDialogParams.BUMPMAP_Height;
    end;
    BumpCol := fIPDialogParams.BUMPMAP_Col;
    BumpSrc := fIPDialogParams.BUMPMAP_Src;
    edit22.text := IntToStr(BumpLeft);
    edit23.text := IntToStr(BumpTop);
    edit24.text := IntToStr(BumpWidth);
    edit25.text := IntToStr(BumpHeight);
    edit26.text := IntToStr(BumpSrc);
    HsvBox2.SetRGB(BumpCol.R,BumpCol.G,BumpCol.B);
    ars[6] := true;
    undos[6]:='Bump Map';
  end;
  // Lens
  if (PageControl1.ActivePage = TabSheet8) and not ars[7] then
  begin
    if fIPDialogParams.LENS_Auto then
    begin
      LensLeft := ImageEn1.IEBitmap.Width div 2;
      LensTop := ImageEn1.IEBitmap.Height div 2;
      LensWidth := imax(ImageEn1.IEBitmap.Width, ImageEn1.IEBitmap.Height) div 2;
      LensHeight := LensWidth;
    end
    else
    begin
      LensLeft := fIPDialogParams.LENS_Left;
      LensTop := fIPDialogParams.LENS_Top;
      LensWidth := fIPDialogParams.LENS_Width;
      LensHeight := fIPDialogParams.LENS_Height;
    end;
    LensRef := fIPDialogParams.LENS_Ref;
    edit27.text := IntToStr(LensLeft);
    edit28.text := IntToStr(LensTop);
    edit29.text := IntToStr(LensWidth);
    edit30.text := IntToStr(LensHeight);
    edit31.text := IntToStr(trunc(LensRef * 10 - 10));
    ars[7] := true;
    undos[7]:='Lens effect';
  end;
  // Wave
  if (PageControl1.ActivePage = TabSheet9) and not ars[8] then
  begin
    WaveAmplitude := fIPDialogParams.WAVE_Amplitude;
    WaveWaveLength := fIPDialogParams.WAVE_WaveLength;
    WavePhase := fIPDialogParams.WAVE_Phase;
    WaveReflect := fIPDialogParams.WAVE_Reflect;
    edit32.text := IntToStr(WaveAmplitude);
    edit33.text := IntToStr(WaveWaveLength);
    edit34.text := IntToStr(WavePhase);
    checkbox2.checked := WaveReflect;
    ars[8] := true;
    undos[8]:='Wave effect';
  end;
  // Morph filters
  if (PageControl1.ActivePage = TabSheet10) and not ars[9] then
  begin
    MorphFilter := fIPDialogParams.MORPH_Filter;
    MorphWinSize := fIPDialogParams.MORPH_WinSize;
    ListBox2.ItemIndex := MorphFilter;
    Edit35.Text := IntToStr(MorphWinSize);
    ars[9] := true;
    undos[9]:='Morph';
  end;
  // Rotate
  if (PageControl1.ActivePage = TabSheet11) and not ars[10] then
  begin
    RotationAngle := fIPDialogParams.ROTATE_Angle;
    EditRotate.Text := floattostr(RotationAngle);
    TrackBarRotate.Position := trunc(RotationAngle*100);
    CheckBox3.Checked := false;
    CheckBox4.Checked := false;
    NeedToFlip := false;
    ars[10] := true;
    undos[10]:='Rotate';
  end;
  // initialize FFT
  if (PageControl1.ActivePage = TabSheet12) and not ars[11] then
  begin
    CheckBox1.Checked := fIPDialogParams.FFT_GrayScale;
    TIEFtImage.CalcSuitableSourceSize(ImageEn1.IEBitmap.Width, ImageEn1.IEBitmap.Height, w, h);
    TIEFtImage.CalcFFTImageSize(w, h, ww);
    ImageEnView1.Proc.ImageResize(ww, ww);
    if fIPDialogParams.FFT_Selection.Size>0 then
    begin
      fIPDialogParams.FFT_Selection.Position:=0;
      ImageEnView1.LoadSelectionFromStream(fIPDialogParams.FFT_Selection);
    end
    else if fIPDialogParams.FFT_Left>-1 then
      ImageEnView1.Select( fIPDialogParams.FFT_Left, fIPDialogParams.FFT_Top, fIPDialogParams.FFT_Right, fIPDialogParams.FFT_Bottom, iespReplace );
    ars[11] := true;
    undos[11]:='FFT';
  end;
  // initialize Gamma Correction
  if (PageControl1.ActivePage = tabGamma) and not ars[12] then
  begin
    trkGamma.Position := trunc(fIPDialogParams.GAMMACORRECTION_Value*10);
    trkGammaChange(nil);
    // Check all the gamma boxes
    for I := 0 to cbxGamma.items.count - 1 do
      cbxGamma.checked[i] := true;
    ars[12] := true;
    undos[12]:='Gamma Correction';
  end;
  // initialize Sharpen
  if (PageControl1.ActivePage = TabSheet14) and not ars[13] then
  begin
    Sharpen := fIPDialogParams.SHARPEN_Sharpen;
    SharpenSize := fIPDialogParams.SHARPEN_Size;
    edit36.text := IntToStr(Sharpen);
    edit37.text := IntToStr(SharpenSize);
    trackbar4.position := Sharpen;
    ars[13] := true;
    undos[13]:='Sharpen';
  end;
  //
  dochange := true;
end;



procedure TfPreviews.FormActivate(Sender: TObject);
var
  i:integer;
begin
  fResized:=false;
  OpList.Clear;
  doProgress := false;
  dochange := true;
  ResetParameters(true);  // reset all
  chkLockPreview.checked := DefaultLockPreview;
  PreviewButton.Enabled := not chkLockPreview.checked;
  PreviewButton.Visible := not chkLockPreview.checked;
  ResetButton.Visible := ShowReset;
  HistogramBox1.AttachedImageEnProc := ImageEn2.Proc;
  PageControl1.Visible := false;
  TabSheet1.TabVisible := (peAll in pe) or (peContrast in pe);
  TabSheet1.tag := 1;
  TabSheet2.TabVisible := (peAll in pe) or (peHSL in pe);
  TabSheet2.tag := 2;
  TabSheet3.TabVisible := (peAll in pe) or (peRGB in pe);
  TabSheet3.tag := 3;
  TabSheet4.TabVisible := (peAll in pe) or (peUserFilt in pe);
  TabSheet4.tag := 4;
  TabSheet5.TabVisible := (peAll in pe) or (peHSV in pe);
  TabSheet5.tag := 5;
  TabSheet6.TabVisible := (peAll in pe) or (peEqualize in pe);
  TabSheet6.tag := 6;
  TabSheet7.TabVisible := (peAll in pe) or (peBumpMap in pe);
  TabSheet7.tag := 7;
  TabSheet8.TabVisible := (peAll in pe) or (peLens in pe);
  TabSheet8.tag := 8;
  TabSheet9.TabVisible := (peAll in pe) or (peWave in pe);
  TabSheet9.tag := 9;
  TabSheet10.TabVisible := (peAll in pe) or (peMorph in pe);
  TabSheet10.tag := 10;
  TabSheet11.TabVisible := (peAll in pe) or (peRotate in pe);
  TabSheet11.tag := 11;
  TabSheet12.TabVisible := (peAll in pe) or (peFFT in pe);
  TabSheet12.tag := 12;
  TabGamma.TabVisible := (peAll in pe) or (peGamma in pe);
  TabGamma.tag := 13;
  TabSheet14.TabVisible := (peAll in pe) or (peSharpen in pe);
  TabSheet14.tag := 14;
  if InitialPage <> nil then
    PageControl1.ActivePage := InitialPage
  else
    PageControl1.ActivePage := PageControl1.FindNextPage(nil, true, true);
  PageControl1.Visible := true;

  imageen1.SetChessboardStyle(12,bsSolid);
  imageen2.SetChessboardStyle(12,bsSolid);
  // fit
  imageen1.Fit;
  // load filters
  ListBox1.Items.Clear;
  for i:=0 to IEGetFiltersCount-1 do
    ListBox1.Items.Add( string(IEGetFilterName(i)) );

  if assigned(application) then
    application.processmessages;
  PageControl1Change(self); // calls CopyOrg
end;


// applies current effect only
procedure TfPreviews.ApplyAct(im: TImageEnView);
var
  gamChannels: TIEChannels;
  v1: TIEProgressEvent;
  v2: TObject;
  xProgress: TProgressRec;
  xLeft, xTop, xWidth, xHeight, x1, x2: integer;
  xz: double;
  tmpft: TIEFtImage;
  tempmask:TIEMask;
begin
  if doProgress then
    xProgress := Progress
  else
    fillchar(xProgress, sizeof(xProgress), 0);
  CurrentOp:='';
  v1 := xProgress.fOnProgress;
  v2 := xProgress.Sender;
  if PageControl1.ActivePage = TabSheet1 then
  begin
    _ContrastRGB(im.IEBitmap, Contrast, mr, mg, mb, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
    _IntensityRGBall(im.IEBitmap, Brightness, Brightness, Brightness, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
    CurrentOp:='Contrast '+IntToStr(Contrast)+' Brightness '+IntToStr(Brightness);
  end;
  if PageControl1.ActivePage = TabSheet2 then
  begin
    _HSLvar(im.IEBitmap, Hue, Sat, Lum, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
    CurrentOp:='HSL '+IntToStr(Hue)+' '+IntToStr(Sat)+' '+IntToStr(Lum);
  end;
  if PageControl1.ActivePage = TabSheet3 then
  begin
    _IntensityRGBall(im.IEBitmap, red, green, blue, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
    CurrentOp:='RGB '+IntToStr(red)+' '+IntToStr(green)+' '+IntToStr(blue);
  end;
  if PageControl1.ActivePage = TabSheet4 then
  begin
    _ApplyFilter(im.IEBitmap, Filter, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, xProgress);
    CurrentOp:='Filter '+string(IEGraphFilterToString(Filter));
  end;
  if PageControl1.ActivePage = TabSheet5 then
  begin
    _HSVvar(im.IEBitmap, bHue, bSat, bVal, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
    CurrentOp:='HSV '+IntToStr(bHue)+' '+IntToStr(bSat)+' '+IntToStr(bVal);
  end;
  if PageControl1.ActivePage = TabSheet6 then
  begin
    IEApplyThreshold(im.IEBitmap, DownLimit, UpLimit, CreateRGB(0, 0, 0), CreateRGB(255, 255, 255), 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
    IEHistEqualize(im.IEBitmap, EDownLimit, EUpLimit, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
    CurrentOp:=string('Threshold '+IERGBToStr(DownLimit)+' '+IERGBToStr(UpLimit)+' HistEqualize '+IERGBToStr(EDownLimit)+' '+IERGBToStr(EUpLimit));
    if AutoEqualize then
    begin
      _HistAutoEqualize(im.IEBitmap, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
      CurrentOp:=CurrentOp+' (Equalize)';
    end;
  end;
  if PageControl1.ActivePage = TabSheet7 then
  begin
    if im <> ImageEn1 then
    begin
      xz := ImageEn1.Zoom / 100;
      xLeft := trunc(BumpLeft * xz - ImageEn1.ViewX);
      xTop := trunc(BumpTop * xz - ImageEn1.ViewY);
      xWidth := trunc(BumpWidth * xz);
      xHeight := trunc(BumpHeight * xz);
      _BumpMapping(im.IEBitmap, xLeft, xTop, xWidth, xHeight, BumpSrc, BumpCol, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, xProgress);
    end
    else
      _BumpMapping(im.IEBitmap, BumpLeft, BumpTop, BumpWidth, BumpHeight, BumpSrc, BumpCol, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, xProgress);
    CurrentOp:=string('Bumpmap '+IEIntToStr(BumpLeft)+' '+IEIntToStr(BumpTop)+' '+IEIntToStr(BumpWidth)+' '+IEIntToStr(BumpHeight)+' '+IEIntToStr(BumpSrc)+' '+IERGBToStr(BumpCol));
  end;
  if PageControl1.ActivePage = TabSheet8 then
  begin
    if im <> ImageEn1 then
    begin
      xz := ImageEn1.Zoom / 100;
      xLeft := trunc(LensLeft * xz - ImageEn1.ViewX);
      xTop := trunc(LensTop * xz - ImageEn1.ViewY);
      xWidth := trunc(LensWidth * xz);
      xHeight := trunc(LensHeight * xz);
      _Lens(im.IEBitmap, xLeft, xTop, xWidth, xHeight, LensRef, xProgress);
    end
    else
      _Lens(im.IEBitmap, LensLeft, LensTop, LensWidth, LensHeight, LensRef, xProgress);
    CurrentOp:='Lens '+IntToStr(LensLeft)+' '+IntToStr(LensTop)+' '+IntToStr(LensWidth)+' '+IntToStr(LensHeight)+' '+IEFloatToStrS(LensRef);
  end;
  if PageControl1.ActivePage = TabSheet9 then
  begin
    if im <> ImageEn1 then
    begin
      xz := ImageEn1.Zoom / 100;
      x1 := trunc(WaveAmplitude * xz);
      x2 := trunc(WaveWaveLength * xz);
      _Wave(im.IEBitmap, x1, x2, WavePhase, WaveReflect, xProgress);
    end
    else
      _Wave(im.IEBitmap, WaveAmplitude, WaveWaveLength, WavePhase, WaveReflect, xProgress);
    CurrentOp:=string('Wave '+IEIntToStr(WaveAmplitude)+' '+IEIntToStr(WaveWaveLength)+' '+IEIntToStr(WavePhase)+' '+IEIntToStr(integer(WaveReflect)));
  end;
  if PageControl1.ActivePage = TabSheet10 then
  begin
    _MorphFilter(im.IEBitmap, MorphWinSize, MorphFilter, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, v1, v2);
    CurrentOp:=string('Morph '+IEIntToStr(MorphWinSize)+' '+IEIntToStr(MorphFilter));
  end;
  if PageControl1.ActivePage = TabSheet11 then
  begin
    CurrentOp:='Rotate '+FloatToStr(RotationAngle);
    if CheckBox3.Checked then
    begin
      im.Proc.Flip(fdHorizontal);
      CurrentOp:=CurrentOp+' Flip Horizontal';
    end;
    if CheckBox4.Checked then
    begin
      im.Proc.Flip(fdVertical);
      CurrentOp:=CurrentOp+' Flip Vertical';
    end;
    if (RotationAngle <> 0) then
      im.Proc.Rotate(RotationAngle, true, ierFast, -1);
    NeedToFlip := false;
  end;
  if PageControl1.ActivePage = TabSheet12 then
  begin
    CurrentOp:='FFT ';
    if checkbox1.checked then
      CurrentOp:=CurrentOp+' GRAYSCALE '
    else
      CurrentOp:=CurrentOp+' RGB ';
    with ImageEnView1.SelectionMask do
      CurrentOp:=CurrentOp+string(' ('+IEIntToStr(X1)+','+IEIntToStr(Y1)+','+IEIntToStr(X2)+','+IEIntToStr(Y2)+')');
    if im <> ImageEn2 then
    begin
      // final image (full size) (2.3.2)
      FFTProgressPos := 0;
      if checkbox1.Checked then
        FTImage.BuildFT(im.IEBitmap, ieitGRAYSCALE)
      else
        FTImage.BuildFT(im.IEBitmap, ieitRGB);
      tempmask:=ImageEnView1.SelectionMask.CreateResampledMask(FTImage.ComplexWidth,FTImage.ComplexHeight);
      FTImage.ClearZone(tempmask);
      tempmask.free;
      FFTProgressPos := 0;
      im.Proc.FTConvertFrom(FTImage);
      ProgressBar1.Position := 0;
    end
    else
    begin
      // preview (2.3.2)
      FFTProgressPos := 0;
      tmpft := TIEFtImage.Create;
      tmpft.assign(FTImage);
      ImageEnView1.SaveSelection; // because the selection was removed by FTDisplayFrom
      FTImage.ClearZone(ImageEnView1.SelectionMask);
      ImageEnProc2.FTDisplayFrom(FTImage);
      ImageEnView1.Fit;
      ImageEnView1.RestoreSelection;
      FFTProgressPos := 0;
      ImageEn2.Proc.FTConvertFrom(FTImage);
      ProgressBar1.Position := 0;
      FTImage.assign(tmpft);
      FreeAndNil(tmpft);
    end;
  end;
  // Gamma Correction
  if PageControl1.ActivePage = TabGamma then
  begin
    CurrentOp:='GammaCorrection '+FloatToStr(trkGamma.position / 10)+' ';
    gamChannels := [];
    if cbxGamma.checked[0] then
    begin
      gamChannels := gamChannels + [iecRed];
      CurrentOp:=CurrentOp+'R';
    end;
    if cbxGamma.checked[1] then
    begin
      gamChannels := gamChannels + [iecGreen];
      CurrentOp:=CurrentOp+'G';
    end;
    if cbxGamma.checked[2] then
    begin
      gamChannels := gamChannels + [iecBlue];
      CurrentOp:=CurrentOp+'B';
    end;
    im.Proc.GammaCorrect(trkGamma.position / 10, gamChannels);
  end;
  // Sharpen
  if PageControl1.ActivePage = TabSheet14 then
  begin
    _Sharpen(im.IEBitmap, 0, 0, im.IEBitmap.Width, im.IEBitmap.Height, Sharpen, SharpenSize, v1, v2);
    CurrentOp:=string('Sharpen '+IEIntToStr(Sharpen)+' '+IEIntToStr(SharpenSize));
  end;

  UpdatePreviewZoom;
end;

procedure TfPreviews.UpdatePreviewZoom;
begin
  // pages that disables the zoom
  case PageControl1.ActivePage.tag of
    1, 2, 3, 4, 5, 6, 10, 13, 14:
      ImageEn1.MouseInteract := ImageEn1.MouseInteract + [miZoom];
  else
    begin
      ImageEn1.MouseInteract := ImageEn1.MouseInteract - [miZoom];
      ImageEn1.Fit;
    end;
  end;
end;

// copies original area to processed and applies current effect
procedure TfPreviews.CopyOrg;
var
  ie:TImageEnView;
  NewWidth, NewHeight: integer;
  xDst, yDst, dxDst, dyDst: integer;
  xSrc, ySrc, dxSrc, dySrc: integer;
begin
  ImageEn2.LockPaint;

  imageen2.IEBitmap.Width := imageen1.ExtentX;
  imageen2.IEbitmap.Height := imageen1.ExtentY;
  imageen1.GetRenderRectangles(xDst, yDst, dxDst, dyDst, xSrc, ySrc, dxSrc, dySrc);
  imageen1.IEBitmap.StretchRectTo( imageen2.iebitmap, 0,0,imageen2.iebitmap.width,imageen2.iebitmap.height, xSrc,ySrc,dxSrc,dySrc,rfNone,255 );
  imageen2.iebitmap.AlphaChannel.full:=imageen1.iebitmap.alphachannel.full;
  imageen2.Update;

  imageen2.Proc.SaveUndo(ieuImage);

  // FFT
  if not assigned(FTImage) then
  begin
    FTImage := TIEFtImage.Create;
    FTImage.OnProgress := ImageEnProc2.OnProgress;
  end;
  TIEFtImage.CalcSuitableSourceSize(ImageEn1.IEBitmap.Width, ImageEn1.IEBitmap.Height, NewWidth, NewHeight);

  if PageControl1.ActivePage = TabSheet12 then
  begin
    ie := TImageEnView.Create(nil);
    ie.LegacyBitmap := False;
    ImageEn1.Proc.ResampleTo(ie.IEBitmap, NewWidth, NewHeight, rfTriangle);
    FFTProgressPos := 0;
    if CheckBox1.Checked then
      FTImage.BuildFT(ie.IEBitmap, ieitGRAYSCALE)
    else
      FTImage.BuildFT(ie.IEBitmap, ieitRGB);
    ProgressBar1.Position := 0;
    ie.Free;
  end;

  ApplyAct(imageen2);
  ImageEn2.UnLockPaint;
  if PageControl1.ActivePage = TabSheet6 then
    HistogramBox1.Update;
end;



// Copies modified image to original (applies current effect to ImageEn1)
procedure TfPreviews.CopyModToOrg;
begin
  ApplyAct(imageen1);
  ImageEn1.Update;
  ImageEn1.Paint; // <- needed
  CopyOrg;
end;



// changes HSL  (trackbars 2/3/5)
procedure TfPreviews.TrackBar2Change(Sender: TObject);
begin
  if not dochange then
    exit;
  if (Hue <> trackbar2.position) or (Sat <> trackbar3.position) or (Lum <> trackbar5.position) then
  begin
    Hue := trackbar2.position;
    Sat := trackbar3.position;
    Lum := trackbar5.position;
    edit4.text := IntToStr(Hue);
    edit2.text := IntToStr(Sat);
    edit3.text := IntToStr(Lum);
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;


// changes HSL (edits 4/2/3)
procedure TfPreviews.Edit4Change(Sender: TObject);
var
  h, s, l: integer;
begin
  if not dochange then
    exit;
  h := StrToIntDef(edit4.text, 0);
  s := StrToIntDef(edit2.text, 0);
  l := StrToIntDef(edit3.text, 0);
  if (Hue <> h) or (Sat <> s) or (Lum <> l) then
  begin
    trackbar2.position := h;
    trackbar3.position := s;
    trackbar5.position := l;
    trackbar2change(self);
  end;
end;


// change effect (pagecontrol1)
procedure TfPreviews.PageControl1Change(Sender: TObject);
begin
  ResetParameters(false);
  UpdatePreviewZoom;
  CopyOrg;
end;


// Copies modified image to original (applies current effect to ImageEn1)
procedure TfPreviews.ResultToSourceButtonClick(Sender: TObject);
begin
  if CurrentOp<>'' then
    OpList.Add( CurrentOp );
  CopyModToOrg;
  ResetParameters(true);  // reset all
  CopyOrg;
  UndoCaption:=UndoCaption+undos[PageControl1.ActivePage.tag-1]+',';
end;


// changes zoom/view of ImageEn1 (original image)
procedure TfPreviews.ImageEn1ViewChange(Sender: TObject; Change: Integer);
begin
  CopyOrg;
end;


// changes RGB (trackbars6/7/8)
procedure TfPreviews.TrackBar6Change(Sender: TObject);
begin
  if not dochange then
    exit;
  if (red <> trackbar6.position) or (green <> trackbar7.position) or (blue <> trackbar8.position) then
  begin
    red := trackbar6.position;
    green := trackbar7.position;
    blue := trackbar8.position;
    edit7.text := IntToStr(red);
    edit6.text := IntToStr(green);
    edit5.text := IntToStr(blue);
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;


// changes RGB (edit7-6-5)
procedure TfPreviews.Edit7Change(Sender: TObject);
var
  rr, gg, bb: integer;
begin
  if not dochange then
    exit;
  rr := StrToIntDef(edit7.text, 0);
  gg := StrToIntDef(edit6.text, 0);
  bb := StrToIntDef(edit5.text, 0);
  if (red <> rr) or (green <> gg) or (blue <> bb) then
  begin
    trackbar6.position := rr;
    trackbar7.position := gg;
    trackbar8.position := bb;
    trackbar6change(self);
  end;
end;


// change filter values (edit8...16)
procedure TfPreviews.Edit8Change(Sender: TObject);
begin
  if domod then
  begin
    filter.Divisor := StrToIntDef(edit20.text, 1);
    with TEdit(sender) do
      filter.Values[(tag div 3), tag - (tag div 3) * 3] := StrToIntDef(text, 0);
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;


// Select value in the list box - preset filter values
procedure TfPreviews.ListBox1Click(Sender: TObject);
begin
  if not dochange then
    exit;
  filter := IEGetFilter( listbox1.itemindex )^;
  LoadFilt;
  if chkLockPreview.checked then
  begin
    imageen2.Proc.undo;
    ApplyAct(imageen2);
    imageen2.paint;
  end;
end;



procedure TfPreviews.LoadFilt;
begin
  domod := false;
  edit8.text  := IntToStr(filter.Values[0, 0]);
  edit9.text  := IntToStr(filter.Values[1, 0]);
  edit10.text := IntToStr(filter.Values[2, 0]);
  edit11.text := IntToStr(filter.Values[0, 1]);
  edit12.text := IntToStr(filter.Values[1, 1]);
  edit13.text := IntToStr(filter.Values[2, 1]);
  edit14.text := IntToStr(filter.Values[0, 2]);
  edit15.text := IntToStr(filter.Values[1, 2]);
  edit16.text := IntToStr(filter.Values[2, 2]);
  edit20.text := IntToStr(filter.divisor);
  domod := true;
end;

// applies current effect and close
procedure TfPreviews.OkButtonClick(Sender: TObject);
begin
  DoProgress := true;
  ApplyAct(imageen1);
  imageen1.Update;
  UndoCaption:=UndoCaption+undos[PageControl1.ActivePage.tag-1];
  GetIPParams;
  DefaultLockPreview:=chkLockPreview.checked;
  if CurrentOp<>'' then
    OpList.Add( CurrentOp );
end;


// load filter
procedure TfPreviews.Button4Click(Sender: TObject);
begin
  if OpenDialog1.execute then
  begin
    filter := LoadFilterFromFile(OpenDialog1.filename);
    LoadFilt;
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;


// save filter
procedure TfPreviews.Button5Click(Sender: TObject);
begin
  if SaveDialog1.execute then
    SaveFilterToFile(SaveDialog1.filename, Filter);
end;


// Channels
procedure TfPreviews.CheckListBox1Click(Sender: TObject);
begin
  if not dochange then
    exit;
  HistogramBox1.HistogramKind := [];
  if CheckListBox1.Checked[0] then
    HistogramBox1.HistogramKind := HistogramBox1.HistogramKind + [hkRed];
  if CheckListBox1.Checked[1] then
    HistogramBox1.HistogramKind := HistogramBox1.HistogramKind + [hkGreen];
  if CheckListBox1.Checked[2] then
    HistogramBox1.HistogramKind := HistogramBox1.HistogramKind + [hkBlue];
  if CheckListBox1.Checked[3] then
    HistogramBox1.HistogramKind := HistogramBox1.HistogramKind + [hkGray];
  RulerBox1.Left := HistogramBox1.HistogramXPos;
  RulerBox1.Width := HistogramBox1.Width - RulerBox1.Left;
end;


// Changes RulerBox1 position
procedure TfPreviews.RulerBox1RulerPosChange(Sender: TObject;
  Grip: Integer);
begin
  if not dochange then
    exit;
  // Update labels
  if RulerBox1.GripsPos[0] > RulerBox1.GripsPos[1] then
    if Grip = 0 then
      RulerBox1[1] := RulerBox1[0]
    else
      RulerBox1[0] := RulerBox1[1];
  if Grip = 0 then
    Label16.Caption := IntToStr(trunc(RulerBox1.GripsPos[0]))
  else if Grip = 1 then
    Label17.Caption := IntToStr(trunc(RulerBox1.GripsPos[1]));

  if (CheckListBox1.Checked[0]) or (CheckListBox1.Checked[3]) then
  begin
    // RED
    DownLimit.r := trunc(RulerBox1.GripsPos[0]);
    UpLimit.r := trunc(RulerBox1.GripsPos[1]);
  end;
  if (CheckListBox1.Checked[1]) or (CheckListBox1.Checked[3]) then
  begin
    // GREEN
    DownLimit.g := trunc(RulerBox1.GripsPos[0]);
    UpLimit.g := trunc(RulerBox1.GripsPos[1]);
  end;
  if (CheckListBox1.Checked[2]) or (CheckListBox1.Checked[3]) then
  begin
    // BLUE
    DownLimit.b := trunc(RulerBox1.GripsPos[0]);
    UpLimit.b := trunc(RulerBox1.GripsPos[1]);
  end;
  if chkLockPreview.checked then
  begin
    imageen2.Proc.undo;
    ApplyAct(imageen2);
    imageen2.paint;
  end;
end;



procedure TfPreviews.RulerBox2RulerPosChange(Sender: TObject;
  Grip: Integer);
begin
  if not dochange then
    exit;
  // Update labels
  if RulerBox2.GripsPos[0] > RulerBox2.GripsPos[1] then
    if Grip = 0 then
      RulerBox2[1] := RulerBox2[0]
    else
      RulerBox2[0] := RulerBox2[1];
  if Grip = 0 then
    Label20.Caption := IntToStr(trunc(RulerBox2.GripsPos[0]))
  else if Grip = 1 then
    Label21.Caption := IntToStr(trunc(RulerBox2.GripsPos[1]));

  if (CheckListBox1.Checked[0]) or (CheckListBox1.Checked[3]) then
  begin
    // RED
    EDownLimit.r := trunc(RulerBox2.GripsPos[0]);
    EUpLimit.r := trunc(RulerBox2.GripsPos[1]);
  end;
  if (CheckListBox1.Checked[1]) or (CheckListBox1.Checked[3]) then
  begin
    // GREEN
    EDownLimit.g := trunc(RulerBox2.GripsPos[0]);
    EUpLimit.g := trunc(RulerBox2.GripsPos[1]);
  end;
  if (CheckListBox1.Checked[2]) or (CheckListBox1.Checked[3]) then
  begin
    // BLUE
    EDownLimit.b := trunc(RulerBox2.GripsPos[0]);
    EUpLimit.b := trunc(RulerBox2.GripsPos[1]);
  end;
  if chkLockPreview.checked then
  begin
    imageen2.Proc.undo;
    ApplyAct(imageen2);
    imageen2.paint;
  end;
end;


// BUTTON - AUTOEQUALIZE
procedure TfPreviews.SpeedButton3Click(Sender: TObject);
begin
  AutoEqualize := SpeedButton3.Down;
  if chkLockPreview.checked then
  begin
    imageen2.Proc.undo;
    ApplyAct(imageen2);
    imageen2.paint;
  end;
end;

// change contrast (trackbar1) or brightness (trackbar12)
procedure TfPreviews.TrackBar1Change(Sender: TObject);
begin
  if not dochange then
    exit;
  if (Contrast <> trackbar1.position) or (Brightness <> trackbar12.position) then
  begin
    Contrast := trackbar1.position;
    edit1.text := IntToStr(Contrast);
    Brightness := trackbar12.position;
    edit21.text := IntToStr(Brightness);
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;

// change contrast (edit1) or brightness (edit21)
procedure TfPreviews.Edit1Change(Sender: TObject);
var
  v, b: integer;
begin
  if not dochange then
    exit;
  v := StrToIntDef(edit1.text, 0);
  b := StrToIntDef(edit21.text, 0);
  if (v <> Contrast) or (b <> Brightness) then
  begin
    trackbar1.position := v;
    trackbar12.position := b;
    trackbar1change(self);
  end;
end;


// Set language
procedure TfPreviews.SetLanguage(l: TMsgLanguage);
begin
  Font.Charset:=IELANGUAGECHARINFO[l].CharSet;
  Font.Name:=IELANGUAGECHARINFO[l].FontName;
  Caption := iemsg(IEMSG_PREVIEW, l);
  Label1.Caption := iemsg(IEMSG_SOURCE, l) + ':';
  Label2.Caption := iemsg(IEMSG_RESULT, l) + ':';
  OkButton.Caption := iemsg(IEMSG_OK, l);
  CancelButton.Caption := iemsg(IEMSG_CANCEL, l);
  chkLockPreview.Caption := iemsg(IEMSG_LOCKPREVIEW, l);
  chkLockPreview.Hint := iemsg(IEMSG_LOCKPREVIEWHINT, l);
  ResultToSourceButton.Hint := iemsg(IEMSG_COPYRESULTTOSOURCE, l);
  PreviewButton.Caption := iemsg(IEMSG_PREVIEW, l);
  ResetButton.Caption := iemsg(IEMSG_RESET, l);
  // Contrast
  TabSheet1.Caption := iemsg(IEMSG_CONTRAST, l);
  Label3.Caption := iemsg(IEMSG_CONTRAST, l);
  Label22.Caption := iemsg(IEMSG_BRIGHTNESS, l) + ':';
  // HSV
  TabSheet5.Caption := iemsg(IEMSG_HSV,l);
  // HSB
  Label10.Caption := iemsg(IEMSG_HUE, l) + ' (H):';
  Label11.Caption := iemsg(IEMSG_SATURATION, l) + ' (S):';
  Label12.Caption := iemsg(IEMSG_VALUE, l) + ' (V):';
  Label13.Caption := iemsg(IEMSG_BASECOLOR, l) + ':';
  Label14.Caption := iemsg(IEMSG_NEWCOLOR, l) + ':';
  // HSL
  TabSheet2.CAption := iemsg(IEMSG_HSL,l);
  Label4.Caption := iemsg(IEMSG_HUE, l) + ' (H):';
  Label5.Caption := iemsg(IEMSG_SATURATION, l) + ' (S):';
  Label6.Caption := iemsg(IEMSG_LUMINOSITY, l) + ' (L):';
  // RGB
  TabSheet3.Caption := iemsg(IEMSG_RGB,l);
  Label7.Caption := iemsg(IEMSG_RED, l) + ' (R):';
  Label8.Caption := iemsg(IEMSG_GREEN, l) + ' (G):';
  Label9.Caption := iemsg(IEMSG_BLUE, l) + ' (B):';
  // Filters
  TabSheet4.Caption := iemsg(IEMSG_USERFILTER, l);
  GroupBox1.Caption := ' ' + iemsg(IEMSG_FILTERVALUES, l) + ' ';
  GroupBox3.Caption := ' ' + iemsg(IEMSG_PRESETS, l) + ' ';
  Label15.Caption := iemsg(IEMSG_DIVISOR, l);
  Button4.Caption := iemsg(IEMSG_LOAD, l);
  Button5.Caption := iemsg(IEMSG_SAVE, l);
  SaveDialog1.Title := iemsg(IEMSG_SAVEFILTER, l);
  OpenDialog1.Title := iemsg(IEMSG_LOADFILTER, l);
  // Hist equalization
  TabSheet6.Caption := iemsg(IEMSG_EQUALIZATION, l);
  Label19.Caption := iemsg(IEMSG_EQUALIZATION, l);
  Label18.Caption := iemsg(IEMSG_THRESHOLD, l);
  SpeedButton3.Caption := iemsg(IEMSG_EQUALIZE, l);
  GroupBox4.Caption := ' ' + iemsg(IEMSG_HISTOGRAM, l) + ' ';
  // we have to clear before add, this avoid memory leak on some Delphi versions
  CheckListBox1.Items.Clear;
  CheckListBox1.Items.add(iemsg(IEMSG_RED, l));
  CheckListBox1.Items.add(iemsg(IEMSG_GREEN, l));
  CheckListBox1.Items.add(iemsg(IEMSG_BLUE, l));
  CheckListBox1.Items.add(iemsg(IEMSG_GRAY, l));
  // Bump map
  TabSheet7.Caption := iemsg(IEMSG_BUMPMAP, l);
  GroupBox2.Caption := ' ' + iemsg(IEMSG_LIGHT, l) + ' ';
  label27.Caption := iemsg(IEMSG_LEFT, l) + ':';
  label28.caption := iemsg(IEMSG_TOP, l) + ':';
  label23.caption := iemsg(IEMSG_WIDTH, l) + ':';
  label24.caption := iemsg(IEMSG_HEIGHT, l) + ':';
  label26.caption := iemsg(IEMSG_COLOR, l) + ':';
  label25.caption := iemsg(IEMSG_SOURCEIMAGEQUANTITY, l) + ' (%):';
  // Lens
  TabSheet8.Caption := iemsg(IEMSG_LENS, l);
  GroupBox5.Caption := ' ' + iemsg(IEMSG_LENS, l) + ' ';
  label32.Caption := iemsg(IEMSG_LEFT, l) + ':';
  label33.caption := iemsg(IEMSG_TOP, l) + ':';
  label29.caption := iemsg(IEMSG_WIDTH, l) + ':';
  label30.caption := iemsg(IEMSG_HEIGHT, l) + ':';
  label31.caption := iemsg(IEMSG_REFRACTION, l) + ':';
  // Wave
  TabSheet9.Caption := iemsg(IEMSG_WAVE, l);
  GroupBox6.Caption := ' ' + iemsg(IEMSG_WAVE, l) + ' ';
  label34.caption := iemsg(IEMSG_AMPLITUDE, l);
  label35.caption := iemsg(IEMSG_WAVELENGTH, l);
  label36.caption := iemsg(IEMSG_PHASE, l);
  checkbox2.Caption := iemsg(IEMSG_REFLECTIVE, l);
  // Morph filter
  TabSheet10.Caption := iemsg(IEMSG_MORPHFILTER, l);
  GroupBox7.Caption := ' ' + iemsg(IEMSG_MORPHFILTER, l) + ' ';
  Label37.Caption := iemsg(IEMSG_FILTER, l) + ':';
  Label38.Caption := iemsg(IEMSG_WINDOWSIZE, l) + ':';
  ListBox2.Clear;
  ListBox2.Items.Add(iemsg(IEMSG_MAXIMUM, l));
  ListBox2.Items.Add(iemsg(IEMSG_MINIMUM, l));
  ListBox2.Items.Add(iemsg(IEMSG_OPEN, l));
  ListBox2.Items.Add(iemsg(IEMSG_CLOSE, l));
  // Rotate
  TabSheet11.Caption := iemsg(IEMSG_ROTATE, l);
  LabelRotate.Caption := iemsg(IEMSG_ROTATE, l) + ':';
  Label46.Caption := ' '+iemsg(IEMSG_FLIP, l)+' ';
  CheckBox3.Caption := iemsg(IEMSG_FLIPHOR, l);
  CheckBox4.Caption := iemsg(IEMSG_FLIPVER, l);
  // FFT
  TabSheet12.Caption :=  iemsg(IEMSG_FFT,l);
  GroupBox8.Caption := ' ' + iemsg(IEMSG_SELECTTHEREGIONTOCLEAR, l) + ' ';
  Clear.Caption := iemsg(IEMSG_CLEAR, l);
  Button7.Caption := iemsg(IEMSG_RESET, l);
  CheckBox1.Caption := iemsg(IEMSG_GRAYSCALE, l);
  // gamma
  GroupBox9.Caption := ' '+iemsg(IEMSG_CHANNELS,l)+' ';
  tabGamma.Caption := iemsg(IEMSG_GAMMACORRECTION,l);
  label39.caption := iemsg(IEMSG_GAMMACORRECTION, l);
  cbxGamma.Items[0] := iemsg(IEMSG_RED, l);
  cbxGamma.Items[1] := iemsg(IEMSG_GREEN, l);
  cbxGamma.Items[2] := iemsg(IEMSG_BLUE, l);
  // sharpen
  TabSheet14.Caption := iemsg(IEMSG_SHARPEN,l);
  Label44.Caption := iemsg(IEMSG_AMPLITUDE, l);
  Label45.Caption := iemsg(IEMSG_WINDOWSIZE, l);
end;

// preview
procedure TfPreviews.PreviewButtonClick(Sender: TObject);
begin
  imageen2.Proc.undo;
  ApplyAct(imageen2);
  imageen2.paint;
end;

// preview-lock
procedure TfPreviews.SpeedButton1Click(Sender: TObject);
begin
  if chkLockPreview.checked then
  begin
    imageen2.Proc.undo;
    ApplyAct(imageen2);
    imageen2.paint;
  end;
  PreviewButton.Enabled := not chkLockPreview.checked; // enable/disable preview button
  PreviewButton.Visible := not chkLockPreview.checked; // enable/disable preview button
end;

// changes HSV (trackbar9-10-11)
procedure TfPreviews.TrackBar9Change(Sender: TObject);
begin
  if not dochange then
    exit;
  if (bHue <> trackbar9.position) or (bSat <> trackbar10.position) or (bVal <> trackbar11.position) then
  begin
    bHue := trackbar9.position;
    bSat := trackbar10.position;
    bVal := trackbar11.position;
    edit19.text := IntToStr(bHue);
    edit18.text := IntToStr(bSat);
    edit17.text := IntToStr(bVal);
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;

// changes HSV (edit19-18-17)
procedure TfPreviews.Edit19Change(Sender: TObject);
var
  h, s, v: integer;
begin
  if not dochange then
    exit;
  h := StrToIntDef(edit19.text, 0);
  s := StrToIntDef(edit18.text, 0);
  v := StrToIntDef(edit17.text, 0);
  if (bHue <> h) or (bSat <> s) or (bVal <> v) then
  begin
    trackbar9.position := h;
    trackbar10.position := s;
    trackbar11.position := v;
    trackbar2change(self);
  end;
end;

// changes HSVBox
// 3=org   1=dest
procedure TfPreviews.HSVBox3Change(Sender: TObject);
begin
  trackbar9.Position := HSVBox1.Hue - HSVBox3.Hue;
  trackbar10.Position := HSVBox1.Sat - HSVBox3.Sat;
  trackbar11.Position := HSVBox1.Val - HSVBox3.Val;
  TrackBar9Change(Self);
end;

// changes BumpLeft, BumpTop, BumpWidth, BumpHeight (edit22-25)
procedure TfPreviews.Edit22Change(Sender: TObject);
var
  bleft, btop, bwidth, bheight: integer;
  bsrc: integer;
begin
  if not dochange then
    exit;
  bleft   := StrToIntDef(edit22.text, 0);
  btop    := StrToIntDef(edit23.text, 0);
  bwidth  := StrToIntDef(edit24.text, 0);
  bheight := StrToIntDef(edit25.text, 0);
  bsrc    := StrToIntDef(edit26.text, 0);
  if (bleft <> BumpLeft) or (btop <> BumpTop) or (bwidth <> BumpWidth) or (bheight <> BumpHeight) or
    (bsrc <> BumpSrc) then
  begin
    BumpLeft := bleft;
    BumpTop := btop;
    BumpWidth := bwidth;
    BumpHeight := bheight;
    BumpSrc := bsrc;
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;


// Changes BumpCol (HSVBox2)
procedure TfPreviews.HSVBox2Change(Sender: TObject);
begin
  if not dochange then
    exit;
  BumpCol := CreateRGB(HSVBox2.Red, HSVBox2.Green, HSVBox2.Blue);
  if chkLockPreview.checked then
  begin
    imageen2.Proc.undo;
    ApplyAct(imageen2);
    imageen2.paint;
  end;
end;


// click on the image, read color if we are on HSV changing
// Moves light if we are in BumpMap
// Moves Lens if we are in Lens
procedure TfPreviews.ImageEn2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  h, s, v: integer;
  c: TColor;
  rgb: TRGB;
begin
  if (PageControl1.ActivePage = TabSheet5) and (Button = mbLeft) then
  begin
    // HSV
    c := imageen2.GetCanvas.pixels[x, y];
    rgb := TColor2TRGB(c);
    RGB2HSV(rgb, h, s, v);
    HSVBox3.Hue := h;
    HSVBox3.Sat := s;
    HSVBox3.Val := v;
  end;
  if PageControl1.ActivePage = TabSheet7 then
  begin
    // Bump map
    BumpLeft := trunc((X - ImageEn1.OffSetX) * (100 / ImageEn1.Zoom)) + ImageEn1.ViewX;
    BumpTop := trunc((Y - ImageEn1.OffSetY) * (100 / ImageEn1.zoom)) + ImageEn1.ViewY;
    dochange := false;
    edit22.text := IntToStr(BumpLeft);
    edit23.text := IntToStr(BumpTop);
    dochange := true;
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
  if PageControl1.ActivePage = TabSheet8 then
  begin
    // Lens
    LensLeft := trunc((X - ImageEn1.OffSetX) * (100 / ImageEn1.Zoom)) + ImageEn1.ViewX;
    LensTop := trunc((Y - ImageEn1.OffSetY) * (100 / ImageEn1.zoom)) + ImageEn1.ViewY;
    dochange := false;
    edit27.text := IntToStr(LensLeft);
    edit28.text := IntToStr(LensTop);
    dochange := true;
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;


// Changes Lens controls
procedure TfPreviews.Edit27Change(Sender: TObject);
var
  lleft, ltop, lwidth, lheight: integer;
  lref: double;
begin
  if not dochange then
    exit;
  lleft   := StrToIntDef(edit27.text, 0);
  ltop    := StrToIntDef(edit28.text, 0);
  lwidth  := StrToIntDef(edit29.text, 0);
  lheight := StrToIntDef(edit30.text, 0);
  lref    := StrToIntDef(edit31.text, 0) / 10 + 1;
  if (lleft <> LensLeft) or (ltop <> LensTop) or (lwidth <> LensWidth) or (lheight <> LensHeight) or
    (lref <> LensRef) then
  begin
    LensLeft := lleft;
    LensTop := ltop;
    LensWidth := lwidth;
    LensHeight := lheight;
    LensRef := lref;
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;


// Changes Wave controls
procedure TfPreviews.Edit32Change(Sender: TObject);
var
  lWaveAmplitude: integer;
  lWaveWaveLength: integer;
  lWavePhase: integer;
  lWaveReflect: boolean;
begin
  if not dochange then
    exit;
  lWaveAmplitude  := StrToIntDef(edit32.text, 0);
  lWaveWaveLength := StrToIntDef(edit33.text, 0);
  lWavePhase      := StrToIntDef(edit34.text, 0);
  lWaveReflect    := checkbox2.checked;
  if (lWaveAmplitude <> WaveAmplitude) or (lWaveWaveLength <> WaveWaveLength) or
    (lWavePhase <> WavePhase) or (lWaveReflect <> WaveReflect) then
  begin
    WaveAmplitude := lWaveAmplitude;
    WaveWaveLength := lWaveWaveLength;
    WavePhase := lWavePhase;
    WaveReflect := lWaveReflect;
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;

// changing controls for Morph filter
procedure TfPreviews.Edit35Change(Sender: TObject);
var
  lMorphFilter: integer;
  lMorphWinSize: integer;
begin
  if not dochange then
    exit;
  lMorphFilter  := ListBox2.ItemIndex;
  lMorphWinSize := StrToIntDef(edit35.text, 1);
  if (lMorphFilter <> MorphFilter) or (lMorphWinSize <> MorphWinSize) then
  begin
    MorphFilter := lMorphFilter;
    MorphWinSize := lMorphWinSize;
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;

// change rotate track bar
procedure TfPreviews.TrackBarRotateChange(Sender: TObject);
begin
  if not dochange then
    exit;
  if (TrackBarRotate.Position / 100) <> RotationAngle then
  begin
    RotationAngle := TrackBarRotate.Position / 100;
    EditRotate.Text := FloatToStr(RotationAngle);
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;

// change rotate edit
// 2.2.5
procedure TfPreviews.EditRotateChange(Sender: TObject);
var
  r: double;
begin
  if not dochange then
    exit;
  r := IEStrToFloatDefS(editRotate.text, 0);
  if (r <> RotationAngle) then
  begin
    trackbarRotate.position := trunc(r * 100);
    trackbarRotateChange(self);
  end;
end;

// flip hor/ver
procedure TfPreviews.SpeedButtonFlipHorClick(Sender: TObject);
begin
  if not dochange then
    exit;
  if chkLockPreview.checked then
  begin
    imageen2.Proc.undo;
    NeedToFlip := true;
    ApplyAct(imageen2);
    imageen2.paint;
  end;
end;

// Clear button (FFT)
procedure TfPreviews.ClearClick(Sender: TObject);
begin
  if not dochange then
    exit;
  imageen2.Proc.undo;
  ApplyAct(imageen2);
  imageen2.paint;
end;

// Reset (FFT)
procedure TfPreviews.Button7Click(Sender: TObject);
begin
  ImageEnView1.DeSelect;
  CopyOrg;
end;

// FFT progress
procedure TfPreviews.ImageEnProc2Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := FFTProgressPos + per;
end;

// FFT gray scale
procedure TfPreviews.CheckBox1Click(Sender: TObject);
begin
  CopyOrg;
end;

// Gamma Change Start
procedure TfPreviews.UpdatePreview;
begin
  if chkLockPreview.checked then
  begin
    imageen2.Proc.undo;
    ApplyAct(imageen2);
    imageen2.paint;
  end;
end;

// Gamma Change Start
procedure TfPreviews.trkGammaChange(Sender: TObject);
begin
  edtGamma.Text := FloatToStr(trkGamma.position / 10);
  DrawGammaGraph(trkGamma.position / 10);
  UpdatePreview;
end;

// Gamma Change Start
procedure TfPreviews.cbxGammaClick(Sender: TObject);
begin
  if not dochange then
    exit;
  DrawGammaGraph(trkGamma.position / 10);
  UpdatePreview;
end;

procedure TfPreviews.DrawGammaGraph(g: double);
var
  c, y, x, ww, hh: integer;
  iec:TIECanvas;
  poly:array [0..255] of TPoint;
begin
  ww := ImageEnView2.Width;
  hh := ImageEnView2.Height;
  ImageEnView2.IEBitmap.Width := ww;
  ImageEnView2.IEBitmap.Height := hh;
  ImageEnView2.IEBitmap.Fill($00D0D0D0);
  iec:=TIECanvas.Create(ImageEnView2.IEBitmap.Canvas,true,true);
  iec.Pen.Color := clBlack;
  iec.Pen.Style := psSolid;
  iec.Pen.width := 1;
  for c := 0 to 255 do
  begin
    y := ilimit(trunc((255 - blimit(Round(iepower(c / 255, 1 / g) * 255))) / 255 * hh), 0, hh - 1);
    x := ilimit(trunc(c / 255 * ww), 0, ww - 1);
    poly[c]:=Point(x,y);
  end;
  iec.Polyline(poly);
  iec.Free;
  ImageEnView2.Update;
end;

// Sharpen Amplitude or Sharpen window size
procedure TfPreviews.TrackBar4Change(Sender: TObject);
begin
  if not dochange then
    exit;
  if (Sharpen <> trackbar4.position) or (SharpenSize <> StrToIntDef(Edit37.Text, 2)) then
  begin
    Sharpen := trackbar4.position;
    edit36.text := IntToStr(Sharpen);
    SharpenSize := StrToIntDef(Edit37.Text, 2);
    if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
  end;
end;

procedure TfPreviews.Edit36Change(Sender: TObject);
begin
  if not dochange then
    exit;
  if Sharpen <> StrToIntDef(Edit36.Text, 1) then
  begin
    trackbar4.position := StrToIntDef(Edit36.Text, 1);
    trackbar4change(self);
  end;
end;

procedure TfPreviews.GetIPParams;
begin
  // contrast and brightness
  if ars[0] then
  begin
    fIPDialogParams.CONTRAST_Contrast:=Contrast;
    fIPDialogParams.CONTRAST_Brightness:=Brightness;
  end;
  // HSL
  if ars[1] then
  begin
    fIPDialogParams.HSL_H:=Hue;
    fIPDialogParams.HSL_S:=Sat;
    fIPDialogParams.HSL_L:=Lum;
  end;
  // rgb
  if ars[2] then
  begin
    fIPDialogParams.RGB_R:=red;
    fIPDialogParams.RGB_G:=green;
    fIPDialogParams.RGB_B:=blue;
  end;
  // user filter
  if ars[3] then
  begin
    fIPDialogParams.USERFILTER_Values:=Filter;
  end;
  // HSV
  if ars[4] then
  begin
    fIPDialogParams.HSV_H:=bHue;
    fIPDialogParams.HSV_S:=bSat;
    fIPDialogParams.HSV_V:=bVal;
  end;
  // threshold (histogram)
  if ars[5] then
  begin
    fIPDialogParams.EQUALIZATION_ThresholdDown:=DownLimit;
    fIPDialogParams.EQUALIZATION_ThresholdUp:=UpLimit;
    fIPDialogParams.EQUALIZATION_EqDown:=EDownLimit;
    fIPDialogParams.EQUALIZATION_EqUp:=EUpLimit;
    fIPDialogParams.EQUALIZATION_EqualizeButton:=AutoEqualize;
  end;
  // bump map
  if ars[6] then
  begin
    fIPDialogParams.BUMPMAP_Left:=BumpLeft;
    fIPDialogParams.BUMPMAP_Top:=BumpTop;
    fIPDialogParams.BUMPMAP_Width:=BumpWidth;
    fIPDialogParams.BUMPMAP_Height:=BumpHeight;
    fIPDialogParams.BUMPMAP_Col:=BumpCol;
    fIPDialogParams.BUMPMAP_Src:=BumpSrc;
  end;
  // Lens
  if ars[7] then
  begin
    fIPDialogParams.LENS_Left:=LensLeft;
    fIPDialogParams.LENS_Top:=LensTop;
    fIPDialogParams.LENS_Width:=LensWidth;
    fIPDialogParams.LENS_Height:=LensHeight;
    fIPDialogParams.LENS_Ref:=LensRef;
  end;
  // Wave
  if ars[8] then
  begin
    fIPDialogParams.WAVE_Amplitude:=WaveAmplitude;
    fIPDialogParams.WAVE_WaveLength:=WaveWaveLength;
    fIPDialogParams.WAVE_Phase:=WavePhase;
    fIPDialogParams.WAVE_Reflect:=WaveReflect;
  end;
  // Morph filters
  if ars[9] then
  begin
    fIPDialogParams.MORPH_Filter:=MorphFilter;
    fIPDialogParams.MORPH_WinSize:=MorphWinSize;
  end;
  // Rotate
  if ars[10] then
  begin
    fIPDialogParams.ROTATE_Angle:=RotationAngle;
  end;
  // FFT
  if ars[11] then
  begin
    fIPDialogParams.FFT_Selection.Clear;
    if ImageEnView1.Selected then
    begin
      fIPDialogParams.FFT_Left:=ImageEnView1.SelX1;
      fIPDialogParams.FFT_Top:=ImageEnView1.SelY1;
      fIPDialogParams.FFT_Right:=ImageEnView1.SelX2;
      fIPDialogParams.FFT_Bottom:=ImageEnView1.SelY2;
      ImageEnView1.SaveSelectionToStream( fIPDialogParams.FFT_Selection );
      ImageEnView1.Deselect;
    end
    else
    begin
      fIPDialogParams.FFT_Left:=-1;
      fIPDialogParams.FFT_Top:=-1;
      fIPDialogParams.FFT_Right:=-1;
      fIPDialogParams.FFT_Bottom:=-1;
    end;
    fIPDialogParams.FFT_GrayScale:=CheckBox1.Checked;
  end;
  // Gamma Correction
  if ars[12] then
  begin
    fIPDialogParams.GAMMACORRECTION_Value:=trkGamma.Position/10;
  end;
  // Sharpen
  if ars[13] then
  begin
    fIPDialogParams.SHARPEN_Sharpen:=Sharpen;
    fIPDialogParams.SHARPEN_Size:=SharpenSize;
  end;
end;

// Resize preview form
procedure TfPreviews.FormResize(Sender: TObject);
var
  ow,oh:integer;
  z:double;
  MinWidth,MinHeight:integer;
begin
  fResized:=true;
  z:=(PixelsPerInch/96);
  MinWidth:=trunc(536*z);
  MinHeight:=trunc(421*z);
  if Width<MinWidth then
    Width:=MinWidth;
  if Height<MinHeight then
    Height:=Minheight;
  ow:=trunc((ClientWidth+8-536*z)/2);
  oh:=trunc(ClientHeight+34-421*z);
  ImageEn1.Width := trunc(191*z+ow);
  ImageEn1.Height := trunc(135*z+oh);
  ImageEn2.Left := trunc(233*z+ow);
  ImageEn2.Width := ImageEn1.Width;
  ImageEn2.height := ImageEn1.Height;
  if not IEIsLeftMouseButtonPressed then
    ImageEn1.Fit;
  ResultToSourceButton.Left := trunc(206*z+ow);
  ResultToSourceButton.Top := trunc(70*z + oh div 2);
  Label2.left := trunc(231*z+ow);
  PageControl1.Top := trunc(ImageEn1.Top+ImageEn1.Height+10*z);
  PageControl1.Left := ImageEn1.Left;
  PageControl1.Width := trunc(ClientWidth-20*z);
  PageControl1.Height := trunc(ClientHeight-PageControl1.Top-chkLockPreview.Height-8);  // 3.0.3: "-8" good for Windows 2000 also
  OkButton.Left := ClientWidth-OkButton.Width-trunc(12*z);
  CancelButton.Left := OkButton.Left;
  PreviewButton.Left := OkButton.Left;
  ResetButton.Left := OkButton.Left;
  chkLockPreview.Top := Height-chkLockPreview.Height-trunc(35*z);

  // 2.2.7
  case iegDialogsBackground of
    iedbPaper:
      begin
        ImageEn1.BackgroundStyle:=iebsSoftShadow;
        ImageEn1.Background:=clWhite;
        ImageEn1.BorderStyle:=bsNone;
        ImageEn2.BackgroundStyle:=iebsSoftShadow;
        ImageEn2.Background:=clWhite;
        ImageEn2.BorderStyle:=bsNone;
        IECreateOSXBackgroundPaper(Image1.Picture.Bitmap,Image1.Width,Image1.Height);
        Image1.Update;
      end;
    iedbMetal:
      begin
        ImageEn1.BackgroundStyle:=iebsSoftShadow;
        ImageEn1.Background:=clSilver;
        ImageEn1.BorderStyle:=bsNone;
        ImageEn2.BackgroundStyle:=iebsSoftShadow;
        ImageEn2.Background:=clSilver;
        ImageEn2.BorderStyle:=bsNone;
        IECreateOSXBackgroundMetal(Image1.Picture.Bitmap,Image1.Width,Image1.Height);
        Image1.Update;
        chkLockPreview.Invalidate;
      end;
  end;
end;

// Reset button
procedure TfPreviews.ResetButtonClick(Sender: TObject);
begin
  if HardReset then
    fIPDialogParams.SetDefaultParams;
  if not ResetAllTabs then
    ars[ PageControl1.ActivePage.Tag-1 ] := false;
  ResetParameters(ResetAllTabs);
  imageen2.Proc.undo;
  ApplyAct(imageen2);
  imageen2.paint;
end;

procedure TfPreviews.WMEXITSIZEMOVE(var Message: TMessage);
begin
  if fResized then
    ImageEn1.Fit;
  fResized:=false;
end;


{$ELSE} // {$ifdef IEINCLUDEDIALOGIP}

interface
implementation

{$ENDIF}








end.
