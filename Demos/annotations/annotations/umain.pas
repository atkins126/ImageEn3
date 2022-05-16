unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ieview, imageenview, ievect, Buttons, XPMan, StdCtrls;

type
  Tfmain = class(TForm)
    ImageEnVect1: TImageEnVect;
    Panel2: TPanel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Bevel1: TBevel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Bevel2: TBevel;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Bevel3: TBevel;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    Bevel4: TBevel;
    SpeedButton16: TSpeedButton;
    Bevel5: TBevel;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    XPManifest1: TXPManifest;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrentFile: string;
  end;

var
  fmain: Tfmain;

implementation

uses imageenio, imageenproc;

{$R *.DFM}


// Zoom +

procedure Tfmain.SpeedButton1Click(Sender: TObject);
begin
  ImageEnVect1.Zoom := ImageEnVect1.Zoom * 2;
end;

// Zoom -

procedure Tfmain.SpeedButton2Click(Sender: TObject);
begin
  ImageEnVect1.Zoom := ImageEnVect1.Zoom / 2;
end;

// Select annotations

procedure Tfmain.SpeedButton3Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miObjectSelect];
end;

// Fit to Window

procedure Tfmain.SpeedButton4Click(Sender: TObject);
begin
  ImageEnVect1.Fit;
end;

// Effective size

procedure Tfmain.SpeedButton5Click(Sender: TObject);
begin
  ImageEnVect1.Zoom := 100;
end;

// New freehand annotation

procedure Tfmain.SpeedButton6Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miPutPolyLine];
end;

// New highlight annotation

procedure Tfmain.SpeedButton7Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miPutBox];
  ImageEnVect1.ObjBoxHighlight[-1] := true;
  ImageEnVect1.ObjBrushColor[-1] := clYellow;
  ImageEnVect1.ObjBrushStyle[-1] := bsSolid;
end;

// occurs after an object is inserted

procedure Tfmain.ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
begin
  ImageEnVect1.MouseInteractVt := [miObjectSelect];
end;

// New line annotation

procedure Tfmain.SpeedButton8Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miPutLine];
end;

// New box annotation

procedure Tfmain.SpeedButton9Click(Sender: TObject);
begin
  ImageEnVect1.ObjBoxHighlight[-1] := false;
  ImageEnVect1.ObjBrushStyle[-1] := bsClear;
  ImageEnVect1.ObjMemoCharsBrushStyle[-1] := bsClear;
  ImageEnVect1.MouseInteractVt := [miPutBox];
end;

// New filled box annotation

procedure Tfmain.SpeedButton10Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miPutBox];
  ImageEnVect1.ObjBoxHighlight[-1] := false;
  ImageEnVect1.ObjBrushColor[-1] := clYellow;
  ImageEnVect1.ObjBrushStyle[-1] := bsSolid;
end;

// New text annotation

procedure Tfmain.SpeedButton11Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miPutMemo];
  ImageEnVect1.ObjBrushStyle[-1] := bsClear;
  ImageEnVect1.ObjMemoCharsBrushStyle[-1] := bsClear;
  ImageEnVect1.ObjMemoBorderStyle[-1] := psClear;
end;

// New notes annotation

procedure Tfmain.SpeedButton12Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miPutMemo];
  ImageEnVect1.ObjBrushColor[-1] := clYellow;
  ImageEnVect1.ObjBrushStyle[-1] := bsSolid;
  ImageEnVect1.ObjMemoCharsBrushStyle[-1] := bsSolid;
  ImageEnVect1.ObjMemoBorderStyle[-1] := psSolid;
end;

// Delete selected annotation(s)

procedure Tfmain.SpeedButton13Click(Sender: TObject);
var
  i: integer;
begin
  for i := ImageEnVect1.SelObjectsCount - 1 downto 0 do
    ImageEnVect1.RemoveObject(ImageEnVect1.SelObjects[i]);
end;

// Print

procedure Tfmain.SpeedButton14Click(Sender: TObject);
begin
  ImageEnVect1.Proc.SaveUndo(ieuImage);
  ImageEnVect1.CopyObjectsToBack(false); // true if you want antialias
  ImageEnVect1.IO.DoPrintPreviewDialog(iedtDialog, CurrentFile);
  ImageEnVect1.Proc.Undo; // this removes painted annotations
end;

// Save

procedure Tfmain.SpeedButton15Click(Sender: TObject);
var
  fn: string;
begin
  ImageEnVect1.IO.Params.ImagingAnnot.CopyFromTImageEnVect(ImageEnVect1);
  fn := ImageEnVect1.IO.ExecuteSaveDialog('', CurrentFile, false, 1, '');
  if fn <> '' then
  begin
    CurrentFile := fn;
    Caption := fn;
    ImageEnVect1.IO.SaveToFile(CurrentFile);
  end;
end;

procedure Tfmain.SpeedButton16Click(Sender: TObject);
var
  fn: string;
begin
  fn := ImageEnVect1.IO.ExecuteOpenDialog('', '', false, 1, '');
  if fn <> '' then
  begin
    CurrentFile := fn;
    Caption := fn;
    // load image
    ImageEnVect1.IO.LoadFromFile(fn);
    ImageEnvect1.Fit;
    // load annotations
    ImageEnVect1.RemoveAllObjects;
    ImageEnVect1.IO.Params.ImagingAnnot.CopyToTImageEnVect(ImageEnVect1);
  end;
end;

procedure Tfmain.FormResize(Sender: TObject);
begin
  Panel1.Left := (Panel2.Width - Panel1.Width) div 2;
end;

procedure Tfmain.FormPaint(Sender: TObject);
begin
  Panel1.Left := (Panel2.Width - Panel1.Width) div 2;
end;

// Rotate Right
procedure Tfmain.SpeedButton17Click(Sender: TObject);
begin
  ImageEnVect1.RotateAllObjects(270,ierImage);
  ImageEnVect1.Proc.Rotate(270);
end;

// Rotate Left
procedure Tfmain.SpeedButton18Click(Sender: TObject);
begin
  ImageEnVect1.RotateAllObjects(90,ierImage);
  ImageEnVect1.Proc.Rotate(90);
end;


end.
