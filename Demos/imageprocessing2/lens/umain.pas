unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ieview, imageenview, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
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
    LoadFromFile( ExecuteOpenDialog );
  ImageEnView1.Proc.SaveUndo;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Edit1.Text := floattostr( TrackBar1.Position/50 );
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  w,h:integer;
  v:double;
begin
  ImageEnView1.Proc.Undo;
  w:=ImageEnView1.IEBitmap.Width div 2;
  h:=ImageEnView1.IEBitmap.Height div 2;
  v:=StrToFloat(Edit1.Text);
  ImageEnView1.Proc.Lens(w,h, w,h, v);
end;

end.
