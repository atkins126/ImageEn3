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
    Panel2: TPanel;
    Timer1: TTimer;
    ImageEnView2: TImageEnView;
    Label2: TLabel;
    ImageEnView3: TImageEnView;
    procedure FormActivate(Sender: TObject);
    procedure ImageEnView1DShowNewFrame(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    buffer0, buffer1: TIEBitmap;
    current: integer;
    average: double;
    learning: boolean;
    numaverage: integer;
  public
    { Public declarations }
    procedure Connect;
    procedure Disconnect;
    procedure ShowVideoFormats;
    procedure PlotDifferences(diff:double);
  end;

var
  fmain: Tfmain;

implementation

{$R *.DFM}

procedure Tfmain.FormActivate(Sender: TObject);
begin
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
  f: AnsiString;
begin
  if SpeedButton1.Down then
  begin
    current := -1;
    average := 0;
    learning := true;
    numaverage := 0;
    imageenview1.IO.CreateAVIFile('c:\cap.avi', 10, 'msvc');
    //
    Connect;
    // set video size
    w := StrToIntDef(Edit1.Text, 0);
    h := StrToIntDef(Edit2.Text, 0);
    ImageEnView1.IO.DShowParams.SetCurrentVideoFormat(w, h);
    // show info
    ImageEnView1.IO.DShowParams.GetCurrentVideoFormat(w, h, f);
    Label4.Caption := Format('Capturing at %dx%d %s', [w, h, f]);
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
        s := SysUtils.Format('%s %dx%d to %dx%d', [Format, MinWidth, MinHeight, MaxWidth, MaxHeight]);
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

procedure Tfmain.FormCreate(Sender: TObject);
begin
  Buffer0 := TIEBitmap.Create;
  Buffer1 := TIEBitmap.Create;
end;

procedure Tfmain.FormDestroy(Sender: TObject);
begin
  Buffer1.Free;
  Buffer0.Free;
end;

// We have got a new frame
procedure Tfmain.ImageEnView1DShowNewFrame(Sender: TObject);
var
  diff: double;
  ss: string;
begin
  ImageEnView1.IO.DShowParams.GetSample(ImageEnView1.IEBitmap);
  case current of
    -1: // first time
      begin
        Buffer0.AssignImage(ImageEnView1.IEBitmap);
        Buffer1.AssignImage(ImageEnView1.IEBitmap);
        current := 0;
      end;
    0:
      begin
        Buffer0.AssignImage(ImageEnView1.IEBitmap);
        current := 1;
      end;
    1:
      begin
        Buffer1.AssignImage(ImageEnView1.IEBitmap);
        current := 0;
      end;
  end;

  ImageEnView2.IEBitmap.Allocate(Buffer0.Width, Buffer0.Height, ie8g);
  diff := IECompareImages(Buffer0, Buffer1, ImageEnView2.IEBitmap);

  PlotDifferences(diff);  

  if (not timer1.enabled) or learning then
  begin
    // compare images
    if learning then
    begin
      average := average + diff;
      inc(numaverage);
    end;
    if diff < average then
    begin
      timer1.enabled := true;
      if learning then
      begin
        panel2.color := clYellow;
        panel2.Caption := 'Learning';
      end
      else
      begin
        panel2.color := clred;
        panel2.Caption := 'Recording';
      end;
    end;
  end;

  ss := FormatDateTime('c', date + time);
  with ImageEnView1.IEBitmap.Canvas do
  begin
    Brush.Style := bsClear;
    Font.Color := clWhite;
    TextOut(0, 0, ss);
  end;

  if (timer1.enabled) and (not learning) then
  begin
    ImageEnView1.IO.SaveToAVI;
  end;

  ImageEnView1.Update;
  ImageEnView2.Update;
end;

procedure Tfmain.Timer1Timer(Sender: TObject);
begin
  if learning then
  begin
    learning := false;
    average := average / numaverage;
  end;
  panel2.color := clGreen;
  timer1.enabled := false;
  panel2.Caption := 'Pause';
end;

// plot differences in a graph (ImageEnView3)
procedure Tfmain.PlotDifferences(diff:double);
var
  w,h:integer;
begin
  w:=ImageEnView3.Width-6;
  h:=imageEnView3.Height-6;
  if (ImageEnView3.IEBitmap.Width<>w) or (ImageEnview3.IEBitmap.Height<>h) then
  begin
    ImageEnView3.IEBitmap.Allocate( w,h, ie24RGB );
    ImageEnView3.Proc.Fill( CreateRGB(0,0,0) );
  end;

  ImageEnView3.Proc.ShiftChannel(-1,0, 0,0);
  ImageEnView3.Proc.ShiftChannel(-1,0, 1,0);
  ImageEnView3.Proc.ShiftChannel(-1,0, 2,0);

  diff:=(diff-0.95)/0.040;

  ImageEnview3.IEBitmap.Canvas.Pen.Color:=clWhite;
  ImageEnview3.IEBitmap.Canvas.MoveTo(w-1, trunc( (h-1) * diff ) );
  ImageEnview3.IEBitmap.Canvas.LineTo(w-1, h-1);
  ImageEnView3.Update;
end;

end.
