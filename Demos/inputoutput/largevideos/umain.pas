unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, imageenio,
  StdCtrls, ExtCtrls, ieview, iemview, ieopensavedlg, imageenview, Buttons;

type
  TMainForm = class(TForm)
    ImageEnMView1: TImageEnMView;
    Panel1: TPanel;
    ButtonInsert1: TButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    ButtonClear: TButton;
    ButtonInsert2: TButton;
    ButtonSave: TButton;
    SaveImageEnDialog1: TSaveImageEnDialog;
    procedure ButtonInsert1Click(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonInsert2Click(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// Insert Video 1
// In this way you have more control and you can choise where insert the video.
procedure TMainForm.ButtonInsert1Click(Sender: TObject);
var
  base,i,framescount:integer;
  filename:string;
begin
  if OpenImageEnDialog1.Execute then
  begin

    filename:=OpenImageEnDialog1.FileName;

    // how many frames has the file?
    framescount:=IEGetFileFramesCount(filename);

    // insert links
    base:=ImageEnMView1.SelectedImage;
    if base<0 then
      base:=0;

    imageenmview1.LockPaint;
    for i:=0 to framescount-1 do
    begin
      ImageEnMView1.InsertImageEx( base + i );
      ImageEnMView1.ImageFileName[ base+i ]:=filename+'::'+inttostr(i);
    end;
    imageenmview1.UnLockPaint;

  end;
end;

// Insert Video 2
// This is a simple way to load a large file on demand using LoadFromFileOnDemand.
// The difference is that LoadFromFileOnDemand removes all images and you cannot choise where to insert the video.
procedure TMainForm.ButtonInsert2Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
    ImageEnMView1.LoadFromFileOnDemand( OpenImageEnDialog1.FileName );
end;

// Clear
procedure TMainForm.ButtonClearClick(Sender: TObject);
begin
  ImageEnMView1.Clear;
end;

// Save
procedure TMainForm.ButtonSaveClick(Sender: TObject);
begin
  if SaveImageEnDialog1.Execute then
    ImageEnMView1.MIO.SaveToFile( SaveImageEnDialog1.FileName );
end;

end.
