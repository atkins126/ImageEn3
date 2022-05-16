unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,imageenproc, StdCtrls, iemview, ieview, imageenview, ievect, hyiedefs,
  ComCtrls, hyieutils, Buttons, ExtCtrls, XPMan;

type
  TMainForm = class(TForm)
    SourceView: TImageEnVect;
    ImageEnMView1: TImageEnMView;
    Label1: TLabel;
    Label2: TLabel;
    TargetView: TImageEnVect;
    LoadSourceButton: TButton;
    LoadTargetButton: TButton;
    SaveLinesButton: TButton;
    CreateSequenceButton: TButton;
    Label3: TLabel;
    Edit1: TEdit;
    FramesCount: TUpDown;
    AddLinesButton: TSpeedButton;
    EditLinesButton: TSpeedButton;
    ImageEnView1: TImageEnView;
    CurrentFrame: TScrollBar;
    Label4: TLabel;
    Timer1: TTimer;
    XPManifest1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure LoadSourceButtonClick(Sender: TObject);
    procedure LoadTargetButtonClick(Sender: TObject);
    procedure SaveLinesButtonClick(Sender: TObject);
    procedure SourceViewNewObject(Sender: TObject; hobj: Integer);
    procedure SourceViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SourceViewSelectObject(Sender: TObject);
    procedure TargetViewNewObject(Sender: TObject; hobj: Integer);
    procedure TargetViewSelectObject(Sender: TObject);
    procedure CreateSequenceButtonClick(Sender: TObject);
    procedure EditLinesButtonClick(Sender: TObject);
    procedure AddLinesButtonClick(Sender: TObject);
    procedure CurrentFrameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sourcefilename,targetfilename:string;
    selecting:boolean;
    procedure Load(vect:TImageEnVect; const filename:string);
  end;

var
  MainForm: TMainForm;

implementation

uses umsg;

{$R *.dfm}

procedure InitVect(vect:TImageEnVect);
begin
  with vect do
  begin
    // prepare a template object
    MouseInteractVt:=[miPutLine];
    ObjPenColor[-1]:=clRed;
    ObjPenWidth[-1]:=2;
    ObjGripPen.Color:=clYellow;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  selecting:=false;

  InitVect(SourceView);
  InitVect(TargetView);

  ImageEnMView1.SoftShadow.Enabled:=true;

  AddLinesButton.Down:=true;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  // demo sequence
  sourcefilename:='1.jpg';
  targetfilename:='2.jpg';
  Load(SourceView,sourcefilename);
  Load(TargetView,targetfilename);
  fmsg.Show;
  application.processmessages;
  CreateSequenceButtonClick(self);
  fmsg.Hide;
  // start sequence animation
  timer1.enabled:=true;
end;

// generic load image and vectorial objects
procedure TMainForm.Load(vect:TImageEnVect; const filename:string);
begin
  if filename<>'' then
  begin
    vect.IO.LoadFromFile(filename);
    if fileexists( filename+'.iev' ) then
      vect.LoadFromFileIEV(filename+'.iev');
  end;
end;

// Load source image
procedure TMainForm.LoadSourceButtonClick(Sender: TObject);
begin
  sourcefilename := SourceView.IO.ExecuteOpenDialog();
  Load(SourceView,sourcefilename);
end;

// Load target image
procedure TMainForm.LoadTargetButtonClick(Sender: TObject);
begin
  targetfilename := TargetView.IO.ExecuteOpenDialog();
  Load(TargetView,targetfilename);
end;

// Save lines
procedure TMainForm.SaveLinesButtonClick(Sender: TObject);
begin
  SourceView.SaveToFileIEV(sourcefilename+'.iev');
  TargetView.SaveToFileIEV(targetfilename+'.iev');
end;

// added new object to the source viewer, sync with target viewer
procedure TMainForm.SourceViewNewObject(Sender: TObject; hobj: Integer);
begin
  SourceView.CopyObjectTo(hobj, TargetView);
  TargetView.UnSelAllObjects;
end;

// added new object to the target viewer, sync with source viewer
procedure TMainForm.TargetViewNewObject(Sender: TObject; hobj: Integer);
begin
  TargetView.CopyObjectTo(hobj, SourceView);
  SourceView.UnSelAllObjects;
end;

// handle DEL key
procedure TMainForm.SourceViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=46 then
  begin
    // pressing delete key
    selecting:=true;
    while SourceView.SelObjectsCount>0 do
      SourceView.RemoveObject(SourceView.SelObjects[0]);
    while TargetView.SelObjectsCount>0 do
      TargetView.RemoveObject(TargetView.SelObjects[0]);
    selecting:=false;
  end;
end;

// Select objects on source image
procedure TMainForm.SourceViewSelectObject(Sender: TObject);
var
  i:integer;
begin
  if selecting then
    exit;
  // sync target view
  selecting:=true;
  TargetView.UnSelAllObjects;
  for i:=0 to SourceView.SelObjectsCount-1 do
    TargetView.AddSelObject(SourceView.SelObjects[i]);
  selecting:=false;
end;

// select objects on target image
procedure TMainForm.TargetViewSelectObject(Sender: TObject);
var
  i:integer;
begin
  if selecting then
    exit;
  // sync source view
  selecting:=true;
  SourceView.UnSelAllObjects;
  for i:=0 to TargetView.SelObjectsCount-1 do
    SourceView.AddSelObject(TargetView.SelObjects[i]);
  selecting:=false;
end;

// edit lines button
procedure TMainForm.EditLinesButtonClick(Sender: TObject);
begin
  if EditLinesButton.Down then
  begin
    SourceView.MouseInteractVt:=[miObjectSelect];
    TargetView.MouseInteractVt:=[miObjectSelect];
  end;
end;

// add lines button
procedure TMainForm.AddLinesButtonClick(Sender: TObject);
begin
  if AddLinesButton.Down then
  begin
    SourceView.MouseInteractVt:=[miPutLine];
    TargetView.MouseInteractVt:=[miPutLine];
  end;
end;

// Change CurrentFrame scrollbar
procedure TMainForm.CurrentFrameChange(Sender: TObject);
begin
  ImageEnMView1.CopyToIEBitmap( CurrentFrame.Position,  ImageEnView1.IEBitmap );
  ImageenView1.Update;
end;

// used only to show initial animation
procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  if CurrentFrame.position=ImageEnMView1.ImageCount-1 then
    Timer1.Enabled:=false
  else
    CurrentFrame.Position:=CurrentFrame.Position+1;
end;

procedure TMainForm.CreateSequenceButtonClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;

  ImageEnMView1.Clear;
  ImageEnMView1.CreateMorphingSequence(SourceView,TargetView,FramesCount.Position);

  CurrentFrame.Max:=FramesCount.Position;
  CurrentFrame.Position:=0;
  CurrentFrameChange(self);

  Screen.Cursor:=crdefault;
end;



end.
