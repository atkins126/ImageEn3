unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ieds, StdCtrls, ExtCtrls;

type
  Tfmain = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Control1: TMenuItem;
    Play1: TMenuItem;
    Pause1: TMenuItem;
    Stop1: TMenuItem;
    View1: TMenuItem;
    N111: TMenuItem;
    N211: TMenuItem;
    Fitwindow1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Play1Click(Sender: TObject);
    procedure ImageEnView1DShowNewFrame(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure ImageEnView1DShowEvent(Sender: TObject);
    procedure N111Click(Sender: TObject);
    procedure N211Click(Sender: TObject);
    procedure Fitwindow1Click(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmain: Tfmain;

implementation

{$R *.DFM}

// File | Exit

procedure Tfmain.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open

procedure Tfmain.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO.DShowParams do
  begin
    if State = gsRunning then
    begin
      Stop;
      Disconnect;
    end;

    if OpenDialog1.Execute then
    begin
      FileInput := OpenDialog1.FileName;
      EnableSampleGrabber := true;
      RenderAudio := true;
      Connect;
      Position := 0;
      Pause; // This shows first frame
    end;
  end;
end;

// Control | Play

procedure Tfmain.Play1Click(Sender: TObject);
begin
  ImageEnView1.IO.DShowParams.Run;
end;

procedure Tfmain.ImageEnView1DShowNewFrame(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    IO.DShowParams.GetSample(IEBitmap);
    Update;
  end;
end;

// Control | Pause

procedure Tfmain.Pause1Click(Sender: TObject);
begin
  ImageEnView1.IO.DShowParams.Pause;
end;

// Control | Stop

procedure Tfmain.Stop1Click(Sender: TObject);
begin
  with ImageEnView1.IO.DShowParams do
  begin
    Stop;
    Position := 0;
    Pause; // This shows first frame
  end;
end;

procedure Tfmain.ImageEnView1DShowEvent(Sender: TObject);
var
  event: integer;
begin
  with ImageEnView1.IO.DShowParams do
    if Connected then
      while GetEventCode(event) do
        case event of
          IEEC_COMPLETE:
            Stop1Click(self); // call STOP button
        end;
end;

// Zoom 1:1

procedure Tfmain.N111Click(Sender: TObject);
begin
  ImageEnView1.AutoFit := false;
  ImageEnView1.Zoom := 100;
end;

// Zoom 2:1

procedure Tfmain.N211Click(Sender: TObject);
begin
  ImageEnView1.AutoFit := false;
  ImageEnView1.Zoom := 200;
end;

procedure Tfmain.Fitwindow1Click(Sender: TObject);
begin
  ImageEnView1.AutoFit := true;
  ImageEnView1.Update;
end;

// convert seconds to string (hh:mm:ss:cc)
//function secs2str(secs:int64):string;

function secs2str(secs: integer): string;
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

procedure Tfmain.ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  ImageEnView1.Hint := 'Duration = ' + secs2str(ImageEnView1.IO.DShowParams.Duration);
end;

end.
