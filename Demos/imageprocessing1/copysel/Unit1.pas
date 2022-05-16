unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, ImageEnView, IEVect, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    ImageEnVect1: TImageEnVect;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    TrackBar1: TTrackBar;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses hyieutils;

{$R *.DFM}

// Open...

procedure TForm1.Button2Click(Sender: TObject);
begin
  with ImageEnVect1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));
end;

// select polygon

procedure TForm1.Button3Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteract := [miSelectPolygon];
end;

// Select ellipse

procedure TForm1.Button4Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteract := [miSelectCircle];
end;

// select rectangle

procedure TForm1.Button7Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteract := [miSelect];
end;

// Copy and paste

procedure TForm1.Button1Click(Sender: TObject);
var
  hobj: integer;
begin
  hobj := ImageEnVect1.CreateImageFromSelectedArea(0, false);
  //
  ImageEnVect1.DeSelect;
  ImageEnVect1.MouseInteractVT := [miObjectSelect];
  ImageEnVect1.UnSelAllObjects;
  ImageEnVect1.AddSelObject(hobj);
  ImageEnVect1.Update;
end;

// select/move objects

procedure TForm1.Button5Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVT := [miObjectSelect];
end;

// zoom

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ImageEnVect1.Zoom := TrackBar1.Position;
end;

end.
