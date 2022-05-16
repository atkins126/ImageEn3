unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, Menus, ievect, Buttons, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Exit1: TMenuItem;
    ImageEnVect1: TImageEnVect;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    procedure Open1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    v: integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Open1Click(Sender: TObject);
begin
  imageenvect1.io.loadfromfile(imageenvect1.io.ExecuteOpenDialog('', '', false, 1, ''));
  imageenvect1.RemoveAllObjects;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  imageenvect1.MouseInteractVt := [miPutLineLabel];
  imageenvect1.ObjEndShape[-1] := iesOUTARROW;
  imageenvect1.ObjBrushColor[-1] := clRed;
  imageenvect1.ObjBrushStyle[-1] := bsSolid;
  v := 0;
end;

// insert

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if speedbutton1.down then
    imageenvect1.MouseInteractVt := [miPutLineLabel];
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if speedbutton2.down then
    imageenvect1.MouseInteractVt := [miObjectSelect];
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  ss: string;
begin
  ss := ' ' + edit1.text + ' ';
  imageenvect1.ObjText[-1] := ss;
  if imageenvect1.SelObjectsCount > 0 then
    imageenvect1.ObjText[imageenvect1.SelObjects[0]] := ss;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if checkbox1.checked then
  begin
    edit1.Enabled := false;
    label1.enabled := false;
  end
  else
  begin
    edit1.enabled := true;
    label1.enabled := true;
  end;
end;

procedure TForm1.ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
begin
  if checkbox1.checked then
  begin
    imageenvect1.ObjText[hobj] := ' ' + inttostr(v) + ' ';
    inc(v);
  end;
end;

end.
