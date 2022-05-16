unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, iemview, Buttons;

type
  TMainForm = class(TForm)
    ImageEnMView1: TImageEnMView;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormActivate(Sender: TObject);
begin
  ImageEnMView1.MIO.LoadFromFile('150.avi');
  ImageEnMView1.SelectedImage:=0;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var
  a:integer;
begin
  a:=0;
  while SpeedButton1.Down do
  begin
    ImageEnMView1.Proc.Undo;
    ImageEnMView1.Proc.Rotate(a);
    Application.ProcessMessages;

    inc(a);
    if a=361 then a:=0;
  end;
end;

end.
