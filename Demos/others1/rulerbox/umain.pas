unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, rulerbox, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    VertRuler: TRulerBox;
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    HorizRuler: TRulerBox;
    Panel2: TPanel;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageEnView1ViewChange(Sender: TObject; Change: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// File | Exit
procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open
procedure TForm1.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog('','',false,1,'') );
end;

// mouse move
procedure TForm1.ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  HorizRuler.GripsPos[0] := ImageEnView1.XScr2Bmp( X );
  VertRuler.GripsPos[0]  := ImageEnView1.YScr2Bmp( Y );
end;

// scroll or zoom
procedure TForm1.ImageEnView1ViewChange(Sender: TObject; Change: Integer);
var
  z:double;
begin
  z:=ImageEnView1.Zoom / 100;

  HorizRuler.ViewPos := ImageEnView1.ViewX/z;
  VertRuler.ViewPos  := ImageEnView1.ViewY/z;

  HorizRuler.DotPerUnit := z;
  VertRuler.DotPerUnit  := z;

  if ImageEnView1.Zoom>400 then
  begin
    HorizRuler.Frequency := 1;
    VertRuler.Frequency := 1;
    HorizRuler.LabelFreq:=10;
    VertRuler.LabelFreq:=10;
  end;

  StatusBar1.SimpleText:='Zoom '+FloatToStr( ImageEnView1.Zoom )+'%';
end;



end.
