unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, Buttons, ieds, ComCtrls, ExtCtrls, Menus,
  iemview;

type
  Tfmain = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    Label5: TLabel;
    Label8: TLabel;
    ComboBox2: TComboBox;
    Button3: TButton;
    Edit4: TEdit;
    SpeedButton1: TSpeedButton;
    ImageEnView1: TImageEnView;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Edit1: TEdit;
    Button4: TButton;
    procedure FormActivate(Sender: TObject);
    procedure ImageEnView1DShowNewFrame(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    fOutputFile:TFileStream;
    fPosFile:TFileStream;
  public
    { Public declarations }
    procedure Connect;
    procedure Disconnect;
    procedure ShowVideoFormats;
  end;

var
  fmain: Tfmain;

implementation

uses imageenio;

{$R *.DFM}

procedure Tfmain.FormActivate(Sender: TObject);
begin

  // Fill video source combobox
  ComboBox1.Items.Assign(ImageEnView1.IO.DShowParams.VideoInputs);

  // Select first item
  ComboBox1.ItemIndex := 0;

  ShowVideoFormats;

end;

// We have got a new frame

procedure Tfmain.ImageEnView1DShowNewFrame(Sender: TObject);
var
  p:int64;
begin
  // copy current sample to ImageEnView bitmap
  ImageEnView1.IO.DShowParams.GetSample(ImageEnView1.IEBitmap);

  // refresh ImageEnView1
  ImageEnView1.Update;

  // capturing jpegs
  if SpeedButton2.Down then
  begin
    p:=fOutputFile.Position;
    fPosFile.Write(p,sizeof(p));
    ImageEnView1.IO.SaveToStreamJpeg( fOutputFile );
  end;
end;

procedure Tfmain.Connect;
begin
  if (not ImageEnView1.IO.DShowParams.Connected) then
  begin
    // set video source as index of IO.DShowParams.VideoInputs
    ImageEnView1.IO.DShowParams.SetVideoInput(ComboBox1.ItemIndex, StrToIntDef(edit4.Text,0)); // set the second parameter if you have more than one camera with same name
    // enable frame grabbing
    ImageEnView1.IO.DShowParams.EnableSampleGrabber := true;

    // connect to the video input
    ImageEnView1.IO.DShowParams.Connect;
  end;
end;

procedure Tfmain.Disconnect;
begin
  // stop and disconnect
  ImageEnView1.IO.DShowParams.Disconnect;
end;

// Capture button

procedure Tfmain.SpeedButton1Click(Sender: TObject);
var
  w, h: integer;
begin
  if SpeedButton1.Down then
  begin
    Connect;
    // set video size
    w := ImageEnView1.IO.DShowParams.VideoFormats[ ListBox1.ItemIndex ].MaxWidth;
    h := ImageEnView1.IO.DShowParams.VideoFormats[ ListBox1.ItemIndex ].MaxHeight;
    ImageEnView1.IO.DShowParams.SetCurrentVideoFormat(w, h);
    // start capture
    ImageEnView1.IO.DShowParams.Run;
  end
  else
    Disconnect;
  SpeedButton2.Enabled:=SpeedButton1.Down;
end;

// video dialog

procedure Tfmain.Button1Click(Sender: TObject);
begin
  Connect;
  ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInput, ietFilter,false);
end;

// Video source dialog

procedure Tfmain.Button3Click(Sender: TObject);
begin
  Connect;
  ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInputSource, ietFilter,false);
end;

// format dialog

procedure Tfmain.Button2Click(Sender: TObject);
begin
  Connect;
  ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInput, ietOutput, false);
end;

procedure Tfmain.ShowVideoFormats;
var
  i: integer;
  s: string;
begin
  Connect;

  // fills video formats list box
  ListBox1.Clear;
  with ImageEnView1.IO.DShowParams do
    for i := 0 to VideoFormatsCount - 1 do
    begin
      with VideoFormats[i] do
        s := SysUtils.Format('%s %dx%d', [Format, MaxWidth, MaxHeight]);
      ListBox1.Items.Add(s);
    end;
  ListBox1.ItemIndex:=0;

  // fills video source inputs
  ComboBox2.Items.Assign(ImageEnView1.IO.DShowParams.VideoInputSources);
  // set current video source input
  ComboBox2.ItemIndex := ImageEnView1.IO.DShowParams.VideoInputSource;

  Disconnect;
end;

// changes video source

procedure Tfmain.ComboBox1Change(Sender: TObject);
begin
  ShowVideoFormats;
end;

// set video source input

procedure Tfmain.ComboBox2Change(Sender: TObject);
begin
  ImageEnView1.IO.DShowParams.VideoInputSource := ComboBox2.ItemIndex;
end;


// Capture to jpeg stream button
procedure Tfmain.SpeedButton2Click(Sender: TObject);
begin
  if SpeedButton2.Down then
  begin
    DeleteFile(Edit1.Text);
    DeleteFile(Edit1.Text+'.pos');
    fOutputFile:=TFileStream.Create( Edit1.text, fmCreate );
    fPosFile:=TFileStream.Create( Edit1.text+'.pos', fmCreate );
  end
  else
  begin
    fOutputFile.Free;
    fPosFile.Free;
  end;
end;

// convert to AVI
procedure Tfmain.Button4Click(Sender: TObject);
var
  filename:string;
  fr:TFileStream;
  fp:TFileStream;
  p:int64;
begin
  SpeedButton2.Down := false;
  SpeedButton1.Down := false;
  if FileExists(Edit1.Text) and FileExists(Edit1.text+'.pos') then
  begin
    filename:=Edit1.Text+'.avi';
    fr:=TFileStream.Create(Edit1.Text,fmOpenRead);
    fp:=TFileStream.Create(Edit1.Text+'.pos',fmOpenRead);
    ImageEnView1.IO.CreateAVIFile(Edit1.Text+'.avi');
    while fp.Position < fp.Size do
    begin
      fp.Read(p,sizeof(p));
      fr.Position := p;
      ImageEnView1.IO.LoadFromStreamJpeg( fr );
      ImageEnView1.IO.SaveToAVI;
      ImageEnView1.Paint;
    end;
    ImageEnView1.IO.CloseAVIFile;
    fr.Free;
    fp.Free;
  end;
end;

end.
