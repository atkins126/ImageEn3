unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    ImageEnView1: TImageEnView;
    RemoveRedEyes1: TMenuItem;
    procedure Open1Click(Sender: TObject);
    procedure RemoveRedEyes1Click(Sender: TObject);
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
begin
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog );
end;

procedure TForm1.RemoveRedEyes1Click(Sender: TObject);
begin
  if ImageEnView1.Selected then
    ImageEnView1.Proc.RemoveRedEyes
  else
    ShowMessage('Please select an eye');
end;

end.
