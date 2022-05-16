unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ievect, ExtCtrls, imageenproc, imageenio,
  Buttons;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    ImageEnVect1: TImageEnVect;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Print1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    AddSpotButton: TSpeedButton;
    SelectButton: TSpeedButton;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSwitch(Sender: TObject);
    procedure ImageEnVect1ObjectOver(Sender: TObject; hobj: Integer);
    procedure ImageEnVect1SelectObject(Sender: TObject);
  private
    { Private declarations }
    FileName:string;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt:=[miObjectSelect];
  ImageEnVect1.CenterNewObjects:=true;
  ImageEnVect1.ObjGripPen.Style := psClear;
  ImageEnVect1.ObjGripBrush.Style := bsclear;
end;

// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open
procedure TMainForm.Open1Click(Sender: TObject);
begin
  FileName:=ImageEnVect1.IO.ExecuteOpenDialog('','',false,0,'');
  if FileName<>'' then
  begin
    // load the bitmap
    ImageEnVect1.IO.LoadFromFile( FileName );
    // look for vectorial objects
    if FileExists( FileName+'.iev' ) then
      ImageEnVect1.LoadFromFileIEV( FileName+'.iev' );
    //
    ImageEnVect1.ObjGripPen.Style := psClear;
    ImageEnVect1.ObjGripBrush.Style := bsclear;
  end;
end;

// File | Save
procedure TMainForm.Save1Click(Sender: TObject);
begin
  FileName:=ImageEnVect1.IO.ExecuteSaveDialog('',FileName,false,0,'');
  if FileName<>'' then
  begin
    // save the bitmap
    ImageEnVect1.IO.SaveToFile( FileName );
    // save vectorial objects
    ImageEnVect1.SaveToFileIEV( FileName+'.iev' );
  end;
end;

// File | Print
procedure TMainForm.Print1Click(Sender: TObject);
begin
  // save a copy of current bitmap
  ImageEnVect1.Proc.SaveUndo(ieuImage);
  // merge vectorial objects with the bitmap
  ImageEnVect1.CopyObjectsToBack(false);  // if you want antialias put True instead of False
  // display preview and print
  ImageEnVect1.IO.DoPrintPreviewDialog(iedtDialog,FileName);
  // restore original bitmap
  ImageEnVect1.Proc.Undo;
end;

// Pressing a switch button
procedure TMainForm.ButtonSwitch(Sender: TObject);
var
  hobj:integer;
begin
  if AddSpotButton.Down then
    with ImageEnVect1 do begin
      hobj := -1; // -1 is the template for new objects
      ObjStyle[hobj]:=[ievsSelectable, ievsMoveable, ievsVisible];
      ObjKind[hobj]:= iekEllipse;
      ObjWidth[hobj] := 10;
      objHeight[hobj] := 10;
      objBrushColor[hobj] := clMaroon;
      objBrushStyle[hobj] := bsSolid;
      MouseInteractVt:=[miPutEllipse];
    end

  else if SelectButton.Down then
    ImageEnVect1.MouseInteractVt:=[miObjectSelect];
end;

// select the object under the mouse cursor
procedure TMainForm.ImageEnVect1ObjectOver(Sender: TObject; hobj: Integer);
begin
  ImageEnVect1.UnSelAllObjects;
  ImageEnVect1.AddSelObject(hobj);
end;

// an object is selected, change its color
procedure TMainForm.ImageEnVect1SelectObject(Sender: TObject);
var
  i,hobj:integer;
begin
  with ImageEnVect1 do
    for i:=0 to ObjectsCount-1 do
    begin
      hobj := GetObjFromIndex( i );
      if IsSelObject( hobj ) then
        ObjBrushColor[hobj] := clRed
      else
        ObjBrushColor[hobj] := clMaroon;
    end;
end;

end.
