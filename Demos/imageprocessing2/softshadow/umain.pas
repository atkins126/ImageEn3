unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ieview, imageenview, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label3: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Edit4: TMenuItem;
    Background1: TMenuItem;
    ColorDialog1: TColorDialog;
    procedure Button1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Background1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses imageenproc;

{$R *.DFM}

// Apply

procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnView1.Proc.Undo; // get original image
  ImageEnView1.Proc.AddSoftShadow(StrToFloat(Edit1.text),
    StrToIntDef(Edit2.Text, 0),
    StrToIntDef(Edit3.text, 0), true, clBlack);
end;

// File Open

procedure TForm1.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));
  ImageEnView1.Proc.SaveUndo(ieuImage); // save image in undo list (to allow multiple changes of shadow parameters)
end;

// File Save

procedure TForm1.Save1Click(Sender: TObject);
var
  filename, ext: string;
begin
  filename := ImageEnView1.Io.ExecuteSaveDialog('', '', false, 0, '');
  if filename <> '' then
  begin
    ext := lowercase(ExtractFileExt(filename));
    if not ((ext = '.png') or (ext = '.tga')) then
    begin
      // alpha channel not supported by jpeg, bmp, etc...we need to merge alpha
      ImageEnView1.Proc.SaveUndo(ieuImage); // save all
      ImageEnView1.RemoveAlphaChannel(true); // remove alpha channel
      ImageEnView1.IO.SaveToFile(filename);
      ImageEnView1.Proc.Undo; // reget alpha channel
    end
    else
      // alpha channel supported, just save
      ImageEnView1.IO.SaveToFile(filename);
  end;
end;

// change background

procedure TForm1.Background1Click(Sender: TObject);
begin
  ColorDialog1.Color := ImageEnView1.Background;
  if ColorDialog1.Execute then
    ImageEnView1.Background := ColorDialog1.Color;
end;

end.
