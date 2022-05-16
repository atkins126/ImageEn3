unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, ImageEnView, ImageEnProc, hyiedefs, ImageEnIO;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    Effects1: TMenuItem;
    Negative1: TMenuItem;
    ConverttoGray1: TMenuItem;
    FlipHorizontal1: TMenuItem;
    FlipVertical1: TMenuItem;
    Equalize1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Redo1Click(Sender: TObject);
    procedure Negative1Click(Sender: TObject);
    procedure ConverttoGray1Click(Sender: TObject);
    procedure FlipHorizontal1Click(Sender: TObject);
    procedure FlipVertical1Click(Sender: TObject);
    procedure Equalize1Click(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateMenu;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  ImageEnView1.io.LoadFromFile(ImageEnView1.io.ExecuteOpenDialog('', '', false, 1, ''));
  ImageEnView1.proc.ClearAllUndo;
  ImageEnView1.proc.ClearAllRedo;
  UpdateMenu;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ImageEnView1.proc.UndoLimit := 5; // 5 livels of undo
end;

procedure TForm1.Negative1Click(Sender: TObject);
begin
  ImageEnView1.proc.Negative;
  ImageEnView1.proc.ClearAllRedo;
  UpdateMenu;
end;

procedure TForm1.ConverttoGray1Click(Sender: TObject);
begin
  ImageEnView1.proc.ConvertToGray;
  ImageEnView1.proc.ClearAllRedo;
  UpdateMenu;
end;

procedure TForm1.FlipHorizontal1Click(Sender: TObject);
begin
  ImageEnView1.proc.Flip(fdHorizontal);
  ImageEnView1.proc.ClearAllRedo;
  UpdateMenu;
end;

procedure TForm1.FlipVertical1Click(Sender: TObject);
begin
  ImageEnView1.proc.Flip(fdVertical);
  ImageEnView1.proc.ClearAllRedo;
  UpdateMenu;
end;

procedure TForm1.Equalize1Click(Sender: TObject);
begin
  ImageEnView1.proc.HistAutoEqualize;
  ImageEnView1.proc.ClearAllRedo;
  UpdateMenu;
end;

procedure TForm1.Undo1Click(Sender: TObject);
begin
  with ImageEnView1.proc do
  begin
    SaveRedoCaptioned(UndoCaptions[0], ieuImage); // saves in Redo list
    Undo;
    ClearUndo;
  end;
  UpdateMenu;
end;

procedure TForm1.Redo1Click(Sender: TObject);
begin
  with ImageEnView1.proc do
  begin
    SaveUndoCaptioned(RedoCaptions[0], ieuImage); // saves in Undo List
    Redo;
    ClearRedo;
  end;
  UpdateMenu;
end;

procedure TForm1.UpdateMenu;
begin
  with ImageEnView1.proc do
  begin
    // Undo menu
    Undo1.Caption := '&Undo ';
    Undo1.Enabled := UndoCount > 0;
    if UndoCount > 0 then
      Undo1.Caption := '&Undo ' + UndoCaptions[0];
    // Redo menu
    Redo1.Caption := '&Redo ';
    Redo1.Enabled := RedoCount > 0;
    if RedoCount > 0 then
      Redo1.Caption := '&Redo ' + RedoCaptions[0];
  end;
end;

end.
