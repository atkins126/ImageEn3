unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImageEnView, IEMView, StdCtrls, FileCtrl, ImageEnIO, ComCtrls, ieview, hyiedefs,
  ExtCtrls, hyieutils;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    ImageEnMView1: TImageEnMView;
    StatusBar1: TStatusBar;
    ImageEnView1: TImageEnView;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    Splitter1: TSplitter;
    CheckBox7: TCheckBox;
    CheckBox1: TCheckBox;
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure ImageEnMView1BeforeImageDrawEx(Sender: TObject; idx, Left,
      Top: Integer; Dest: TBitmap; var ThumbRect: TRect);
    procedure ImageEnMView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ThumbBackground: TImageEnView;
    SelThumbBackground: TImageEnView;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

//

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
  ImageEnMView1.Clear;
  ImageEnMView1.FillFromDirectory(DirectoryListBox1.Directory);
  //
  ImageEnMView1.SelectedImage := 0;
  ImageEnView1.io.LoadFromFile(ImageEnMView1.ImageFileName[0]);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  ImageEnMView1.EnableAlphaChannel := true;
  ImageEnVIew1.GradientEndColor := clGray;
  ImageenMView1.SoftShadow.Enabled := false;
  //ImageEnMView1.WallPaper.LoadFromFile(extractfilepath(paramstr(0))+'wallpaper.bmp');

  imageenmview1.FillThumbnail := false;
  imageenmview1.SelectionWidth := 0;
  imageenmview1.ShowText := false;
  imageenmview1.Style := iemsFlat;

  ThumbBackground := TImageEnView.Create(self);
  ThumbBackground.IO.LoadFromFilePNG(extractfilepath(paramstr(0)) + 'thumb.dat');
  ImageEnMView1.ThumbWidth := ThumbBackground.IEBitmap.Width;
  ImageEnMView1.ThumbHeight := ThumbBackground.IEBitmap.Height;

  SelThumbBackground := TImageEnView.Create(self);
  SelThumbBackground.IO.LoadFromFilePNG(extractfilepath(paramstr(0)) + 'thumb.dat');
  SelThumbBackground.Proc.IntensityRGBall(-50, 20, -50);

  //ImageEnMView1.ThreadPoolSize:=0;	// uncomment if you want monotasking load
  //
  DirectoryListBox1Change(self);
end;

procedure TForm1.ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
begin
  if CheckBox1.Checked then
    ImageEnView1.io.LoadFromFile(ImageEnMView1.ImageFileName[idx]);
end;

// softshadow

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  ImageEnMView1.SoftShadow.Enabled := CheckBox2.Checked;
  ImageEnMView1.Update;
end;

// wall paper

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then
    ImageEnMView1.WallPaper.LoadFromFile(extractfilepath(paramstr(0)) + 'wallpaper.bmp')
  else
    ImageEnMView1.WallPaper := nil;
  ImageEnMView1.Update;
end;

// Thumbnails rounded

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  if CheckBox7.Checked then
    ImageEnMView1.ThumbsRounded := 5
  else
    ImageEnMView1.ThumbsRounded := 0;
  ImageEnMView1.Update;
end;

procedure TForm1.ImageEnMView1BeforeImageDrawEx(Sender: TObject; idx, Left,
  Top: Integer; Dest: TBitmap; var ThumbRect: TRect);
begin
  //if idx = ImageEnMView1.SelectedImage then
  if ImageEnMView1.IsSelected(idx) then
    SelThumbBackground.IEBitmap.RenderToTBitmapEx(Dest, Left, Top, ImageEnMView1.ThumbWidth, ImageEnMView1.ThumbHeight, 0, 0, SelThumbBackground.IEBitmap.Width, SelThumbBackground.IEBitmap.Height, 255, rfNone, ielNormal)
  else
    ThumbBackground.IEBitmap.RenderToTBitmapEx(Dest, Left, Top, ImageEnMView1.ThumbWidth, ImageEnMView1.ThumbHeight, 0, 0, ThumbBackground.IEBitmap.Width, ThumbBackground.IEBitmap.Height, 255, rfNone, ielNormal);
  ThumbRect.Left := 32;
  ThumbRect.Top := 49;
  ThumbRect.Right := 154;
  ThumbRect.Bottom := 140;

end;

procedure TForm1.ImageEnMView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  //
  i := ImageEnMView1.ImageAtPos(X, Y);
  if i > -1 then
  begin
    dec(X, ImageEnMView1.ImageX[i]);
    dec(Y, ImageEnMView1.ImageY[i]);
    if (X >= 138) and (X <= 152) and (Y >= 146) and (Y <= 163) then
    begin
      ShowMessage(ImageEnMView1.ImageFileName[i] + #13 +
        IntToStr(ImageEnMView1.ImageOriginalWidth[i]) + 'x' + IntToStr(ImageEnMView1.ImageOriginalHeight[i]));
    end;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  ImageEnView1.Visible:=CheckBox1.Checked;
end;

end.
