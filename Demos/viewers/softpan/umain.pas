unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ieview, imageenview, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    ImageEnView1: TImageEnView;
    procedure Open1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog() );
end;

end.
