unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  IEView, IEOpenSaveDlg, ImageENView, ImageEnIO, ImageEnProc, HYIEutils,
  HYIEdefs, IEMView, HSVBox;

const
  crfill: integer = 5;
  crcolorpicker: integer = 6;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    ImageEnView1: TImageEnView;
    OpenImageEnDialog1: TOpenImageEnDialog;
    Button2: TButton;
    SpeedButton1: TSpeedButton;
    Button3: TButton;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    Panel9: TPanel;
    Panel10: TPanel;
    HSVBox1: THSVBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    SelectedColorPanel: TPanel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    L_R: TLabel;
    Label7: TLabel;
    L_G: TLabel;
    Label8: TLabel;
    L_B: TLabel;
    ActiveColorPanel: TPanel;
    Panel3: TPanel;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    ImageEnMView1: TImageEnMView;
    Button5: TButton;
    Button10: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    TrackBar2: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageEnView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshControls;
    procedure RefreshLayerViewer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ImageEn, ShellApi;

{$R *.dfm}
{$R PAINTCURSORS.RES} // cursors for colorpicker

procedure TForm1.FormCreate(Sender: TObject);
begin
  ImageEnView1.EnableAlphaChannel := True;
  ImageEnView1.SetChessboardStyle(4, bsSolid);
  Screen.Cursors[crColorPicker] := LoadCursor(HInstance, 'CRCOLORPICKER');
  RefreshControls;
  RefreshLayerViewer;
end;

// refresh controls with the layer content

procedure TForm1.RefreshControls;
begin
  with ImageEnView1 do
  begin
    TrackBar1.Position := Layers[LayersCurrent].Transparency;
    CheckBox1.Checked := Layers[LayersCurrent].Visible;
  end;
end;

procedure TForm1.RefreshLayerViewer;
var
  i, idx: integer;
begin
  // update ImageEnMView1 with the contents of ImageEnView1
  ImageEnMView1.Clear;
  for i := 0 to ImageEnView1.LayersCount - 1 do
  begin
    idx := ImageEnMView1.AppendImage;
    ImageEnMView1.SetIEBitmap(idx, ImageEnView1.Layers[i].Bitmap);
    ImageEnMView1.ImageTopText[i].Caption := 'Layer ' + inttostr(i);
    ImageEnMView1.ImageTopText[i].Font.Color := clWhite;
  end;
  ImageEnMView1.SelectedImage := ImageEnView1.LayersCurrent;
end;

procedure IETextOut(Canvas: TCanvas; x,y:integer; angle:integer; const Text: String);
var
  LogFont : TLogFont;
begin
  with Canvas do
  begin
    GetObject(Font.Handle, SizeOf(TLogFont), @LogFont);
    LogFont.lfEscapement := angle*10;
    LogFont.lfQuality:=3;
    Font.Handle := CreateFontIndirect(LogFont);
    TextOut(x, y, Text);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnView1.LayersAdd; // add a new layer
  ImageEnView1.Proc.Fill(CreateRGB(255,255,255));
  ImageEnView1.Bitmap.Canvas.Font.Name := 'Times New Roman';
  ImageEnView1.Bitmap.Canvas.Font.Height := 65;
  ImageEnView1.Bitmap.Canvas.Font.Color := clYellow;
  IETextOut(ImageEnView1.Bitmap.Canvas, (ImageEnView1.Width div 2) - 100, ImageEnView1.Height div 2, 0, 'Hello World!'); // draw text on second layer
  ImageEnView1.Proc.SetTransparentColors(CreateRGB(255, 255, 255), CreateRGB(255,255, 255), 0); // remove the white, making it as transparent
  ImageEnView1.Proc.AddSoftShadow(2, 3, 3); // add the shadow
  RefreshControls;
  RefreshLayerViewer;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
  begin
    ImageEnView1.LayersAdd; // add a new layer
    ImageEnView1.LayersRemove(0);
    ImageEnView1.IO.LoadFromfile(OpenImageEnDialog1.Filename);
    RefreshControls;
    RefreshLayerViewer;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  ImageEnView1.EnableAlphaChannel := SpeedButton1.Down;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i: integer;
