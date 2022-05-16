unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, StdCtrls;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ImageEnView1SelectionChange(Sender: TObject);
    procedure ImageEnView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog('','',false,1,'') );
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ImageEnView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageEnView1.SaveSelection;
end;

procedure TForm1.ImageEnView1SelectionChange(Sender: TObject);
var
  selwidth,selheight:integer;
begin
  selwidth:=ImageEnView1.SelX2-ImageEnView1.SelX1;
  selheight:=ImageEnView1.SelY2-ImageEnView1.SelY1;
  if (selwidth<30) or (selheight<30) then
    ImageEnView1.RestoreSelection
  else
    ImageEnView1.DiscardSavedSelection;
end;

end.
