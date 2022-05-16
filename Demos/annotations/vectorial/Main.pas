unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ToolWin, ComCtrls, ImageEnView, IEVect, ExtCtrls, ImageEnProc,
  ImageEnIO, Buttons, StdCtrls, ieview, IEOpenSaveDlg;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    ImageEnVect1: TImageEnVect;
    N1: TMenuItem;
    New: TMenuItem;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox2: TGroupBox;
    SpeedButton7: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton8: TSpeedButton;
    GroupBox3: TGroupBox;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    GroupBox4: TGroupBox;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton13: TSpeedButton;
    ColorDialog1: TColorDialog;
    Open1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Saveas1: TMenuItem;
    Import1: TMenuItem;
    DXF1: TMenuItem;
    Label13: TLabel;
    Tools1: TMenuItem;
    Openbackgroundimage1: TMenuItem;
    Adjustcolor1: TMenuItem;
    Effects1: TMenuItem;
    Grayforce1: TMenuItem;
    Edit5: TMenuItem;
    Undo1: TMenuItem;
    N2: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    Pasteinrect1: TMenuItem;
    Deleteobject1: TMenuItem;
    SpeedButton14: TSpeedButton;
    FontDialog1: TFontDialog;
    OpenDialog1: TOpenDialog;
    ScrollBox1: TScrollBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    ComboBox4: TComboBox;
    Edit2: TEdit;
    UpDown2: TUpDown;
    ComboBox3: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label10: TLabel;
    Label11: TLabel;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    Panel5: TPanel;
    ImageEnView1: TImageEnView;
    TabSheet3: TTabSheet;
    Label17: TLabel;
    Label18: TLabel;
    Button3: TButton;
    Edit6: TEdit;
    UpDown4: TUpDown;
    ComboBox7: TComboBox;
    Button4: TButton;
    GroupBox6: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit3: TEdit;
    UpDown1: TUpDown;
    Edit4: TEdit;
    UpDown3: TUpDown;
    GroupBox7: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    ComboBox1: TComboBox;
    Label14: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    Copyobjectstobackground1: TMenuItem;
    Objectscount1: TMenuItem;
    Editobjects1: TMenuItem;
    N3: TMenuItem;
    Fitbitmaptoobjects1: TMenuItem;
    N4: TMenuItem;
    Selectall1: TMenuItem;
    SpeedButton17: TSpeedButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    Copy2: TMenuItem;
    Cut2: TMenuItem;
    Paste2: TMenuItem;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    CheckBox5: TCheckBox;
    Label19: TLabel;
    Edit7: TEdit;
    UpDown5: TUpDown;
    SpeedButton20: TSpeedButton;
    N5: TMenuItem;
    Undo2: TMenuItem;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    SpeedButton21: TSpeedButton;
    procedure Exit1Click(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure ImageEnVect1SelectObject(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure DXF1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ImageEnVect1ViewChange(Sender: TObject; Change: Integer);
    procedure Openbackgroundimage1Click(Sender: TObject);
    procedure Adjustcolor1Click(Sender: TObject);
    procedure Effects1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Grayforce1Click(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Pasteinrect1Click(Sender: TObject);
    procedure Deleteobject1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ImageEnVect1MeasureHint(Sender: TObject; var Text: string;
      Value: Double);
    procedure SpeedButton16Click(Sender: TObject);
    procedure Copyobjectstobackground1Click(Sender: TObject);
    procedure Objectscount1Click(Sender: TObject);
    procedure Fitbitmaptoobjects1Click(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure Cut2Click(Sender: TObject);
    procedure Paste2Click(Sender: TObject);
    procedure Undo2Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
  private
    { Private declarations }
    ctrlch: boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses giflzw, tiflzw, UGrayForce, hyieutils;

{$R *.DFM}

// File->Exit

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File->New

procedure TMainForm.NewClick(Sender: TObject);
begin
  ImageEnVect1.Proc.Clear;
  ImageEnVect1.RemoveAllObjects;
end;

// Speedbuttons click (Zoom,Selection,Measures,Objects)

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  with ImageEnVect1 do
  begin
    // SET MouseInteract and MouseInteractVt
    // Zoom
    if (Sender = SpeedButton1) and SpeedButton1.Down then
      MouseInteract := MouseInteract + [miZoom];
    if (Sender = SpeedButton4) and SpeedButton4.Down then
      MouseInteract := MouseInteract + [miSelectZoom];
    if (Sender = SpeedButton8) and SpeedButton8.Down then
      MouseInteract := MouseInteract + [miScroll];
    // Selection
    if (Sender = SpeedButton13) and SpeedButton13.Down then
      MouseInteractVt := MouseInteractVt + [miObjectSelect];
    if (Sender = SpeedButton7) and SpeedButton7.Down then
      MouseInteract := MouseInteract + [miSelect];
    if (Sender = SpeedButton11) and SpeedButton11.Down then
      MouseInteract := MouseInteract + [miSelectPolygon];
    if (Sender = SpeedButton12) and SpeedButton12.Down then
      MouseInteract := MouseInteract + [miSelectCircle];
    // Measures
    if (Sender = SpeedButton2) and SpeedButton2.Down then
      MouseInteractVt := MouseInteractVt + [miArea];
    if (Sender = SpeedButton3) and SpeedButton3.Down then
      MouseInteractVt := MouseInteractVt + [miLineLen];
    if (Sender = SpeedButton15) and SpeedButton15.Down then
      MouseInteractVt := MouseInteractVt + [miDragLen];
    // Insert objects
    if (Sender = SpeedButton5) and SpeedButton5.Down then
      MouseInteractVt := MouseInteractVt + [miPutLine];
    if (Sender = SpeedButton6) and SpeedButton6.Down then
      MouseInteractVt := MouseInteractVt + [miPutBox];
    if (Sender = SpeedButton9) and SpeedButton9.Down then
      MouseInteractVt := MouseInteractVt + [miPutEllipse];
    if (Sender = SpeedButton10) and SpeedButton10.Down then
      MouseInteractVt := MouseInteractVt + [miPutBitmap];
    if (Sender = SpeedButton14) and (SpeedButton14.Down) then
      MouseInteractVt := MouseInteractVt + [miPutText];
    if (Sender = SpeedButton17) and (SpeedButton17.Down) then
      MouseInteractVt := MouseInteractVt + [miPutRuler];
    if (Sender = SpeedButton18) and (SpeedButton18.Down) then
      MouseInteractVt := MouseInteractVt + [miPutPolyline];
    if (Sender = SpeedButton19) and (SpeedButton19.Down) then
      MouseInteractVt := MouseInteractVt + [miPutAngle];
    if (Sender = SpeedButton20) and (SpeedButton20.Down) then
      MouseInteractVt := MouseInteractVt + [miPutMemo];
    if (Sender = SpeedButton21) and (SpeedButton21.Down) then
      MouseInteractVt := MouseInteractVt + [miEditPolyline];
    // SET Buttons (feedback)
    SpeedButton1.Down := miZoom in MouseInteract;
    SpeedButton4.Down := miSelectZoom in MouseInteract;
    SpeedButton8.Down := miScroll in MouseInteract;
    SpeedButton13.Down := miObjectSelect in MouseInteractVt;
    SpeedButton7.Down := miSelect in MouseInteract;
    SpeedButton11.Down := miSelectPolygon in MouseInteract;
    SpeedButton12.Down := miSelectCircle in MouseInteract;
    SpeedButton2.Down := miArea in MouseInteractVt;
    SpeedButton3.Down := miLineLen in MouseInteractVt;
    SpeedButton5.Down := miPutLine in MouseInteractVt;
    SpeedButton6.Down := miPutBox in MouseInteractVt;
    SpeedButton9.Down := miPutEllipse in MouseInteractVt;
    SpeedButton10.Down := miPutBitmap in MouseInteractVt;
    SpeedButton14.Down := miPutText in MouseInteractVt;
    SpeedButton15.Down := miDragLen in MouseInteractVt;
    SpeedButton17.Down := miPutRuler in MouseInteractVt;
    SpeedButton18.Down := miPutPolyline in MouseInteractVt;
    SpeedButton19.Down := miPutAngle in MouseInteractVt;
    SpeedButton20.Down := miPutMemo in MouseInteractVt;
    SpeedButton21.Down := miEditPolyline in MouseInteractVt;
    // Cancel selection
    if not (miSelect in MouseInteract) and not (miSelectPolygon in Mouseinteract)
      and not (miSelectCircle in MouseInteract) then
      Deselect;
  end;
end;

//

procedure TMainForm.FormActivate(Sender: TObject);
begin
  ctrlch := false;
  ComboBox3.ItemIndex := 1;
  ComboBox4.ItemIndex := 0;
  ComboBox5.ItemIndex := 0;
  ComboBox6.ItemIndex := 0;
  ComboBox7.ItemIndex := 0;
  ComboBox4Change(self);
  ComboBox2.ItemIndex := 4;
  ComboBox2Change(self);
  checkbox1.checked := true;
  checkbox2.checked := true;
  checkbox3.checked := true;
  checkbox4.checked := true;

  ImageEnVect1.SelColor1 := clWhite;
  ImageEnVect1.SelColor2 := clRed;
  ImageEnVect1.MeasureTrack := true;
  ImageEnVect1.UseCentralGrip := false;
  ImageEnVect1.ObjAutoUndo := true;

  ImageEnVect1.Proc.ImageResize(526, 543, iehLeft, ievTop);
  ImageEnVect1.Proc.Fill(clWhite);

  ImageEnView1.IEBitmap.Assign(ImageEnVect1.ObjBitmap[-1]);
  ImageEnView1.Update;
  ImageEnView1.Fit;
end;

// Object properties (controls change)

procedure TMainForm.ComboBox4Change(Sender: TObject);
const
  BS: array[-1..7] of TBrushStyle = (bsSolid, bsSolid, bsClear, bsBDiagonal, bsFDiagonal, bsCross, bsDiagCross, bsHorizontal, bsVertical);
  PS: array[-1..6] of TPenStyle = (psSolid, psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear, psInsideFrame);
  SH: array[-1..2] of TIEShape = (iesNONE, iesNONE, iesINARROW, iesOUTARROW);
  TA: array[-1..3] of TIEAlignment = (iejLeft, iejLeft, iejRight, iejCenter, iejJustify);
var
  q, obj: integer;
  xstyle: TIEVStyle;
begin
  if ctrlch then
    exit;
  obj := -1; // -1 is next object (new object to insert)
  with ImageEnvect1 do
    for q := -1 to SelObjectsCount - 1 do
    begin
      if q >= 0 then
        obj := SelObjects[q];
      ObjMemoCharsBrushStyle[obj] := bsClear;
      SetObjFont(obj, FontDialog1.Font);
      ObjPenColor[obj] := panel3.color;
      ObjBrushColor[obj] := panel4.color;
      ObjBrushStyle[obj] := BS[combobox3.itemindex];
      ObjPenStyle[obj] := PS[combobox4.itemindex];
      ObjPenWidth[obj] := strtointdef(edit2.text, 1);
      ObjBeginShape[obj] := SH[combobox5.itemindex];
      ObjEndShape[obj] := SH[combobox6.itemindex];
      ObjFontAngle[obj] := updown4.position;
      ObjTextAlign[obj] := TA[combobox7.itemindex];
      xstyle := [];
      if checkbox1.checked then
        xstyle := xstyle + [ievsVisible];
      if checkbox4.checked then
        xstyle := xstyle + [ievsSelectable];
      if checkbox2.checked then
        xstyle := xstyle + [ievsMoveable];
      if checkbox3.checked then
        xstyle := xstyle + [ievsSizeable];
      ObjStyle[obj] := xstyle;
      ObjTextAutoSize[obj] := true;
      // shadow
      ObjSoftShadow[obj].Enabled := checkbox5.checked;
      // transparency
      ObjTransparency[obj] := strtointdef(Edit7.Text, 255);
      // memo multifont
      ObjFontLocked[obj] := not checkbox6.checked;
    end;
end;

// Pen color

procedure TMainForm.Panel3Click(Sender: TObject);
begin
  ColorDialog1.Color := Panel3.Color;
  if ColorDialog1.Execute then
    Panel3.Color := ColorDialog1.Color;
  ComboBox4Change(self);
end;

// Brush color

procedure TMainForm.Panel4Click(Sender: TObject);
begin
  ColorDialog1.Color := Panel4.Color;
  if ColorDialog1.Execute then
    Panel4.Color := ColorDialog1.Color;
  ComboBox4Change(self);
end;

// Object (or multi-object) selection

procedure TMainForm.ImageEnVect1SelectObject(Sender: TObject);
var
  q, obj: integer;
begin
  // load properties to "Object properties"
  ctrlch := true;
  obj := -1; // -1 is next object (new object to insert)
  with ImageEnVect1 do
    for q := -1 to SelObjectsCount - 1 do
    begin
      if q >= 0 then
        obj := SelObjects[q];
      panel3.color := ObjPenColor[obj];
      panel4.color := ObjBrushColor[obj];
      edit2.text := inttostr(ObjPenWidth[obj]);
      combobox3.itemindex := ord(ObjBrushStyle[obj]);
      combobox4.itemindex := ord(ObjPenStyle[obj]);
      combobox5.itemindex := ord(ObjBeginShape[obj]);
      combobox6.itemindex := ord(ObjEndShape[obj]);
      with FontDialog1 do
      begin
        Font.Name := ObjFontName[obj];
        Font.Height := ObjFontHeight[obj];
        Font.Style := ObjFontStyles[obj];
      end;
      updown4.position := trunc(ObjFontAngle[obj]);
      combobox7.itemindex := ord(ObjTextAlign[obj]);
      checkbox1.checked := ievsVisible in ObjStyle[obj];
      checkbox4.checked := ievsSelectable in ObjStyle[obj];
      checkbox2.checked := ievsMoveable in ObjStyle[obj];
      checkbox3.checked := ievsSizeable in ObjStyle[obj];
      checkbox5.checked := ObjSoftShadow[obj].Enabled;
      Edit7.text := inttostr(ObjTransparency[obj]);
      checkbox6.checked := not ObjFontLocked[obj];
    end;
  ctrlch := false;
end;

// Measures unit / Scale / Digits / Precision

procedure TMainForm.ComboBox2Change(Sender: TObject);
begin
  with ImageEnVect1 do
  begin
    MUnit := TIEUnits(ComboBox2.ItemIndex);
    try
      ScaleFactor := StrToFloat(Edit1.text);
    except
    end;
    FloatDigits := StrToIntDef(Edit3.text, 2);
    FloatPrecision := StrToIntDef(Edit4.text, 15);
  end;
end;

// File->Open

procedure TMainForm.Open1Click(Sender: TObject);
begin
  OpenDialog1.Filter := 'ImageEn Objects|*.IEV';
  OpenDialog1.DefaultExt := 'IEV';
  if OpenDialog1.Execute then
    ImageEnVect1.LoadFromFileIEV(OpenDialog1.FileName);
end;

// File->SaveAs

procedure TMainForm.Saveas1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    ImageEnVect1.SaveToFileIEV(SaveDialog1.FileName);
end;

// File->Import->DXF

procedure TMainForm.DXF1Click(Sender: TObject);
begin
  OpenDialog1.Filter := 'AutoCAD DXF|*.DXF';
  OpenDialog1.DefaultExt := 'DXF';
  if OpenDialog1.Execute then
    ImageEnVect1.ImportDXF(OpenDialog1.FileName);
end;

// properties- zoom

procedure TMainForm.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.Text = 'Fit' then
    ImageEnVect1.Fit
  else
    ImageEnVect1.Zoom := StrToIntDef(ComboBox1.Text, 100);
end;

//

procedure TMainForm.ImageEnVect1ViewChange(Sender: TObject;
  Change: Integer);
begin
  if Change = 0 then
    ComboBox1.Text := IntToStr(trunc(ImageEnVect1.Zoom));
end;

// Tools->OpenBackgroundImage

procedure TMainForm.Openbackgroundimage1Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
    ImageEnVect1.IO.LoadFromFile(OpenImageEnDialog1.FileName);
end;

// Tools->AdjustColor

procedure TMainForm.Adjustcolor1Click(Sender: TObject);
begin
  ImageEnVect1.Proc.DoPreviews(ppeColorAdjust);
end;

// Tools->Effetcs

procedure TMainForm.Effects1Click(Sender: TObject);
begin
  ImageEnVect1.Proc.DoPreviews(ppeEffects);
end;

// Set image

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
  begin
    ImageEnVect1.SetObjBitmapFromFile(-1, OpenImageEnDialog1.FileName);
    ImageEnView1.IEBitmap.Assign(ImageEnVect1.ObjBitmap[-1]);
    ImageenView1.Update;
    ImageEnView1.Fit;
  end;
end;

// Adjust image

procedure TMainForm.Button2Click(Sender: TObject);
var
  q: integer;
  tempProc:TImageEnProc;
begin
  // find first iekBITMAP object
  with ImageEnVect1 do
    for q := 0 to SelObjectsCount - 1 do
      if ObjKind[SelObjects[q]] = iekBITMAP then
      begin
        tempProc:=TImageEnProc.Create(nil);
        tempProc.AttachedIEBitmap := ObjBitmap[SelObjects[q]];
        tempProc.DoPreviews([peAll]);
        tempProc.Free;
        Update;
        exit;
      end;
end;

// Tools->Gray force

procedure TMainForm.Grayforce1Click(Sender: TObject);
begin
  with GrayForce do
    if ShowModal = mrOK then
      ImageEnVect1.Proc.CastColorRange(IEGradientBar1.RGB, IEGradientBar2.RGB, TColor2TRGB(HSVBox1.Color));
end;

// Edit->Undo

procedure TMainForm.Undo1Click(Sender: TObject);
begin
  ImageEnVect1.Proc.Undo;
end;

// Edit->Copy

procedure TMainForm.Copy1Click(Sender: TObject);
begin
  ImageEnVect1.Proc.SelCopyToClip;
end;

// Edit->Cut

procedure TMainForm.Cut1Click(Sender: TObject);
begin
  ImageEnVect1.Proc.SelCutToClip;
end;

// Edit->Paste

procedure TMainForm.Paste1Click(Sender: TObject);
begin
  ImageEnVect1.Proc.PasteFromClipboard;
end;

// Edit->PasteInRect

procedure TMainForm.Pasteinrect1Click(Sender: TObject);
begin
  ImageEnVect1.Proc.SelPasteFromClipStretch;
end;

// Delete object

procedure TMainForm.Deleteobject1Click(Sender: TObject);
begin
  while imageenvect1.SelObjectsCount > 0 do
    imageenvect1.RemoveObject(imageenvect1.selobjects[0]);
end;

// Set Font

procedure TMainForm.Button3Click(Sender: TObject);
begin
  if FontDialog1.Execute then
    ComboBox4Change(self);
end;

// Stretch

procedure TMainForm.Button4Click(Sender: TObject);
begin
  FontDialog1.Font.Height := 0;
  ComboBox4Change(self);
end;

//

procedure TMainForm.ImageEnVect1MeasureHint(Sender: TObject;
  var Text: string; Value: Double);
begin
  statusbar1.SimpleText := Text;
end;

// hide objects

procedure TMainForm.SpeedButton16Click(Sender: TObject);
begin
  ImageEnVect1.AllObjectsHidden := SpeedButton16.Down;
end;

// Copy objects to background

procedure TMainForm.Copyobjectstobackground1Click(Sender: TObject);
begin
  ImageEnVect1.CopyObjectsToBack(true);
end;

// Objects count

procedure TMainForm.Objectscount1Click(Sender: TObject);
begin
  ShowMessage('Objects count = ' + IntTostr(ImageEnVect1.ObjectsCount));
end;

// Fit bitmap to objects

procedure TMainForm.Fitbitmaptoobjects1Click(Sender: TObject);
var
  rc: TRect;
begin
  rc := ImageEnVect1.ObjectsExtents;
  ImageEnVect1.Bitmap.Width := rc.Right;
  ImageEnVect1.Bitmap.Height := rc.Bottom;
  ImageEnVect1.Update;
end;

// Select all objects

procedure TMainForm.Selectall1Click(Sender: TObject);
begin
  ImageEnVect1.SelAllObjects;
end;

procedure TMainForm.Copy2Click(Sender: TObject);
begin
  ImageEnVect1.ObjCopyToClipboard;
end;

procedure TMainForm.Cut2Click(Sender: TObject);
begin
  ImageEnVect1.ObjCutToClipboard;
end;

procedure TMainForm.Paste2Click(Sender: TObject);
begin
  ImageEnVect1.ObjPasteFromClipboard(5, 5);
end;

// Edit Objects | Undo

procedure TMainForm.Undo2Click(Sender: TObject);
begin
  ImageEnVect1.ObjUndo;
  ImageEnVect1.ObjClearUndo;
end;

// Antialiasing checkbox

procedure TMainForm.CheckBox7Click(Sender: TObject);
begin
  ImageEnVect1.ObjAntialias := CheckBox7.Checked;
end;


end.
