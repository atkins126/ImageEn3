unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImageEnView, VideoCap, ExtCtrls, Buttons, ImageEnProc, Menus,
  ImageEnIO, ComCtrls, IEOpenSaveDlg, hyiedefs, IEVect, ieview, hyieutils;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    SpeedButton2: TSpeedButton;
    CheckBox1: TCheckBox;
    ImageEnProc1: TImageEnProc;
    ImageEnProc2: TImageEnProc;
    GroupBox2: TGroupBox;
    ImageEnIO1: TImageEnIO;
    ImageEnVideoView1: TImageEnVideoView;
    Label5: TLabel;
    Label6: TLabel;
    SaveImageEnDialog1: TSaveImageEnDialog;
    GroupBox3: TGroupBox;
    SpeedButton6: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Button8: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    UpDown1: TUpDown;
    ImageEnView1: TImageEnView;
    GroupBox4: TGroupBox;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    GroupBox5: TGroupBox;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Button11: TButton;
    GroupBox6: TGroupBox;
    SpeedButton5: TSpeedButton;
    Label7: TLabel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox2: TComboBox;
    procedure SpeedButton2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ImageEnVideoView1Job(Sender: TObject; job: TIEJob;
      per: Integer);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ImageEnVideoView1VideoFrame(Sender: TObject; Bitmap: TIEDibBitmap);
    procedure DisplayVideoSize;
  end;

var
  Form1: TForm1;

implementation

uses giflzw, tiflzw;

{$R *.DFM}

// Input ON

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ImageEnVideoView1.ShowVideo := SpeedButton2.Down;
  Button1.enabled := not SpeedButton2.Down;
  Button2.enabled := not SpeedButton2.Down;
  DisplayVideoSize;
end;

// overlay

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if checkbox1.checked then
    ImageEnVideoView1.DisplayMode := dmOverlay
  else
    ImageEnVideoView1.DisplayMode := dmPreview;
end;

// freeze

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  ImageEnVideoView1.FitFreeze:=false;
  ImageEnVideoView1.Frozen := SpeedButton1.Down;
end;

// Color adjust

procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnProc1.DoPreviews(ppeColorAdjust);
end;

// Effects

procedure TForm1.Button2Click(Sender: TObject);
begin
  ImageEnProc1.DoPreviews(ppeEffects);
end;

// Configure source

procedure TForm1.Button5Click(Sender: TObject);
begin
  if not ImageEnVideoView1.DoConfigureSource then
    MessageDlg('Configure Source dialog not available', mtInformation, [mbOK], 0)
  else
    DisplayVideoSize;
end;

// Configure Format

procedure TForm1.Button6Click(Sender: TObject);
begin
  if not ImageEnVideoView1.DoConfigureFormat then
    MessageDlg('Configure Format dialog not available', mtInformation, [mbOK], 0)
  else
    DisplayVideoSize;
end;

// Configure display

procedure TForm1.Button7Click(Sender: TObject);
begin
  if not ImageEnVideoView1.DoConfigureDisplay then
    MessageDlg('Configure Display dialog not available', mtInformation, [mbOK], 0)
  else
    DisplayVideoSize;
end;

// Frames to ImageEnView1 (Activate button)

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  if SpeedButton5.Down then
    ImageEnVideoView1.OnVideoFrame := ImageEnVideoView1VideoFrame
  else
    ImageEnVideoView1.OnVideoFrame := nil;
end;

// Frames to ImageEnView1 - OnVideoFrame

procedure TForm1.ImageEnVideoView1VideoFrame(Sender: TObject; Bitmap: TIEDibBitmap);
begin
  Bitmap.CopyToTBitmap(ImageEnView1.Bitmap);
  ImageEnView1.Update;
  case ComboBox1.ItemIndex of
    1: ImageEnProc2.ConvertToBWOrdered;
    2: ImageEnProc2.ConvertToBWThreshold(-1);
    3: ImageEnProc2.ConvertToGray;
  end;
  ImageEnView1.Fit;
end;

// Save as...

procedure TForm1.Button11Click(Sender: TObject);
begin
  if SaveImageEnDialog1.Execute then
    ImageEnIO1.SaveToFile(SaveImageEnDialog1.filename);
end;

//

procedure TForm1.DisplayVideoSize;
var
  r: TRect;
begin
  r := ImageEnVideoView1.GetVideoSize;
  Label6.caption := inttostr(r.right + 1) + 'x' + inttostr(r.bottom + 1);
end;

//

procedure TForm1.FormActivate(Sender: TObject);
var
  q: integer;
begin
  DefGIF_LZWDECOMPFUNC := GIFLZWDecompress;
  DefGIF_LZWCOMPFUNC := GIFLZWCompress;
  DefTIFF_LZWDECOMPFUNC := TIFFLZWDecompress;
  DefTIFF_LZWCOMPFUNC := TIFFLZWCompress;
  ComboBox1.ItemIndex := 0;
  Edit1.Text := ImageEnVideoView1.RecFileName;
  UpDown1.Position := ImageEnVideoView1.RecFrameRate;
  for q := 0 to ImageEnVideoView1.VideoSourceList.Count - 1 do
    ComboBox2.Items.Add(ImageEnVideoView1.VideoSourceList[q]);
  ComboBox2.ItemIndex := 0;
end;

// record

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  if SpeedButton6.Down then
  begin
    ImageEnVideoView1.RecFileName := Edit1.Text;
    ImageEnVideoView1.RecFrameRate := UpDown1.Position;
    ImageEnVideoView1.RecAudio := true;
    //ImageEnVideoView1.AudioBitsPerSample:=16;
    //ImageEnVideoView1.AudioSamplesPerSec:=44100;
    //ImageEnVideoView1.AudioChannels:=2;
    //ImageEnVideoView1.AudioFormat:=$55;
    ImageEnVideoView1.StartRecord;
  end
  else
    ImageEnVideoView1.StopRecord;
end;

// Compression

procedure TForm1.Button8Click(Sender: TObject);
begin
  ImageEnVideoView1.DoConfigureCompression;
end;

procedure TForm1.ImageEnVideoView1Job(Sender: TObject; job: TIEJob;
  per: Integer);
begin
  case job of
    iejNOTHING: Label8.Caption := '';
    iejVIDEOCAP_CONNECTING: Label8.Caption := 'Connecting...';
  end;
  Application.ProcessMessages;
end;

// Video input

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  if ImageEnVideoView1.VideoSource <> ComboBox2.ItemIndex then
    ImageEnVideoView1.VideoSource := ComboBox2.ItemIndex;
end;

end.