begin
  for i := ImageEnView1.LayersCount downto 0 do
    with ImageEnView1 do
      LayersRemove(i);
  RefreshControls;
  RefreshLayerViewer;
  ImageEnView1.Blank;
  ImageEnView1.LayersRemove(0);
  RefreshControls;
  RefreshLayerViewer;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ImageEnView1.LayersAdd;
  RefreshControls;
  RefreshLayerViewer
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  with ImageEnView1 do
    LayersInsert(LayersCurrent);
  RefreshControls;
  RefreshLayerViewer
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  with ImageEnView1 do
    LayersRemove(LayersCurrent);
  RefreshControls;
  RefreshLayerViewer
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  i, idx_A, idx_B: integer;
begin
  with ImageEnMView1 do
    if MultiSelectedImagesCount > 1 then
    begin
      MultiSelectSortList; // here we need sorted items
      // we can merge only two layers at the time (idx_A and idx_B)
      idx_B := MultiSelectedImages[MultiSelectedImagesCount - 1]; // get last select image
      for i := MultiSelectedImagesCount - 2 downto 0 do
      begin // we countdown to prevent out of index errors
        idx_A := MultiSelectedImages[i];
        ImageEnView1.LayersMerge(idx_A, idx_B);
        idx_B := idx_A;
      end;
    end;
  RefreshControls;
  RefreshLayerViewer;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  with ImageEnView1 do
    LayersMove(LayersCurrent, LayersCurrent - 1);
  RefreshControls;
  RefreshLayerViewer;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  with ImageEnView1 do
    LayersMove(LayersCurrent, LayersCurrent + 1);
  RefreshControls;
  RefreshLayerViewer;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    Layers[LayersCurrent].Transparency := TrackBar1.Position;
    Update;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    Layers[LayersCurrent].Visible := CheckBox1.checked;
    Update;
  end;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  ImageEnView1.Zoom := TrackBar2.Position;
  // Show hint
  TrackBar2.Hint := 'Zoom - ' + IntToStr(TrackBar2.Position) + '%';
  Statusbar1.Panels[3].Text := 'Zoom - ' + IntToStr(TrackBar2.Position) + '%';
  Application.ActivateHint(Mouse.CursorPos);
end;

procedure TForm1.ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
begin
  with ImageEnView1 do
  begin
    LayersCurrent := idx;
    RefreshControls;
  end;
end;

procedure TForm1.ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  BX, BY: integer;
  R, G, B: Byte;
  RGBValue: DWord;
  RGBColor: TRGB;
begin
  BX := ImageENView1.XScr2Bmp(X);
  BY := ImageENView1.YScr2Bmp(Y);
  StatusBar1.Panels[2].Text := Format('Current: (%d, %d)', [BX, BY]);

  if SpeedButton2.Down then
  begin
    ImageEnView1.Cursor := TCursor(crColorPicker);
    if (BX > 0) and (BY > 0) then
    begin
      RGBColor := ImageENView1.IEBitmap.Pixels[BX, BY];
      SelectedColorPanel.Color := TRGB2TColor(RGBColor);
      ImageENView1.IEBitmap.Canvas.Brush.Color := SelectedColorPanel.Color;
      ImageENView1.IEBitmap.Canvas.Pen.Color := SelectedColorPanel.Color;
      RGBValue := ColortoRGB(SelectedColorPanel.Color);
      R := GetRValue(RGBValue);
      G := GetGValue(RGBValue);
      B := GetBValue(RGBValue);
      L_R.Caption := inttostr(R) + ' ($' + InttoHex(R, 2) + ')';
      L_G.Caption := inttostr(G) + ' ($' + InttoHex(G, 2) + ')';
      L_B.Caption := inttostr(B) + ' ($' + InttoHex(B, 2) + ')';
    end;
  end
  else
    ImageEnView1.Cursor := 1785;
end;

procedure TForm1.ImageEnView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  BX, BY: integer;
  RGBColor: TRGB;
begin
  BX := ImageENView1.XScr2Bmp(X);
  BY := ImageENView1.YScr2Bmp(Y);
  RGBColor := ImageENView1.IEBitmap.Pixels[BX, BY];
  ImageEnView1.Proc.SetTransparentColors(RGBColor, RGBColor, 0);
  SpeedButton2.Down := False;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if SpeedButton2.Down then
    ImageEnView1.Cursor := TCursor(crColorPicker)
  else
    ImageEnView1.Cursor := 1785;
end;

end.
