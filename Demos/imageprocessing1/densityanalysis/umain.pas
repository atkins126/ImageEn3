unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, ImageEnView;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    Button1: TButton;
    ImageEnView2: TImageEnView;
    ImageEnView3: TImageEnView;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses hyiedefs;

{$R *.DFM}

// open...

procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnView1.io.LoadFromFile(ImageEnView1.io.ExecuteOpenDialog('', '', false, 1, ''));
  ImageEnView2.Clear;
  ImageEnView3.Clear;
end;

// histograms

procedure TForm1.Button2Click(Sender: TObject);
var
  VertHist, HorizHist: pintegerarray; // from Delphi 4 VertHist and HorizHist can be dynamic arrays
  VertHistHeight, HorizHistWidth, VertHistWidth, HorizHistHeight: integer;
  i: integer;
begin
  VertHistWidth := ImageEnView3.ClientWidth;
  VertHistHeight := ImageEnView1.Bitmap.Height;
  HorizHistWidth := ImageEnView1.Bitmap.Width;
  HorizHistHeight := ImageEnView2.ClientHeight;
  getmem(VertHist, VertHistHeight * sizeof(integer));
  getmem(HorizHist, HorizHistWidth * sizeof(integer));
  ImageEnView1.proc.CalcDensityHistogram(VertHist, HorizHist, VertHistWidth, HorizHistHeight);
  // horizontal
  ImageEnView2.Bitmap.Height := HorizHistHeight;
  ImageEnView2.Bitmap.Width := HorizHistWidth;
  // vertical
  ImageEnView3.Bitmap.Height := VertHistHeight;
  ImageEnView3.Bitmap.Width := VertHistWidth;
  // draw histograms
  ImageEnView2.Bitmap.Canvas.Pen.Color := clBlack;
  ImageEnView3.Bitmap.Canvas.Pen.Color := clBlack;
  for i := 0 to HorizHistWidth - 1 do
  begin
    ImageEnView2.Bitmap.Canvas.MoveTo(i, HorizHistHeight);
    ImageEnView2.Bitmap.Canvas.LineTo(i, HorizHistHeight - HorizHist[i]);
  end;
  for i := 0 to VertHistHeight - 1 do
  begin
    ImageEnView3.Bitmap.Canvas.MoveTo(0, i);
    ImageEnView3.Bitmap.Canvas.LineTo(VertHist[i], i);
  end;
  ImageEnView2.Update;
  ImageEnView3.Update;
  //
  freemem(VertHist);
  freemem(HorizHist);
end;

end.
