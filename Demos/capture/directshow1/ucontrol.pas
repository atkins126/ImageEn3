unit ucontrol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ieds, ExtCtrls, Buttons, hyieutils;

type
  Tfcontrol = class(TForm)
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    Label2: TLabel;
    PlayButton: TSpeedButton;
    PauseButton: TSpeedButton;
    StopButton: TSpeedButton;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label5: TLabel;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure OnPlayButton(Sender: TObject);
    procedure OnPauseButton(Sender: TObject);
    procedure OnStopButton(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure ComboBox1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dshow: TIEDirectShow;
    UserAction: boolean;
    procedure GrabFrame;
    procedure DisplayTimes;
    procedure Connect;
    procedure NewFrame;
    procedure Event;
  end;

var
  fcontrol: Tfcontrol;

implementation

uses umain, uselectinput, uselectoutput;

{$R *.dfm}

procedure Tfcontrol.Connect;
begin
  if not dshow.Connected then
  begin
    // set input
    if fselectinput.edit1.text <> '' then
    begin
      dshow.FileInput := AnsiString(fselectinput.Edit1.Text);
      dshow.SetVideoInput(-1);
      dshow.SetAudioInput(-1);
    end
    else
    begin
      dshow.SetVideoInput(fselectinput.ListBox1.ItemIndex);
      dshow.SetAudioInput(fselectinput.ListBox2.ItemIndex);
    end;
    // set output
    if fselectoutput.edit1.text <> '' then
      dshow.FileOutput := AnsiString(fselectoutput.Edit1.Text);
    dshow.SetVideoCodec(fselectoutput.ListBox1.ItemIndex);
    dshow.SetAudioCodec(fselectoutput.ListBox2.ItemIndex);
    // we want to grab samples
    dshow.EnableSampleGrabber := true;
    // build the graph
    dshow.Connect;
    //
    DisplayTimes;
    //
    ComboBox1.ItemIndex := integer(dshow.TimeFormat);
  end;
end;

// play

procedure Tfcontrol.OnPlayButton(Sender: TObject);
begin
  PlayButton.Enabled := false; // play
  PauseButton.Enabled := true; // pause
  StopButton.Enabled := true; // stop
  Connect;
  dshow.Run;
end;

// pause

procedure Tfcontrol.OnPauseButton(Sender: TObject);
begin
  PlayButton.Enabled := true; // play
  PauseButton.Enabled := false; // pause
  StopButton.Enabled := true; // stop
  dshow.Pause;
end;

// stop

procedure Tfcontrol.OnStopButton(Sender: TObject);
begin
  PlayButton.Enabled := true; // play
  PauseButton.Enabled := false; // pause
  StopButton.Enabled := false; // stop
  dshow.Stop;
  trackbar1.position := 0;
  dshow.Position := 0;
end;

procedure Tfcontrol.FormCreate(Sender: TObject);
begin
  dshow := fmain.ImageEnView1.IO.DShowParams;
  UserAction := true;
end;

// rate

procedure Tfcontrol.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  dshow.Rate := UpDown1.Position / 10;
  Edit1.text := FloatToStr(UpDown1.Position / 10);
end;

// convert seconds to string (hh:mm:ss:cc)

function secs2str(secs: int64): string;
var
  c, m, s, h: integer;
  cc, mm, ss, hh: string;
begin
  c := secs div 100000;
  s := c div 100;
  m := s div 60;
  h := m div 60;
  hh := inttostr(h);
  if length(hh) = 1 then
    hh := '0' + hh;
  m := m - h * 60;
  mm := inttostr(m);
  if length(mm) = 1 then
    mm := '0' + mm;
  s := s - (h * 3600 + m * 60);
  ss := inttostr(s);
  if length(ss) = 1 then
    ss := '0' + ss;
  c := c - (h * 3600 + m * 60 + s) * 100;
  cc := inttostr(c);
  if length(cc) = 1 then
    cc := '0' + cc;
  result := hh + '.' + mm + '.' + ss + ',' + cc;
end;

procedure Tfcontrol.DisplayTimes;
begin
  case TIETimeFormat(ComboBox1.ItemIndex) of
    tfTime:
      begin
        Label2.Caption := secs2str(dshow.Duration);
        Label3.Caption := secs2str(dshow.Position);
      end;
    tfNone:
      begin
        Label2.Caption := IntTostr(dshow.Duration);
        Label3.Caption := IntTostr(dshow.Position);
      end;
    tfFrame, tfSample, tfField:
      begin
        Label2.Caption := IntTostr(dshow.Duration) + ' frames';
        Label3.Caption := 'frame: ' + IntTostr(dshow.Position);
      end;
    tfByte:
      begin
        Label2.Caption := FloatToStr(dshow.Duration / 1048576) + ' MBytes';
        Label3.Caption := 'byte: ' + IntTostr(dshow.Position);
      end;
  end;
end;

// set time format

procedure Tfcontrol.ComboBox1Change(Sender: TObject);
begin
  dshow.TimeFormat := TIETimeFormat(ComboBox1.ItemIndex);
end;

// get a new frame (you can call this also with a TTimer object)

procedure Tfcontrol.NewFrame;
begin
  if dshow.Connected and (dshow.State = gsRunning) then
  begin
    UserAction := false;
    if dshow.Duration <> 0 then
      fcontrol.trackbar1.position := trunc((dshow.Position / dshow.Duration) * 100);
    DisplayTimes;
    GrabFrame;
  end;
end;

procedure Tfcontrol.Event;
var
  event: integer;
begin
  if dshow.Connected then
    while dshow.GetEventCode(event) do
      case event of
        IEEC_COMPLETE:
          begin
            OnStopButton(self); // call STOP button
          end;
      end;
end;

// set position

procedure Tfcontrol.TrackBar1Change(Sender: TObject);
begin
  if dshow.Connected and UserAction then
  begin
    dshow.Position := (trackbar1.Position * dshow.Duration) div 100;
    GrabFrame;
    DisplayTimes;
  end;
  UserAction := true;
end;

// get a frame

procedure Tfcontrol.GrabFrame;
begin
  dshow.GetSample(fmain.ImageEnView1.IEBitmap);
  fmain.ImageEnView1.Update;
end;

// update counters

procedure Tfcontrol.Timer1Timer(Sender: TObject);
begin
  DisplayTimes;
end;

// output quality

procedure Tfcontrol.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
  dshow.VideoCodecQuality := UpDown2.Position / 10;
  Edit2.text := FloatToStr(UpDown2.Position / 10);
end;

// audio input params

procedure Tfcontrol.Button1Click(Sender: TObject);
begin
  Connect;

  if dshow.ShowPropertyPages(iepAudioInput, ietFilter, true) then
    dshow.ShowPropertyPages(iepAudioInput, ietFilter)
  else
    ShowMessage('AudioInput Filter Page not available');

  if dshow.ShowPropertyPages(iepAudioInput, ietInput, true) then
    dshow.ShowPropertyPages(iepAudioInput, ietInput)
  else
    ShowMessage('AudioInput Input Page not available');

  if dshow.ShowPropertyPages(iepAudioInput, ietOutput, true) then
    dshow.ShowPropertyPages(iepAudioInput, ietOutput)
  else
    ShowMessage('AudioInput Output Page not available');
end;

// video input params

procedure Tfcontrol.Button2Click(Sender: TObject);
begin
  Connect;
  if dshow.ShowPropertyPages(iepVideoInput, ietFilter, true) then
    dshow.ShowPropertyPages(iepVideoInput, ietFilter)
  else
    ShowMessage('VideoInput Filter Page not available');

  if dshow.ShowPropertyPages(iepVideoInput, ietInput, true) then
    dshow.ShowPropertyPages(iepVideoInput, ietInput)
  else
    ShowMessage('VideoInput Input Page not available');

  if dshow.ShowPropertyPages(iepVideoInput, ietOutput, true) then
    dshow.ShowPropertyPages(iepVideoInput, ietOutput)
  else
    ShowMessage('VideoInput Output Page not available');
end;

// audio output params

procedure Tfcontrol.Button3Click(Sender: TObject);
begin
  Connect;

  if dshow.ShowPropertyPages(iepAudioCodec, ietFilter, true) then
    dshow.ShowPropertyPages(iepAudioCodec, ietFilter)
  else
    ShowMessage('AudioCodec Filter Page not available');

  if dshow.ShowPropertyPages(iepAudioCodec, ietInput, true) then
    dshow.ShowPropertyPages(iepAudioCodec, ietInput)
  else
    ShowMessage('AudioCodec Input Page not available');

  if dshow.ShowPropertyPages(iepAudioCodec, ietOutput, true) then
    dshow.ShowPropertyPages(iepAudioCodec, ietOutput)
  else
    ShowMessage('AudioCodec Output Page not available');
end;

// video output params

procedure Tfcontrol.Button4Click(Sender: TObject);
begin
  Connect;

  if dshow.ShowPropertyPages(iepVideoCodec, ietFilter, true) then
    dshow.ShowPropertyPages(iepVideoCodec, ietFilter)
  else
    ShowMessage('VideoCodec Filter Page not available');

  if dshow.ShowPropertyPages(iepVideoCodec, ietInput, true) then
    dshow.ShowPropertyPages(iepVideoCodec, ietInput)
  else
    ShowMessage('VideoCodec Input Page not available');

  if dshow.ShowPropertyPages(iepVideoCodec, ietOutput, true) then
    dshow.ShowPropertyPages(iepVideoCodec, ietOutput)
  else
    ShowMessage('VideoCodec Output Page not available');
end;

end.
