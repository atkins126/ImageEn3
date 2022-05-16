unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, Menus, ievect, Buttons, ExtCtrls, StdCtrls;

type
  Tfmain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ImageEnVect1: TImageEnVect;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ImageEnVect1SelectObject(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    records: TStringList;
    procedure ShowObj(hobj: integer);
  end;

var
  fmain: Tfmain;

implementation

{$R *.DFM}

type
  TMyRecord = class
    caption: string;
    description: string;
    // you could add new fields here
  end;

procedure Tfmain.FormCreate(Sender: TObject);
begin
  records := TStringList.Create;
end;

procedure Tfmain.FormDestroy(Sender: TObject);
begin
  while records.Count > 0 do
  begin
    records.Objects[0].free;
    records.Delete(0);
  end;
end;

// File | Close

procedure Tfmain.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open

procedure Tfmain.Open1Click(Sender: TObject);
begin
  with ImageEnVect1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 0, ''));
  ImageEnVect1.MouseInteractVt := [miObjectSelect];
end;

// New Point

procedure Tfmain.SpeedButton1Click(Sender: TObject);
begin
  ImageEnVect1.ObjText[-1] := 'New Point';
  ImageEnVect1.ObjBeginShape[-1] := iesOUTARROW;
  ImageEnVect1.ObjBrushStyle[-1] := bsSolid;
  ImageEnVect1.ObjPenColor[-1] := clRed;
  ImageEnVect1.MouseInteractVt := [miPutLineLabel];
end;

// created a new point

procedure Tfmain.ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
var
  newobj: TMyRecord;
begin

  newobj := TMyRecord.Create;
  newobj.caption := 'New Point';
  newobj.description := '';

  records.AddObject(inttostr(hobj), newobj);

  ShowObj(hobj);

  ImageEnVect1.MouseInteractVt := [miObjectSelect];
  SpeedButton1.Down := false;
end;

procedure Tfmain.ShowObj(hobj: integer);
var
  idx: integer;
  myrec: TMyRecord;
begin
  idx := records.IndexOf(IntToStr(hobj));
  if idx >= 0 then
  begin
    myrec := records.Objects[idx] as TMyRecord;
    Edit1.Text := myrec.caption;
    Memo1.Text := myrec.description;
  end;
end;

// Save object changes

procedure Tfmain.Button1Click(Sender: TObject);
var
  idx: integer;
  myrec: TMyRecord;
  hobj: integer;
begin
  hobj := ImageEnVect1.SelObjects[0]; // first selected object
  idx := records.IndexOf(IntToStr(hobj));
  if idx >= 0 then
  begin
    myrec := records.Objects[idx] as TMyRecord;
    myrec.caption := Edit1.Text;
    myrec.description := Memo1.Text;
    ImageEnVect1.ObjText[hobj] := myrec.caption;
  end;
end;

// object selected

procedure Tfmain.ImageEnVect1SelectObject(Sender: TObject);
begin
  ShowObj(ImageEnVect1.SelObjects[0]);
end;

end.
