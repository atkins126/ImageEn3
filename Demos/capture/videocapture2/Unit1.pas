unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ImageEnView, StdCtrls, ExtCtrls, ImageEnProc,
  ComCtrls, ieview, hvideocap, hyieutils;

type
  TForm1 = class(TForm)
    ImageEnVideoCap1: TImageEnVideoCap;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    ImageEnView1: TImageEnView;
    ImageEnProc1: TImageEnProc;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    Bevel1: TBevel;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Bevel2: TBevel;
    SpeedButton4: TSpeedButton;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel3: TBevel;
    Label7: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label8: TLabel;
    UpDown1: TUpDown;
    SpeedButton5: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ImageEnVideoCap1VideoFrame(Sender: TObject; Bitmap: TIEDibBitmap);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
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

procedure TForm1.ImageEnVideoCap1VideoFrame(Sender: TObject;
  Bitmap: TIEDibBitmap);
begin
  Bitmap.CopyToTBitmap(ImageEnView1.Bitmap);
  ImageEnView1.Update;
  if SpeedButton2.Down then
    ImageEnProc1.Negative;
  if SpeedButton3.Down then
    ImageEnProc1.IntensityRGBall(trackbar1.Position, trackbar2.Position, trackbar3.Position);
  if SpeedButton4.Down then
    ImageEnProc1.HSVvar(trackbar4.Position, trackbar5.Position, trackbar6.Position);
  if ComboBox1.ItemIndex > 0 then
    ImageEnView1.ZoomFilter := TResampleFilter(ComboBox1.ItemIndex)
  else
    ImageEnView1.ZoomFilter := rfNone;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnVideoCap1.DoConfigureFormat;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Down then
  begin
    ImageEnVideoCap1.VideoSource := UpDown1.Position;
    ImageEnVideoCap1.Capture := true;
  end
  else
    ImageEnVideoCap1.Capture := false;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
end;

// Record
procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  if SpeedButton5.Down then
  begin
    if ImageEnVideoCap1.Capture then
    begin
      ShowMessage('Please press "Record" before "Capture"!');
      SpeedButton5.Down:=false;
    end
    else
    begin
      ImageEnVideoCap1.RecFileName := 'Capture.avi';
      ImageEnVideoCap1.StartRecord;
    end;
  end
  else
    ImageEnVideoCap1.StopRecord;
end;

end.
