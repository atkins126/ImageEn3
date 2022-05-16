unit Main;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, ToolWin, ImageEnProc,
  ImageEnView, ImageEnIO, hyiedefs, IEOpenSaveDlg, XPMan;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    SpeedPanel: TPanel;
    OpenBtn: TSpeedButton;
    SaveBtn: TSpeedButton;
    CutBtn: TSpeedButton;
    CopyBtn: TSpeedButton;
    PasteBtn: TSpeedButton;
    StatusBar: TStatusBar;
    SpeedButton1: TSpeedButton;
    PastetoRect1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Unselect1: TMenuItem;
    N3: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    PasteRect1: TMenuItem;
    Bevel1: TBevel;
    TrackBar1: TTrackBar;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Tools1: TMenuItem;
    Effects1: TMenuItem;
    Background1: TMenuItem;
    SpeedButton2: TSpeedButton;
    N2: TMenuItem;
    Negative1: TMenuItem;
    Grayscale1: TMenuItem;
    Rotate1: TMenuItem;
    N5: TMenuItem;
    Horizontalflip1: TMenuItem;
    Verticalflip1: TMenuItem;
    N6: TMenuItem;
    Undo1: TMenuItem;
    Image1: TMenuItem;
    N4: TMenuItem;
    N7: TMenuItem;
    Resize1: TMenuItem;
    Resample1: TMenuItem;
    Clear1: TMenuItem;
    SpeedButton3: TSpeedButton;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    Merge1: TMenuItem;
    ColorAdjust1: TMenuItem;
    Histogram1: TMenuItem;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    N8: TMenuItem;
    Selectscanner1: TMenuItem;
    Acquire1: TMenuItem;
    Calccolornumber1: TMenuItem;
    Reducecolors1: TMenuItem;
    GetHSVchannels1: TMenuItem;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    ConverttoBW1: TMenuItem;
    N9: TMenuItem;
    Zoomproperties1: TMenuItem;
    ConverttoTruecolor1: TMenuItem;
    N10: TMenuItem;
    Crop1: TMenuItem;
    Hiddentext1: TMenuItem;
    OpenImageEnDialog1: TOpenImageEnDialog;
    SaveImageEnDialog1: TSaveImageEnDialog;
    GetRGBchannels1: TMenuItem;
    SpeedButton10: TSpeedButton;
    N11: TMenuItem;
    Printersetup1: TMenuItem;
    Print1: TMenuItem;
    PrintDialog1: TPrintDialog;
    Bevel4: TBevel;
    AlphaChannelPanel: TPanel;
    TrackBar2: TTrackBar;
    Bevel2: TBevel;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Bevel3: TBevel;
    PrintPreview1: TMenuItem;
    SpeedButton12: TSpeedButton;
    CheckBox1: TCheckBox;
    Edgedetection1: TMenuItem;
    SpeedButton11: TSpeedButton;
    SpeedButton13: TSpeedButton;
    RemoveRedEyes1: TMenuItem;
    XPManifest1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure FileNewItemClick(Sender: TObject);
    procedure WindowCascadeItemClick(Sender: TObject);
    procedure UpdateMenuItems(Sender: TObject);
    procedure WindowTileItemClick(Sender: TObject);
    procedure WindowArrangeItemClick(Sender: TObject);
    procedure FileCloseItemClick(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure FileSaveItemClick(Sender: TObject);
    procedure FileSaveAsItemClick(Sender: TObject);
    procedure CutItemClick(Sender: TObject);
    procedure CopyItemClick(Sender: TObject);
    procedure PasteItemClick(Sender: TObject);
    procedure WindowMinimizeItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpAboutItemClick(Sender: TObject);
    procedure PastetoRect1Click(Sender: TObject);
    procedure Unselect1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Effects1Click(Sender: TObject);
    procedure Background1Click(Sender: TObject);
    procedure Negative1Click(Sender: TObject);
    procedure Grayscale1Click(Sender: TObject);
    procedure Rotate1Click(Sender: TObject);
    procedure Verticalflip1Click(Sender: TObject);
    procedure Horizontalflip1Click(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Resize1Click(Sender: TObject);
    procedure Resample1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Merge1Click(Sender: TObject);
    procedure ColorAdjust1Click(Sender: TObject);
    procedure Histogram1Click(Sender: TObject);
    procedure Selectscanner1Click(Sender: TObject);
    procedure Acquire1Click(Sender: TObject);
    procedure Calccolornumber1Click(Sender: TObject);
    procedure Reducecolors1Click(Sender: TObject);
    procedure GetHSVchannels1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ConverttoBW1Click(Sender: TObject);
    procedure Zoomproperties1Click(Sender: TObject);
    procedure ConverttoTruecolor1Click(Sender: TObject);
    procedure Crop1Click(Sender: TObject);
    procedure Hiddentext1Click(Sender: TObject);
    procedure GetRGBchannels1Click(Sender: TObject);
    procedure Printersetup1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure PrintPreview1Click(Sender: TObject);
    procedure Edgedetection1Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure RemoveRedEyes1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string; n: boolean);
    procedure ShowHint(Sender: TObject);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses ChildWin, About, ImageEn, ColorSel, Rotate,
  resres, MergeDialog, Histogram, ConvBW, zprop, Unit1,
  printers, GifLZW, TIFLZW;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // uncomment to enable Gif and TIFF-LZW
 (*
 DefGIF_LZWDECOMPFUNC := GIFLZWDecompress;
 DefGIF_LZWCOMPFUNC := GIFLZWCompress;
 DefTIFF_LZWDECOMPFUNC := TIFFLZWDecompress;
 DefTIFF_LZWCOMPFUNC := TIFFLZWCompress;
 *)
  Application.OnHint := ShowHint;
  Screen.OnActiveFormChange := UpdateMenuItems;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusBar.SimpleText := Application.Hint;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.FileNewItemClick(Sender: TObject);
begin
  CreateMDIChild('New' + IntToStr(MDIChildCount + 1) + '.jpg', true);
end;

////////////////////////////////////////////////////////////////////////////////////
// Open

procedure TMainForm.FileOpenItemClick(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
    CreateMDIChild(OpenImageEnDialog1.FileName, false);
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.FileCloseItemClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    ActiveMDIChild.Close;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

////////////////////////////////////////////////////////////////////////////////////
// cut selection to clipboard

procedure TMainForm.CutItemClick(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.SelCutToClip;
end;

////////////////////////////////////////////////////////////////////////////////////
// copy selection to clipboard

procedure TMainForm.CopyItemClick(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.SelCopyToClip;
end;

////////////////////////////////////////////////////////////////////////////////////
// paste from clipboard

procedure TMainForm.PasteItemClick(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.PasteFromClipboard;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.WindowCascadeItemClick(Sender: TObject);
begin
  Cascade;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.WindowTileItemClick(Sender: TObject);
begin
  Tile;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.WindowArrangeItemClick(Sender: TObject);
begin
  ArrangeIcons;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.WindowMinimizeItemClick(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.UpdateMenuItems(Sender: TObject);
var
  Child: TMDIChild;
  v: boolean;
begin
  Child := ActiveMDIChild as TMDIChild;
  //
  v := MDIChildCount > 0;

  // Disable AlphaChannel tools until image is loaded
  AlphaChannelPanel.Enabled := v;
  TrackBar2.Enabled := v;
  CheckBox1.Enabled := v;
  SpeedButton5.Enabled := v;
  SpeedButton8.Enabled := v;
  SpeedButton9.Enabled := v;
  SpeedButton10.Enabled := v;
  SpeedButton11.Enabled := v;
  SpeedButton12.Enabled := v;
  SpeedButton13.Enabled := v;

  PrintPreview1.Enabled := v;

  // disable magicwand selection until image is loaded
  UpDown1.Enabled := v;
  Edit2.Enabled := v;

  FileCloseItem.Enabled := v;
  FileSaveItem.Enabled := v;
  Print1.Enabled := v;
  FileSaveAsItem.Enabled := v;
  CutItem.Enabled := v;
  CopyItem.Enabled := v;
  PasteItem.Enabled := v;
  PastetoRect1.Enabled := v;
  SaveBtn.Enabled := v;
  CutBtn.Enabled := v;
  CopyBtn.Enabled := v;
  PasteBtn.Enabled := v;
  WindowCascadeItem.Enabled := v;
  WindowTileItem.Enabled := v;
  WindowArrangeItem.Enabled := v;
  WindowMinimizeItem.Enabled := v;
  ComboBox1.Enabled := v;
  TrackBar1.Enabled := v;
  Effects1.Enabled := v;
  Background1.Enabled := v;
  SpeedButton2.Enabled := v;
  Negative1.Enabled := v;
  Grayscale1.Enabled := v;
  Rotate1.Enabled := v;
  Verticalflip1.Enabled := v;
  Horizontalflip1.Enabled := v;
  Undo1.enabled := v;
  Resize1.enabled := v;
  Resample1.Enabled := v;
  Clear1.Enabled := v;
  SpeedButton3.Enabled := v;
  SpeedButton4.Enabled := v;
  SpeedButton5.Enabled := v;
  SpeedButton6.Enabled := v;
  SpeedButton7.Enabled := v;
  Merge1.Enabled := v;
  Selectscanner1.Enabled := v;
  Acquire1.Enabled := v;
  ColorAdjust1.Enabled := v;
  Histogram1.Enabled := v;
  Calccolornumber1.Enabled := v;
  ConverttoBW1.Enabled := v;
  Reducecolors1.Enabled := v;
  GetHSVchannels1.Enabled := v;
  Edgedetection1.enabled := v;
  ConverttoTruecolor1.enabled := v;
  GetRGBchannels1.enabled := v;
  Hiddentext1.enabled := v;
  Zoomproperties1.enabled := v;
  Crop1.enabled := v;
  SpeedButton5Click(Self);
  //
  if v then
  begin
    ComboBox1.Text := FloatToStr(Child.ImageEnView1.Zoom);
    Trackbar1.Position := Trunc(Child.ImageEnView1.Zoom * 10);
    Undo1.Enabled := Child.ImageEnView1.Proc.CanUndo;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.HelpAboutItemClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

////////////////////////////////////////////////////////////////////////////////////
// paste from clipboard to rect

procedure TMainForm.PastetoRect1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.SelPasteFromClipStretch;
end;

////////////////////////////////////////////////////////////////////////////////////
// Cancel selection

procedure TMainForm.Unselect1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.DeSelect;
end;

////////////////////////////////////////////////////////////////////////////////////
// Zoom (trackbar)

procedure TMainForm.TrackBar1Change(Sender: TObject);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  Child.ImageEnView1.Zoom := Trackbar1.Position / 10;
  ComboBox1.Text := floattostr(Child.ImageEnView1.Zoom);
end;

////////////////////////////////////////////////////////////////////////////////////
// Zoom (combobox)

procedure TMainForm.ComboBox1Change(Sender: TObject);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  if ComboBox1.Text = 'Fit' then
  begin
    Child.ImageEnView1.Fit;
    trackbar1.position := trunc(Child.ImageEnView1.zoom * 10);
  end
  else
  begin
    try
      Trackbar1.Position := trunc(StrToFloat(ComboBox1.Text) * 10);
    except
      Trackbar1.Position := 100;
    end;
    Child.ImageEnView1.Zoom := trackbar1.Position / 10;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// Effects

procedure TMainForm.Effects1Click(Sender: TObject);
begin
  //(ActiveMDIChild as TMDIChild).ImageEnProc1.SaveUndo;
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.DoPreviews(ppeEffects);
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// File->Save as...

procedure TMainForm.FileSaveAsItemClick(Sender: TObject);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  SaveImageEnDialog1.Filename := Child.Caption;
  SaveImageEnDialog1.AttachedImageEnIO := Child.ImageEnView1.IO;
  if SaveImageEnDialog1.Execute then
  begin
    Child.Caption := SaveImageEnDialog1.FileName;
    FileSaveItemClick(Self);
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// File->Save

procedure TMainForm.FileSaveItemClick(Sender: TObject);
begin
  with ActiveMDIChild as TMDIChild do
  begin
    ImageEnView1.IO.SaveToFile(Caption);
    ProgressBar1.Position := 0;
    Changed := false;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// Create/Load image
// n=true : new image (not load)

procedure TMainForm.CreateMDIChild(const Name: string; n: boolean);
var
  Child: TMDIChild;
begin
  Child := TMDIChild.Create(Application);
  Child.Caption := Name;
  if (not n) and FileExists(Name) then
  begin
    Child.ImageEnView1.IO.LoadFromFile(Name);
    ProgressBar1.Position := 0;
    if Child.WindowState = wsNormal then
    begin
      Child.ClientWidth := Child.ImageEnView1.IdealComponentWidth;
      Child.ClientHeight := Child.ImageEnView1.IdealComponentHeight;
      if Child.width > ClientWidth then
        Child.Width := ClientWidth;
      if Child.Height > ClientHeight - SpeedPanel.Height - StatusBar.Height - Panel1.Height - AlphaChannelPanel.Height - 5 then
        Child.Height := ClientHeight - SpeedPanel.Height - StatusBar.Height - Panel1.Height - AlphaChannelPanel.Height - 5;
    end;
  end
  else
  begin
    Child.ImageEnView1.Proc.ImageResize(300, 300);
    Child.ImageEnView1.Proc.ClearUndo;
    Undo1.Enabled := false;
  end;
  Child.Changed := false;
end;

////////////////////////////////////////////////////////////////////////////////////
// Select background

procedure TMainForm.Background1Click(Sender: TObject);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  fColorSel.HSVBox1.SetColor(Child.ImageEnView1.background);
  fColorSel.HSVBox1Change(Self);
  if fColorSel.ShowModal = mrOK then
    Child.ImageEnView1.Background := fColorSel.HSVBox1.color;
end;

////////////////////////////////////////////////////////////////////////////////////
// Negative

procedure TMainForm.Negative1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.Negative;
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// Gray scale

procedure TMainForm.Grayscale1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.ConvertToGray;
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// Rotate

procedure TMainForm.Rotate1Click(Sender: TObject);
begin
  with (ActiveMDIChild as TMDIChild) do
  begin
    fRotate.ImageEnView1.Assign(ImageEnView1);
    fRotate.ImageEnProc1.Resample(fRotate.ImageEnView1.Width, -1, rfNone);
    fRotate.ImageEnView1.Fit;
    if fRotate.ShowModal = mrOK then
      ImageEnView1.Proc.Rotate(fRotate.updown1.position, fRotate.checkbox1.checked);
  end;
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// vertical flip

procedure TMainForm.Verticalflip1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.Flip(fdVertical);
end;

////////////////////////////////////////////////////////////////////////////////////
// horizontal flip

procedure TMainForm.Horizontalflip1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.Flip(fdHorizontal);
end;

////////////////////////////////////////////////////////////////////////////////////
// Undo

procedure TMainForm.Undo1Click(Sender: TObject);
begin
  with (ActiveMDIChild as TMDIChild).ImageEnView1.Proc do
  begin
    Undo;
    ClearUndo;
    Undo1.Enabled := false;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// Resize

procedure TMainForm.Resize1Click(Sender: TObject);
var
  Child: TMDIChild;
  w, h: integer;
begin
  Child := ActiveMDIChild as TMDIChild;
  fResize.OrgWidth := Child.ImageEnView1.Bitmap.Width;
  fResize.OrgHeight := Child.ImageEnVIew1.Bitmap.Height;
  fResize.Caption := 'Resize';
  if fresize.ShowModal = mrOK then
  begin
    w := StrToIntDef(fResize.Edit1.Text, 0);
    h := StrToIntDef(fResize.Edit2.Text, 0);
    if (w > 0) and (h > 0) then
      Child.ImageEnView1.Proc.ImageResize(w, h);
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// Resample

procedure TMainForm.Resample1Click(Sender: TObject);
var
  Child: TMDIChild;
  w, h: integer;
begin
  Child := ActiveMDIChild as TMDIChild;
  fResize.OrgWidth := Child.ImageEnView1.Bitmap.Width;
  fResize.OrgHeight := Child.ImageEnView1.Bitmap.Height;
  fResize.caption := 'Resample';
  if fresize.ShowModal = mrOK then
  begin
    w := strtointdef(fResize.edit1.text, 0);
    h := strtointdef(fResize.edit2.text, 0);
    if (w > 0) and (h > 0) then
      Child.ImageEnView1.Proc.Resample(w, h, TResampleFilter(freSize.Combobox1.Itemindex));
    ProgressBar1.Position := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// Clear

procedure TMainForm.Clear1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.Clear;
end;

////////////////////////////////////////////////////////////////////////////////////
// Merge

procedure TMainForm.Merge1Click(Sender: TObject);
begin
  if fMergeDialog.ShowModal = mrOK then
    if fMergeDialog.ListBox1.ItemIndex >= 0 then
    begin
      (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.Merge(
        (MDIChildren[fMergeDialog.ListBox1.ItemIndex] as TMDIChild).ImageEnView1.Bitmap,
        100 - fMergeDialog.TrackBar1.Position
        );
    end;
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// Color adjust...

procedure TMainForm.ColorAdjust1Click(Sender: TObject);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  Child.ImageEnView1.Proc.DoPreviews(ppeColorAdjust);
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// Histogram

procedure TMainForm.Histogram1Click(Sender: TObject);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  fHistogram.ImageEnProc1.AttachedImageEn := Child.ImageEnView1;
  fHistogram.HistogramBox1.Update;
  fHistogram.ShowModal;
end;

////////////////////////////////////////////////////////////////////////////////////
// Select scanner

procedure TMainForm.Selectscanner1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.IO.SelectAcquireSource;
end;

////////////////////////////////////////////////////////////////////////////////////
// Acquire

procedure TMainForm.Acquire1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.IO.Params.SetDefaultParams;
  (ActiveMDIChild as TMDIChild).ImageEnView1.IO.Acquire;
end;

////////////////////////////////////////////////////////////////////////////////////
// Calc Color Number

procedure TMainForm.Calccolornumber1Click(Sender: TObject);
var
  nc: integer;
begin
  nc := (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.CalcImageNumColors;
  ShowMessage('The active images has ' + inttostr(nc) + ' colors.');
end;

////////////////////////////////////////////////////////////////////////////////////
// Reduce colors

procedure TMainForm.Reducecolors1Click(Sender: TObject);
var
  snc: string;
  nc: integer;
begin
  InputQuery('Reduce Colors', 'Insert colors of image:', snc);
  nc := StrToIntDef(snc, 0);
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.ConvertTo(nc);
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// GetHSVChannels

procedure TMainForm.GetHSVchannels1Click(Sender: TObject);
var
  Child: TMDIChild;
  ChildH: TMDIChild;
  ChildS: TMDIChild;
  ChildV: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  ChildH := TMDIChild.Create(Application);
  ChildH.Caption := Child.Name + ' Hue';
  ChildS := TMDIChild.Create(Application);
  ChildS.Caption := Child.Name + ' Saturation';
  ChildV := TMDIChild.Create(Application);
  ChildV.Caption := Child.Name + ' Value';
  Child.imageenView1.proc.GetHSVChannelAll(ChildH.ImageEnView1.IEBitmap, ChildS.ImageEnView1.IEBitmap, ChildV.ImageEnView1.IEBitmap);
  ChildH.imageenview1.Update;
  ChildS.imageenview1.Update;
  ChildV.imageenview1.Update;
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// Buttons Select/Hand/Zoom

procedure TMainForm.SpeedButton5Click(Sender: TObject);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  //Child.ImageEnProc1.SaveUndo;
  if not assigned(Child) then
    exit;
  if SpeedButton5.down then
  begin
    // Select rect
    Child.ImageEnView1.MouseInteract := [miSelect];
    Child.ImageEnView1.Cursor := 1785;
    PopupMenu1.AutoPopup := true;
  end
  else if SpeedButton8.down then
  begin
    // Select polygon
    Child.ImageEnView1.MouseInteract := [miSelectPolygon];
    Child.ImageEnView1.Cursor := 1785;
    PopupMenu1.AutoPopup := true;
  end
  else if SpeedButton9.down then
  begin
    // Select circle
    Child.ImageEnView1.MouseInteract := [miSelectCircle];
    Child.ImageEnView1.Cursor := 1785;
    PopupMenu1.AutoPopup := true;
  end
  else if SpeedButton6.down then
  begin
    // Hand
    Child.ImageEnView1.MouseInteract := [miScroll];
    Child.ImageEnView1.Cursor := 1782;
    PopupMenu1.AutoPopup := true;
  end
  else if SpeedButton7.down then
  begin
    // Zoom
    Child.ImageEnView1.MouseInteract := [miZoom, miScroll];
    Child.ImageEnView1.Cursor := 1779;
    PopupMenu1.AutoPopup := false;
  end
  else if SpeedButton10.down then
  begin
    // Magic wand
    Child.ImageEnView1.MouseInteract := [miSelectMagicWand];
    Child.ImageEnView1.Cursor := 1785;
    PopupMenu1.AutoPopup := true;
  end
  else
    Child.ImageEnView1.VisibleSelection := False;
end;

////////////////////////////////////////////////////////////////////////////////////
// Image->ConvertToBW

procedure TMainForm.ConverttoBW1Click(Sender: TObject);
begin
  with fConvBW do
    if ShowModal = mrOK then
      case RadioGroup1.ItemIndex of
        0:
          // Threshold
          if SpeedButton1.Down then
            (Self.ActiveMDIChild as TMDIChild).ImageEnView1.Proc.ConvertToBWThreshold(-1)
          else
            (Self.ActiveMDIChild as TMDIChild).ImageEnView1.Proc.ConvertToBWThreshold(StrToIntDef(Edit1.Text, 0));
        1:
          // Ordered
          (self.ActiveMDIChild as TMDIChild).ImageEnView1.Proc.ConvertToBWOrdered;
      end;
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// Tools->Zoom properties

procedure TMainForm.Zoomproperties1Click(Sender: TObject);
begin
  with (self.ActiveMDIChild as TMDIChild), fZProp do
  begin
    ComboBox1.ItemIndex := ord(ImageEnView1.ZoomFilter);
    if ShowModal = mrOK then
    begin
      ImageEnView1.ZoomFilter := TResampleFilter(ComboBox1.ItemIndex);
      ImageEnView1.DelayZoomFilter := CheckBox1.Checked;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// Image->Convert to true color

procedure TMainForm.ConverttoTruecolor1Click(Sender: TObject);
begin
  (ActiveMDIChild as TMDIChild).ImageEnView1.Proc.ConvertTo24Bit;
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// Edit->Crop

procedure TMainForm.Crop1Click(Sender: TObject);
var
  ChildC: TMDIChild;
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  ChildC := TMDIChild.Create(Application);
  ChildC.Caption := IntToStr(MDIChildCount) + '.jpg';
  Child.ImageEnView1.AssignSelTo(ChildC.ImageEnView1);
end;

////////////////////////////////////////////////////////////////////////////////////
// Hidden text...

procedure TMainForm.Hiddentext1Click(Sender: TObject);
begin
  Form1.ShowModal;
end;

////////////////////////////////////////////////////////////////////////////////////
// Get RGBChannels

procedure TMainForm.GetRGBchannels1Click(Sender: TObject);
var
  Child: TMDIChild;
  ChildR: TMDIChild;
  ChildG: TMDIChild;
  ChildB: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  ChildR := TMDIChild.Create(Application);
  ChildR.Caption := Child.Name + ' Red';
  ChildG := TMDIChild.Create(Application);
  ChildG.Caption := Child.Name + ' Green';
  ChildB := TMDIChild.Create(Application);
  ChildB.Caption := Child.Name + ' Blue';
  Child.imageenView1.proc.GetRGBChannelAll(ChildR.ImageEnView1.IEBitmap, ChildG.ImageEnView1.IEBitmap, ChildB.ImageEnView1.IEBitmap);
  ChildR.imageenview1.Update;
  ChildG.imageenview1.Update;
  ChildB.imageenview1.Update;
  ChildR.ImageEnView1.Zoom := 100;
  ProgressBar1.Position := 0;
end;

////////////////////////////////////////////////////////////////////////////////////
// printer setup

procedure TMainForm.Printersetup1Click(Sender: TObject);
begin
  PrintDialog1.Execute;
end;

////////////////////////////////////////////////////////////////////////////////////
// print

procedure TMainForm.Print1Click(Sender: TObject);
begin
  (self.ActiveMDIChild as TMDIChild).ImageEnView1.IO.DoPrintPreviewDialog(iedtDialog);
end;

////////////////////////////////////////////////////////////////////////////////////
// this automatically applies the alphachannel to the selection or entire image

procedure TMainForm.TrackBar2Change(Sender: TObject);
var
  Child: TMDIChild;
  PercentAlpha: Extended;
begin
  Child := ActiveMDIChild as TMDIChild;
  // if alphachannel enabled
  if CheckBox1.Checked then
  begin
    // if area selected then fill area then else fill entire image
    if Child.ImageEnView1.Selected then
    begin
      Child.ImageEnView1.SetSelectedAreaAlpha(TrackBar2.Position);
      Child.ImageEnView1.Update;
    end
    else
    begin
      Child.ImageEnView1.AlphaChannel.Fill(TrackBar2.Position);
      Child.ImageEnView1.Update;
    end;
    PercentAlpha := (TrackBar2.Position / 255) * 100;
    StatusBar.Panels[1].Text := IntToStr(TrackBar2.Position);
    StatusBar.Panels[2].Text := FloatToStrF(PercentAlpha, ffFixed, 7, 0) + '%';
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// Enable Alpha Channel

procedure TMainForm.CheckBox1Click(Sender: TObject);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  Child.ImageEnView1.EnableAlphaChannel := CheckBox1.Checked;
  TrackBar2.Enabled := CheckBox1.Checked;
end;

////////////////////////////////////////////////////////////////////////////////////
// adjust MagicWand Tolerance

procedure TMainForm.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
var
  Child: TMDIChild;
begin
  Child := ActiveMDIChild as TMDIChild;
  Child.ImageENView1.MagicWandTolerance := UpDown1.Position;
end;

////////////////////////////////////////////////////////////////////////////////////
// Print Preview

procedure TMainForm.PrintPreview1Click(Sender: TObject);
begin
  Screen.Cursor := crHourglass;
  try
    (Self.ActiveMDIChild as TMDIChild).ImageEnView1.IO.DoPrintPreviewDialog(iedtDialog);
  finally Screen.Cursor := crDefault;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// edge detection

procedure TMainForm.Edgedetection1Click(Sender: TObject);
begin
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.Proc.EdgeDetect_ShenCastan(0.99, 0.9, 7, 0, True);
end;

////////////////////////////////////////////////////////////////////////////////////
// select none

procedure TMainForm.SpeedButton11Click(Sender: TObject);
begin
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.MouseInteract := [miScroll];
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.Cursor := 1782;
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.VisibleSelection := False;
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.DeSelect;
end;

procedure TMainForm.SpeedButton13Click(Sender: TObject);
begin
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.VisibleSelection := False;
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.DeSelect;
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.MouseInteract := [miSelectLasso];
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.Cursor := 1785;
end;

// remove red eyes

procedure TMainForm.RemoveRedEyes1Click(Sender: TObject);
begin
  (Self.ActiveMDIChild as TMDIChild).ImageEnView1.Proc.RemoveRedEyes;
end;

initialization
  iegDialogsBackground:=iedbPaper;

end.
