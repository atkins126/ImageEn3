unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ievect, ExtCtrls, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ImageEnVect1: TImageEnVect;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Label1: TLabel;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Button2: TButton;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure ImageEnVect1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    hobj:integer;
  public
    { Public declarations }
    procedure WriteCoordinates;
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
  with ImageEnVect1.IO do
    LoadFromFileAuto( ExecuteOpenDialog('','',true,0,'') );
end;

procedure TForm1.ImageEnVect1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageEnVect1.RemoveAllObjects;
  hobj:=ImageEnVect1.CreatePolygonFromEdge(X,Y,false,10);
  WriteCoordinates;
end;

procedure TForm1.WriteCoordinates;
var
  i:integer;
begin
  memo1.Lines.Clear;
  with ImageEnVect1 do
    for i:=0 to ObjPolylinePointsCount[hobj]-1 do
      memo1.Lines.Add( IntToStr( ObjPolylinePoints[hobj,i].X ) + ','+ IntToStr( ObjPolylinePoints[hobj,i].Y ) );
end;

// Reduce points to
procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnVect1.SimplifyPolygon(hobj, StrToInt( Edit1.Text ) );
  WriteCoordinates;
end;

// Remove jagged edges
procedure TForm1.Button2Click(Sender: TObject);
begin
  ImageEnVect1.RemovePolygonJaggedEdges(hobj);
end;

end.
