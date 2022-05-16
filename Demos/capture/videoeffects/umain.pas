unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, Buttons, ieds, ComCtrls, ExtCtrls, Menus, hyieutils, imageenproc;

type
  Tfmain = class(TForm)
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    ComboBox1: TComboBox;
    Label4: TLabel;
    ListBox1: TListBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label8: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ImageEnView1DShowNewFrame(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Connect;
    procedure Disconnect;
    procedure ShowVideoFormats;
  end;

var
  fmain: Tfmain;

implementation

{$R *.DFM}

procedure Tfmain.FormActivate(Sender: TObject);
begin
  // add a new layer with image 1.png
  ImageEnView1.LayersSync:=false;
  ImageEnView1.LayersAdd;
  ImageEnView1.CurrentLayer.PosX:=40;
  ImageEnView1.CurrentLayer.PosY:=40;
  ImageEnView1.IO.LoadFromFile('1.png');
  // Fill video source combobox
  ComboBox1.Items.Assign(ImageEnView1.IO.DShowParams.VideoInputs);
  // Select first item
  ComboBox1.ItemIndex := 0;
  //
  ShowVideoFormats;
end;

procedure Tfmain.Connect;
begin
  if (not ImageEnView1.IO.DShowParams.Connected) then
  begin
    // set video source as index of IO.DShowParams.VideoInputs
    ImageEnView1.IO.DShowParams.SetVideoInput(ComboBox1.ItemIndex,0);
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
  f: string;
begin
  if SpeedButton1.Down then
  begin
    imageenview1.IO.CreateAVIFile('c:\cap.avi', 10, 'msvc');
    //
    Connect;
    // set video size
    w := StrToIntDef(Edit1.Text, 0);
    h := StrToIntDef(Edit2.Text, 0);
    ImageEnView1.IO.DShowParams.SetCurrentVideoFormat(w, h, '');
    // show info
    ImageEnView1.IO.DShowParams.GetCurrentVideoFormat(w, h, f);
    Label4.Caption := 'Capturing at ' + inttostr(w) + 'x' + inttostr(h) + ' ' + f;
    // start capture
    ImageEnView1.IO.DShowParams.Run;
  end
  else
  begin
    Disconnect;
    imageenview1.io.CloseAVIFile;
  end;
end;

procedure Tfmain.ShowVideoFormats;
var
  i: integer;
  s: string;
begin
  Connect;

  // fills video formats list box (informative only box)
  ListBox1.Clear;
  with ImageEnView1.IO.DShowParams do
    for i := 0 to VideoFormatsCount - 1 do
    begin
      with VideoFormats[i] do
        s := Format + ' ' + inttostr(MinWidth) + 'x' + inttostr(MinHeight) + ' to ' + inttostr(MaxWidth) + 'x' + inttostr(MaxHeight);
      ListBox1.Items.Add(s);
    end;

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

// We have got a new frame

procedure Tfmain.ImageEnView1DShowNewFrame(Sender: TObject);
var
  ss: string;
begin
  ImageEnView1.LayersCurrent:=0;
  ImageEnView1.IO.DShowParams.GetSample(ImageEnView1.IEBitmap);

  // display datatime
  ss := FormatDateTime('c', date + time);
  with ImageEnView1.IEBitmap.Canvas do
  begin
    Brush.Style := bsClear;
    Font.Color := clWhite;
    TextOut(0, 0, ss);
  end;

  // uncomment if you want merge image also in the saved AVI
  //ImageEnView1.LayersMerge(0,1,false);

  ImageEnView1.IO.SaveToAVI;

  ImageEnView1.Update;

  ImageEnView1.Paint;
end;

end.
