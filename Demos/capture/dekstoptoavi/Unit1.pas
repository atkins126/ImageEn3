unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, iemview, ExtCtrls, ImageEnView, ImageEnIO, hyieutils, hyiedefs;

type
  TForm1 = class(TForm)
    ImageEnMView1: TImageEnMView;
    Timer1: TTimer;
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    hiddenView: TImageEnView;
  end;

var
  Form1: TForm1;

implementation

uses fplay;

{$R *.DFM}

// record/stop

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Timer1.Enabled then
  begin
    // we have to stop
    hiddenView.IO.CloseAVIFile;
    Timer1.Enabled := false;
    Button1.Caption := 'Record';
    hiddenView.Free;
    ImageEnMView1.MIO.LoadFromFile(Edit1.Text);
  end
  else
  begin
    // we have to start
    hiddenView := TImageEnView.Create(nil);
    hiddenView.IO.CreateAVIFile(Edit1.Text, 1, 'cvid'); // cinepak compressor
    Timer1.Enabled := true;
    Button1.Caption := 'Stop';
    WindowState := wsMinimized;
    DeleteFile(Edit1.Text);
  end;
end;

// capture a frame

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  hiddenView.IO.CaptureFromScreen(iecsScreen, 0);
  hiddenView.IO.Params.BitsPerSample := 8;
  hiddenView.IO.Params.SamplesPerPixel := 3;
  hiddenView.IO.SaveToAVI;
end;

procedure TForm1.Splitter1Moved(Sender: TObject);
begin
  ImageEnMView1.ThumbWidth := ImageEnMView1.Width - 10;
  ImageEnMView1.ThumbHeight := ImageEnMView1.Width - 10;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  ImageEnMView1.BackgroundStyle := iebsGradient;
  ImageEnMView1.GradientEndColor := clWhite;
  ImageEnMView1.EnableAlphaChannel := true;
  ImageEnMView1.SoftShadow.Enabled := true;
  ImageEnMView1.FillThumbnail := false;
  ImageEnMView1.ThumbnailDisplayFilter := rfFastLinear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ffplay.ImageEnMView1.MIO.LoadFromFile(Edit1.Text);
  ffplay.ImageEnMView1.Playing := true;
  ffplay.Show;
end;

end.
