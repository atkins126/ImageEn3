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
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Button1: TButton;
    ColorDialog1: TColorDialog;
    Button2: TButton;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    Button3: TButton;
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selcolor: TColor;
    unselcolor: TColor;
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
  ImageEnView1.GradientEndColor := clGray;
  ImageenMView1.SoftShadow.Enabled := false;

  //ImageEnMView1.MIO.AutoAdjustDPI:=true;

  unselcolor := clWhite;
  selcolor := clLime;

  UpDown1Click(self, btNext);
  DirectoryListBox1Change(self);

end;

procedure TForm1.ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
begin
  if checkbox1.checked then
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

// changes style

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  ImageEnMView1.SetPresetThumbnailFrame(UpDown1.Position, unselcolor, selcolor);
  ImageEnMView1.ShowText:=CheckBox3.Checked;
end;

// select selected color

procedure TForm1.Button1Click(Sender: TObject);
begin
  ColorDialog1.Color := selcolor;
  if ColorDialog1.Execute then
  begin
    selcolor := ColorDialog1.Color;
    UpDown1Click(self, btNext);
  end;
end;

// select unselected color

procedure TForm1.Button2Click(Sender: TObject);
begin
  ColorDialog1.Color := unselcolor;
  if ColorDialog1.Execute then
  begin
    unselcolor := ColorDialog1.Color;
    UpDown1Click(self, btNext);
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  ImageEnView1.Visible:=CheckBox1.Checked;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
var
  i:integer;
begin
  if CheckBox3.Checked then
  begin
    ImageEnMView1.ShowText:=true;
    // set the text background as transparent
    for i:=0 to ImageEnMView1.ImageCount-1 do
      ImageEnMView1.ImageBottomText[i].BackgroundStyle:=bsClear;
  end
  else
    ImageEnMView1.ShowText:=false;
end;

// reload the image
procedure TForm1.Button3Click(Sender: TObject);
begin
  ImageEnMView1.ReloadImage( ImageEnMView1.SelectedImage );
end;

end.
