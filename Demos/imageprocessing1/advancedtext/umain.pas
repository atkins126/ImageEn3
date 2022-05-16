unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ievect, ImgList, ComCtrls, StdCtrls, ToolWin;

type
  Tfmain = class(TForm)
    ImageEnVect1: TImageEnVect;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    StandardToolBar: TToolBar;
    OpenButton: TToolButton;
    ToolButton10: TToolButton;
    ToolbarImages: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Saveas1: TMenuItem;
    N2: TMenuItem;
    Print1: TMenuItem;
    ToolButton3: TToolButton;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ImageEnVect1ActivateTextEdit(Sender: TObject);
    procedure ImageEnVect1DeactivateTextEdit(Sender: TObject);
    procedure ImageEnVect1TextKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ImageEnVect1TextEditCursorMoved(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmain: Tfmain;

implementation

uses utext;

{$R *.DFM}

// File | Exit
procedure Tfmain.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open
procedure Tfmain.Open1Click(Sender: TObject);
begin
  with ImageEnVect1.IO do
    LoadFromFile( ExecuteOpenDialog('','',false,1,'') );
end;

// Insert text
procedure Tfmain.ToolButton1Click(Sender: TObject);
var
  tmpFont:TFont;
begin
  if ToolButton1.Down then
  begin
    ImageEnVect1.MouseInteractVt:=[miPutMemo];
    ImageEnVect1.ObjFontLocked[-1]:=false;
    ImageEnVect1.ObjMemoBorderStyle[-1]:=psClear;
    tmpFont:=TFont.Create;
    tmpFont.Color:=clRed;
    tmpFont.Size:=14;
    tmpFont.Name:='Arial';
    ImageEnVect1.SetObjFont(-1,tmpFont);
    tmpFont.Free;
  end
  else
    ImageEnVect1.MouseInteractVt:=[miObjectSelect];
end;

// text editing mode
procedure Tfmain.ImageEnVect1ActivateTextEdit(Sender: TObject);
begin
  fText.Text2Controls;
  fText.Show;
  ImageEnVect1.SetFocus;
end;

// out of text editing mode
procedure Tfmain.ImageEnVect1DeactivateTextEdit(Sender: TObject);
begin
  fText.Hide;
end;

// press a key on the text edit
procedure Tfmain.ImageEnVect1TextKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fText.Text2Controls;
end;

// cursor moved (by mouse movement) in text edit
procedure Tfmain.ImageEnVect1TextEditCursorMoved(Sender: TObject);
begin
  fText.Text2Controls;
end;

// File | Save as...
procedure Tfmain.Saveas1Click(Sender: TObject);
var
  filename:string;
begin
  filename:=ImageEnVect1.IO.ExecuteSaveDialog();
  if filename<>'' then
  begin
    // save the image without vectorial objects
    ImageEnVect1.Proc.SaveUndo;
    // merge vectorial objects with the background image
    ImageEnVect1.CopyObjectsToBack(true);
    // save to disk
    ImageEnVect1.IO.SaveToFile(filename);
    // restore
    ImageEnvect1.Proc.Undo;
  end;
end;

// File | Print...
procedure Tfmain.Print1Click(Sender: TObject);
begin
  // save the image without vectorial objects
  ImageEnVect1.Proc.SaveUndo;
  // merge vectorial objects with the background image
  ImageEnVect1.CopyObjectsToBack(true);
  // do print preview
  ImageEnVect1.IO.DoPrintPreviewDialog();
  // restore
  ImageEnvect1.Proc.Undo;
end;

// enable/disable shadow
end.
