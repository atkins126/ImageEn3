unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  imageenview, ExtCtrls, ieview, iemview, StdCtrls, ComCtrls, imageenproc, hyiedefs, hyieutils,
  ieopensavedlg, imageenio, iemio, Buttons;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    ImageEnMView1: TImageEnMView;
    ImageEnView1: TImageEnView;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    OpenImageEnDialog1: TOpenImageEnDialog;
    Button2: TButton;
    SpeedButton1: TSpeedButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure OpenImageEnDialog1PreviewFile(Sender, Viewer: TObject;
      FileName: String; ParamsOnly: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ImageEnMView1PlayFrame(Sender: TObject; frameIndex: Integer);
    procedure ImageEnMView1FinishWork(Sender: TObject);
    procedure ImageEnMView1Progress(Sender: TObject; per: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// Open...
procedure TMainForm.Button1Click(Sender: TObject);
var
  fn:string;
  tags:TIEDICOMTags;
begin
  if OpenImageEnDialog1.Execute then
  begin
    fn:=OpenImageEnDialog1.FileName;
    Caption:=fn;

    ImageEnMView1.Clear;
    ImageEnView1.Blank;

    // allow multiselecting
    if pos('|',fn)>0 then
      ImageEnMView1.MIO.LoadFromFiles( fn )
    else
      ImageEnMView1.MIO.LoadFromFileAuto( fn );
    // this last case allows to try load unrecognized DICOMs (also without extension)
    if ImageEnMView1.MIO.Aborting then
      ImageEnMView1.MIO.LoadFromFileDICOM( fn );

    ImageEnMView1.SelectedImage:=0;
    ImageEnMView1ImageSelect(self,0);
    ImageEnView1.Fit;
    TrackBar1.Position:=trunc(ImageEnView1.Zoom);

    // fill image info
    if ImageEnMView1.ImageCount > 0 then
    begin
      tags:=ImageEnMView1.MIO.Params[0].DICOM_Tags;
      Label3.Caption  := tags.GetTagString( tags.IndexOf($0008,$0008) );
      Label4.Caption  := tags.GetTagString( tags.IndexOf($0008,$0022) );
      Label7.Caption  := tags.GetTagString( tags.IndexOf($0008,$0032) );
      Label9.Caption  := tags.GetTagString( tags.IndexOf($0008,$0104) );
      Label10.Caption := tags.GetTagString( tags.IndexOf($0010,$0010) );
    end;
  end;
end;

procedure TMainForm.ImageEnMView1ImageSelect(Sender: TObject;
  idx: Integer);
begin
  if idx < ImageEnMView1.ImageCount then
  begin
    ImageEnMView1.CopyToIEBitmap( idx, ImageEnView1.IEBitmap );
    ImageEnView1.IEBitmap.PixelFormat:=ie24RGB; // necessary only when ZoomFilter<>rfNone
    ImageEnView1.Update;
  end;
end;

// Zoom
procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.Zoom:=TrackBar1.Position;
end;

// Filtered
procedure TMainForm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    ImageEnView1.ZoomFilter:=rfTriangle
  else
    ImageEnView1.ZoomFilter:=rfNone;
end;

// a file is previewed
// needed because some dicoms aren't recognized automatically, so we force to load dicoms when a file is not detected
procedure TMainForm.OpenImageEnDialog1PreviewFile(Sender, Viewer: TObject; FileName: String; ParamsOnly: Boolean);
var
  io:TImageEnIO;
  mio:TImageEnMIO;
begin
  io:=nil;
  mio:=nil;

  if Viewer is TImageEnView then
    io:=(Viewer as TImageEnView).IO
  else
    mio:=(Viewer as TImageEnMView).MIO;
    
  if ParamsOnly and assigned(io) then
  begin
    io.ParamsFromFile(FileName);
    if io.Aborting then
      io.ParamsFromFileFormat(FileName,ioDICOM);
  end
  else if assigned(io) then
  begin
    io.LoadFromFileAuto(FileName);
    if io.Aborting then
      io.LoadFromFileDICOM(FileName);
  end
  else if assigned(mio) then
  begin
    mio.LoadFromFileAuto(FileName);
    if mio.Aborting then
      mio.LoadFromFileDICOM(FileName);
  end;
end;

// Save
procedure TMainForm.Button2Click(Sender: TObject);
var
  i:integer;
begin
  // set output pixel format to 24 bit
  ImageEnMView1.MIO.Params[0].SamplesPerPixel:=3;
  ImageEnMView1.MIO.Params[0].BitsPerSample:=8;
  ImageEnMView1.MIO.DuplicateCompressionInfo;
  for i:=0 to ImageEnMView1.ImageCount-1 do
  begin
    ImageEnMView1.GetTIEBitmap(i).PixelFormat:=ie24RGB;
    ImageEnMView1.ReleaseBitmap(i);
  end;
  with ImageEnMView1.MIO do
    SaveToFile( ExecuteSaveDialog );
end;

// Animate
procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  ImageEnMView1.Playing := SpeedButton1.Down;
end;

// playing...copy frame to ImageEnView
procedure TMainForm.ImageEnMView1PlayFrame(Sender: TObject;
  frameIndex: Integer);
begin
  ImageEnMView1.CopyToIEBitmap( frameIndex, ImageEnView1.IEBitmap );
  ImageEnView1.Update;
end;

procedure TMainForm.ImageEnMView1FinishWork(Sender: TObject);
begin
  ProgressBar1.Position := 0;
end;

procedure TMainForm.ImageEnMView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

end.
