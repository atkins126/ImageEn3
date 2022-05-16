unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, StdCtrls, iemview, ExtCtrls, imageenproc;

type
  TMainForm = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ImageEnMView1: TImageEnMView;
    ColorDialog1: TColorDialog;
    Timer1: TTimer;
    Tests1: TMenuItem;
    AnimatePalette1: TMenuItem;
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ImageEnMView1DblClick(Sender: TObject);
    procedure AnimatePalette1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowPalette;
  end;

var
  MainForm: TMainForm;

implementation

uses hyieutils, hyiedefs;

{$R *.DFM}

// File | Open
procedure TMainForm.Open1Click(Sender: TObject);
begin
  // we dont use Windows Bitmaps and load images in native format
  ImageEnView1.LegacyBitmap:=False;
  ImageEnView1.IO.NativePixelFormat:=true;

  with ImageEnView1.IO do
    LoadFromFileAuto( ExecuteOpenDialog('','',false,0,'') );

  // if the bitmap is not 8 bit paletted then convert it
  if ImageEnView1.IEBitmap.PixelFormat<>ie8p then
    ImageEnView1.IEBitmap.PixelFormat:=ie8p;

  ShowPalette;
end;

// File | Save
procedure TMainForm.Save1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    SaveToFile( ExecuteSaveDialog('','',false,0,'') );
end;

// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// fills ImageEnMView with the palette
procedure TMainForm.ShowPalette;
var
  i:integer;
  tmpbmp:TIEBitmap;
begin
  ImageEnMView1.Clear;
  ImageEnMView1.ThumbnailsBorderWidth:=1;
  tmpbmp:=TIEBitmap.Create;
  tmpbmp.Allocate(ImageEnMView1.ThumbWidth,ImageEnMView1.ThumbHeight,ie24RGB);
  for i:=0 to ImageEnView1.IEBitmap.PaletteLength-1 do
  begin
    tmpbmp.Fill( TRGB2TColor(ImageEnView1.IEBitmap.Palette[i]) );
    with ImageEnMView1 do
      ImageEnMView1.SetIEBitmapEx( AppendImage, tmpbmp );
  end;
  tmpbmp.Free;
end;

// Double Click on a color
procedure TMainForm.ImageEnMView1DblClick(Sender: TObject);
var
  idx:integer;
begin
  idx:=ImageEnMView1.SelectedImage;
  if idx>-1 then
  begin
    ColorDialog1.Color := TRGB2TColor( ImageEnView1.IEBitmap.Palette[idx] );
    if ColorDialog1.Execute then
    begin
      ImageEnView1.IEBitmap.Palette[idx] := TColor2TRGB( ColorDialog1.Color );
      ImageEnView1.Update;
      ShowPalette;
    end;
  end;
end;

// animate palette test
procedure TMainForm.AnimatePalette1Click(Sender: TObject);
begin
  AnimatePalette1.Checked:=not AnimatePalette1.Checked;
  Timer1.Enabled := AnimatePalette1.Checked;
  ShowPalette;
end;

// animate palette test - running
procedure TMainForm.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to 255 do
    ImageEnView1.IEBitmap.Palette[i] := CreateRGB(random(256),random(256),random(256));
  ImageEnView1.Update;
end;

end.
