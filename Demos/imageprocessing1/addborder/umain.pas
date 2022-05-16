unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, Menus, StdCtrls, ExtCtrls, ComCtrls, hyieutils,
  hsvbox;

type
  TMainForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    ImageEnView1: TImageEnView;
    ImageEnView2: TImageEnView;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label7: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label8: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Label9: TLabel;
    Edit4: TEdit;
    UpDown4: TUpDown;
    GroupBox5: TGroupBox;
    HSVBox1: THSVBox;
    CheckBox1: TCheckBox;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateBorderedImage;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// File | Exit

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open...

procedure TMainForm.Open1Click(Sender: TObject);
var
  filename: string;
begin
  with ImageEnView1.IO do
  begin
    filename := ExecuteOpenDialog('', '', false, 1, '');
    if filename <> '' then
    begin
      ImageEnView1.IO.LoadFromFile(filename);
      Label3.Caption := IntToStr(ImageEnView1.IEBitmap.Width);
      Label4.Caption := IntToStr(ImageEnView1.IEBitmap.Height);
      CreateBorderedImage;
    end;
  end;
end;

// File | Save...

procedure TMainForm.Save1Click(Sender: TObject);
begin
  with ImageEnView2.IO do
    ImageEnView2.IO.SaveToFile(ExecuteSaveDialog('', '', false, 1, ''));
end;

procedure TMainForm.CreateBorderedImage;
var
  OrigWidth, origHeight: integer;
  oLeft, oTop, oRight, oBottom: integer;
begin
  ImageEnView2.Assign(ImageEnView1);

  OrigWidth := ImageEnView1.IEBitmap.Width;
  OrigHeight := ImageEnView1.IEBitmap.Height;
  oLeft := UpDown2.Position;
  oTop := UpDown1.Position;
  oRight := UpDown3.Position;
  oBottom := UpDown4.Position;

  // set background color
  ImageEnView2.BackGround := HSVBox1.Color;

  if CheckBox1.Checked then
  begin

    // Symmetric
    ImageEnView2.Proc.ImageResize(OrigWidth + oLeft * 2, OrigHeight + oLeft * 2, iehCenter, ievCenter);

  end
  else
  begin

    // top
    ImageEnView2.Proc.ImageResize(OrigWidth, OrigHeight + oTop, iehCenter, ievBottom);
    // bottom
    ImageEnView2.Proc.ImageResize(OrigWidth, OrigHeight + oTop + oBottom, iehCenter, ievTop);
    // left
    ImageEnView2.Proc.ImageResize(OrigWidth + oLeft, OrigHeight + oTop + oBottom, iehRight, ievCenter);
    // right
    ImageEnView2.Proc.ImageResize(OrigWidth + oLeft + oRight, OrigHeight + oTop + oBottom, iehLeft, ievCenter);

  end;

  // restore background color
  ImageEnView2.Background := clBtnFace;
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    // symmetric
    Edit1.Text := (Sender as TEdit).Text;
    Edit2.Text := (Sender as TEdit).Text;
    Edit3.Text := (Sender as TEdit).Text;
    Edit4.Text := (Sender as TEdit).Text;
  end;
  CreateBorderedImage;
end;

end.
