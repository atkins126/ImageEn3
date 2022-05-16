unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ieview, imageenview, Menus, ExtCtrls;

type
  Tfmain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ImageEnView1: TImageEnView;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmain: Tfmain;

implementation

uses unav;

{$R *.dfm}

// File | Close

procedure Tfmain.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open

procedure Tfmain.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile(ExecuteOpenDialog);
end;

procedure Tfmain.FormActivate(Sender: TObject);
begin
  ImageEnView1.SetNavigator(fnav.ImageEnView1);
  //fnav.ImageEnView1.SelectionOptions:=fnav.ImageEnView1.SelectionOptions+[iesoMarkOuter];
end;

end.
