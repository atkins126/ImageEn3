unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ieview, imageenview, ExtCtrls, ieopensavedlg, Menus,
  XPMan, ComCtrls, hyieutils;

type
  TForm1 = class(TForm)
    ImageEnView2: TImageEnView;
    Navigator: TImageEnView;
    Button1: TButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    Open1: TMenuItem;
    XPManifest1: TXPManifest;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    Button2: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ImageEnView2ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView2ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FMT: TFormatSettings;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function EllipsifyText
  (PathToMince: string; InSpace: Integer): string;
var
  TotalLength, FLength: Integer;
begin
  TotalLength := Length(PathToMince);
  if TotalLength > InSpace then
  begin
    FLength := (Inspace div 2) - 2;
    Result := Copy(PathToMince, 0, fLength)
      + '\...\'
      + Copy(PathToMince,
      TotalLength - fLength,
      TotalLength);
  end
  else
    Result := PathToMince;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GetLocaleFormatSettings(0, FMT);
  ImageEnView2.SetNavigator(Navigator, [ienoMOUSEWHEELZOOM, ienoMARKOUTER]);
  ImageEnView2.MouseWheelParams.ZoomPosition := iemwMouse;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
  begin
    ImageEnView2.IO.LoadFromFile(OpenImageEnDialog1.FileName);
    Caption := Caption + OpenImageEnDialog1.FileName;
    Statusbar1.Panels[1].Text := EllipsifyText(ExtractFilePath(OpenImageEnDialog1.FileName), 44);
    Statusbar1.Panels[2].Text := ExtractFilename(OpenImageEnDialog1.FileName);
    Statusbar1.Panels[3].Text := 'Zoom - ' + FloatToStr(ImageEnView2.Zoom, FMT) + '%';
  end;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ImageEnView2ZoomIn(Sender: TObject; var NewZoom: Double);
begin
  ImageENView2.Cursor := 1779;
  Statusbar1.Panels[3].Text := 'Zoom - ' + FloatToStr(NewZoom, FMT) + '%';
end;

procedure TForm1.ImageEnView2ZoomOut(Sender: TObject; var NewZoom: Double);
begin
  ImageENView2.Cursor := 1778;
  Statusbar1.Panels[3].Text := 'Zoom - ' + FloatToStr(NewZoom, FMT) + '%';
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ImageEnView2.Zoom := TrackBar1.Position;
end;

end.
