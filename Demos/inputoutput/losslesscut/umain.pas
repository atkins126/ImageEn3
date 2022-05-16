unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, ImageEnView, ImageEnIO;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    ImageEnView1: TImageEnView;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    sourceFile: string;
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
  sourceFile := ImageEnView1.IO.ExecuteOpenDialog('', '', false, 3, '');
  ImageEnView1.IO.LoadFromFile(sourceFile);
end;

// Save...
// (not save, just apply a cut to source file)

procedure TForm1.Button2Click(Sender: TObject);
var
  rc: TRect;
  destFile: string;
begin
  // request destination file
  destFile := ImageEnView1.IO.ExecuteSaveDialog('', 'out.jpg', false, 2, '');
  if destFile <> '' then
  begin
    // get cut rectangle
    with ImageEnView1 do
      rc := Rect(SelX1, SelY1, SelX2, SelY2);
    // apply lossless cut and save
    JpegLosslessTransform(sourceFile, destFile, jtCut, false, jcCopyAll, rc);
  end;
end;

end.
