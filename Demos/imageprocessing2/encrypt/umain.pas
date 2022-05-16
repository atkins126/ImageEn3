unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    ImageEnView1: TImageEnView;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    StatusBar1: TStatusBar;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
    procedure ImageEnView1FinishWork(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// Open...
procedure TForm1.Button1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFileAuto( ExecuteOpenDialog );
end;

// Encrypt
procedure TForm1.Button3Click(Sender: TObject);
begin
  ImageEnView1.Proc.Encrypt( Edit1.Text );
end;

// Decrypt
procedure TForm1.Button4Click(Sender: TObject);
begin
  ImageEnView1.Proc.Decrypt( Edit1.Text );
end;

// Save
procedure TForm1.Button2Click(Sender: TObject);
var
  filename:string;
begin
  filename:=ImageEnView1.IO.ExecuteSaveDialog;
  ImageEnView1.IO.SaveToFile( filename );
end;

procedure TForm1.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position:=per;
end;

procedure TForm1.ImageEnView1FinishWork(Sender: TObject);
begin
  ProgressBar1.Position:=0;
end;

end.
