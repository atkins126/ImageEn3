unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImageEnView, VideoCap, ExtCtrls, Buttons, ImageEnProc, Menus,
  ImageEnIO, ComCtrls, IEOpenSaveDlg, hyiedefs, IEVect, ieview, hyieutils,
  iemview;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    ImageEnVideoView1: TImageEnVideoView;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    ComboBox2: TComboBox;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    Button4: TButton;
    ImageEnMView1: TImageEnMView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Saveframes1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    procedure SpeedButton2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ImageEnVideoView1Job(Sender: TObject; job: TIEJob;
      per: Integer);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Saveframes1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    currentBMP:TIEBitmap;
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
  ImageEnVideoView1.OnVideoFrame := ImageEnVideoView1VideoFrame;
  ImageEnVideoView1.ShowVideo := SpeedButton2.Down;
  if ImageEnVideoView1.ShowVideo then
    currentBMP:=TIEBitmap.Create
  else
    currentBMP.free;
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


// gets frame
procedure TForm1.ImageEnVideoView1VideoFrame(Sender: TObject; Bitmap: TIEDibBitmap);
begin
  currentBMP.CopyFromTDibBitmap(Bitmap);
end;


procedure TForm1.DisplayVideoSize;
var
  r: TRect;
begin
  r := ImageEnVideoView1.GetVideoSize;
  Label6.caption := inttostr(r.right + 1) + 'x' + inttostr(r.bottom + 1);
end;

procedure TForm1.FormActivate(Sender: TObject);
var
  q: integer;
begin
  DefGIF_LZWDECOMPFUNC := GIFLZWDecompress;
  DefGIF_LZWCOMPFUNC := GIFLZWCompress;
  DefTIFF_LZWDECOMPFUNC := TIFFLZWDecompress;
  DefTIFF_LZWCOMPFUNC := TIFFLZWCompress;
  for q := 0 to ImageEnVideoView1.VideoSourceList.Count - 1 do
    ComboBox2.Items.Add(ImageEnVideoView1.VideoSourceList[q]);
  ComboBox2.ItemIndex := 0;
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

// get frame
procedure TForm1.Button4Click(Sender: TObject);
var
  i:integer;
begin
  i:=ImageEnMView1.AppendImage;
  ImageEnMView1.SetIEBitmap(i, currentBMP);
end;


procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Saveframes1Click(Sender: TObject);
begin
  with ImageEnMView1.MIO do
    ImageEnMView1.MIO.SaveToFile( ExecuteSaveDialog('','output.tif',false,0,'') );
end;

end.
