unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uchild,
  Menus;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    OpenImage11: TMenuItem;
    OpenImage21: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Windows1: TMenuItem;
    Cascade1: TMenuItem;
    File2: TMenuItem;
    test1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure File2Click(Sender: TObject);
    procedure OpenImage11Click(Sender: TObject);
    procedure OpenImage21Click(Sender: TObject);
    procedure test1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PerformCompare;
  end;

var
  MainForm: TMainForm;

implementation

uses hyieutils;

{$R *.DFM}

// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Cascade1Click(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.File2Click(Sender: TObject);
begin
  Tile;
end;

// File | Open Image 1
procedure TMainForm.OpenImage11Click(Sender: TObject);
begin
  with image1.ImageEnView1.IO do
  begin
    LoadFromFileAuto( ExecuteOpenDialog('','',true,0,'') );
    image1.Caption:=Params.FileName;
  end;
  PerformCompare;
end;

// File | Open Image 2
procedure TMainForm.OpenImage21Click(Sender: TObject);
begin
  with image2.ImageEnView1.IO do
  begin
    LoadFromFileAuto( ExecuteOpenDialog('','',true,0,'') );
    image2.Caption:=Params.FileName;
  end;
  PerformCompare;
end;

procedure TMainForm.test1Click(Sender: TObject);
begin
  Tile;
  image1.imageenview1.IO.LoadFromFile('image1.gif');
  image2.imageenview1.IO.LoadFromFile('image2.gif');
  image1.ImageEnView1.Fit;
  image2.ImageEnView1.Fit;
  PerformCompare;
end;

procedure TMainForm.PerformCompare;
begin
  diffs.Caption:='Diffrences';
  diffs.ImageEnView1.LegacyBitmap:=False; // we need ie8g pixel format
  diffs.ImageEnView1.IEBitmap.PixelFormat:=ie8g;

  image1.ImageEnView1.Proc.CompareWith( image2.ImageEnView1.IEBitmap, diffs.ImageEnView1.IEBitmap );
  diffs.ImageEnView1.Update;
  diffs.ImageEnView1.Fit;
end;


end.
