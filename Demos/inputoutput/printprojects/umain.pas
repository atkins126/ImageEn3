unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, hyieutils, hyiedefs, imageenproc, imageenio;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Print1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    procedure Open1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// File | Open
procedure TForm1.Open1Click(Sender: TObject);
var
  DominantColor:TRGB;
begin
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog('','',false,1,'') );

  // check if the project is black on white or white on black
  ImageEnView1.Proc.GetDominantColor(DominantColor);
  if TRGB2TColor(DominantColor)=clWhite then
  begin
    ImageEnView1.ZoomFilter:=rfProjectBW;
    ImageEnView1.IO.PrintingFilterOnSubsampling:=rfProjectBW;
  end
  else
  begin
    ImageEnView1.ZoomFilter:=rfProjectWB;
    ImageEnView1.IO.PrintingFilterOnSubsampling:=rfProjectWB;
  end;
end;

// File | Print
procedure TForm1.Print1Click(Sender: TObject);
begin
  ImageEnView1.IO.DoPrintPreviewDialog(iedtDialog,'');
end;

// File | Close
procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

end.
