unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, ExtCtrls, ieopensavedlg, Menus, ComCtrls,
  Buttons, iemview, ieds;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    ImageEnView1: TImageEnView;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    ComboBox1: TComboBox;
    ListBox1: TListBox;
    ComboBox2: TComboBox;
    Edit4: TEdit;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    ImageEnMView1: TImageEnMView;
    Label9: TLabel;
    Edit3: TEdit;
    UpDown1: TUpDown;
    Label10: TLabel;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure Edit3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowVideoFormats;
end;

var
  Form1: TForm1;

implementation

uses imageenio;

{$R *.DFM}

// Zoom
procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.Zoom:=TrackBar1.Position;
  Label2.Caption:='Zoom ('+FloatToStr(ImageEnView1.Zoom)+'%)';
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  // Fill video source combobox
  ComboBox1.Items.Assign(ImageEnView1.IO.DShowParams.VideoInputs);

  // Select first item
  ComboBox1.ItemIndex := 0;

  ShowVideoFormats;
end;

// Show Video button
procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  w,h:integer;
begin
  with ImageEnView1.IO.DShowParams do
    if SpeedButton1.Down then
    begin
      // connect video input
      if (not Connected) then
      begin
        // set video source as index of IO.DShowParams.VideoInputs
        SetVideoInput(ComboBox1.ItemIndex, StrToIntDef(edit4.Text,0)); // set the second parameter if you have more than one camera with same name
        // enable video and audio rendering
        RenderAudio:=true;
        RenderVideo:=true;

        //ReferenceClock:=rcAudioOutput;
        //ClockErrorTolerance:=40;
        //ReferenceClock:=rcSystemClock;

        // connect to the video input
        Connect;

        // set video size
        w := VideoFormats[ ListBox1.ItemIndex ].MaxWidth;
        h := VideoFormats[ ListBox1.ItemIndex ].MaxHeight;
        SetCurrentVideoFormat(w, h, '');
        // Set bitmap size
        GetVideoRenderNativeSize(w,h);
        ImageEnView1.Proc.ImageResize(w,h);

        //SaveGraph('c:\1.grf');
      end;
      // start capture
      Run;
    end
    else
    begin
      Disconnect;
      ImageEnView1.Update;
    end;
end;

procedure TForm1.ShowVideoFormats;
var
  i: integer;
  s: string;
begin
  with ImageEnView1.IO.DShowParams do
  begin
    SetVideoInput(ComboBox1.ItemIndex, StrToIntDef(edit4.Text,0));
    Connect;

    // fills video formats list box
    ListBox1.Clear;
    for i := 0 to VideoFormatsCount - 1 do
    begin
      with VideoFormats[i] do
        s := Format + ' ' + inttostr(MaxWidth) + 'x' + inttostr(MaxHeight);
      ListBox1.Items.Add(s);
    end;
    ListBox1.ItemIndex:=0;

    // fills video source inputs
    ComboBox2.Items.Assign(VideoInputSources);
    // set current video source input
    ComboBox2.ItemIndex := VideoInputSource;

    Disconnect;
  end;
end;

// Set video source input
procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  ImageEnView1.IO.DShowParams.VideoInputSource := ComboBox2.ItemIndex;
end;

// Changes video source
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  ShowVideoFormats;
end;

// Get sample
procedure TForm1.Button1Click(Sender: TObject);
begin
  with ImageEnView1.IO.DShowParams do
  begin
    GetSample( ImageEnView1.IEBitmap );
    ImageEnView1.Update;
    ImageEnMView1.SetIEBitmap( ImageEnMView1.AppendImage, ImageEnView1.IEBitmap );
  end;
end;

// Select image on thumbnails view
procedure TForm1.ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
begin
  ImageEnMView1.CopyToIEBitmap( idx, ImageEnView1.IEBitmap );
  ImageEnView1.Update;
end;

// change tuner channel
procedure TForm1.Edit3Change(Sender: TObject);
begin
  ImageEnView1.IO.DShowParams.TunerChannel := strtointdef(edit3.text, 0);
  if ImageEnView1.IO.DShowParams.TunerFindSignal then
  begin
    label10.Caption := 'Signal';
    label10.Font.color := clGreen;
  end
  else
  begin
    label10.Caption := 'No Signal';
    label10.Font.color := clRed;
  end;
end;

end.
