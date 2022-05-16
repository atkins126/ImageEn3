unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, ExtCtrls, ieopensavedlg, Menus, ComCtrls,
  iemview, ieds;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    ImageEnView1: TImageEnView;
    OpenImageEnDialog1: TOpenImageEnDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Saveframe1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Getframe1: TMenuItem;
    Stop1: TMenuItem;
    Play1: TMenuItem;
    Pause1: TMenuItem;
    Stop2: TMenuItem;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    ImageEnMView1: TImageEnMView;
    procedure Open1Click(Sender: TObject);
    procedure Saveframe1Click(Sender: TObject);
    procedure Getframe1Click(Sender: TObject);
    procedure Play1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Stop2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


// File | open
procedure TForm1.Open1Click(Sender: TObject);
var
  w,h:integer;
begin
  if OpenImageEnDialog1.Execute then
    with ImageEnView1.IO.DShowParams do
    begin
      FileInput:=OpenImageEnDialog1.FileName;
      RenderVideo:=true;
      RenderAudio:=true;

      ReferenceClock:=rcAudioOutput;

      Connect;

      // Set bitmap size
      GetVideoRenderNativeSize(w,h);
      ImageEnView1.Proc.ImageResize(w,h);

      //savegraph('c:\1.grf');

      Run;
    end;
end;

// File | Save frame
procedure TForm1.Saveframe1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    SaveToFile( ExecuteSaveDialog );
end;

// Get frame
procedure TForm1.Getframe1Click(Sender: TObject);
begin
  with ImageEnView1.IO.DShowParams do
  begin
    GetSample( ImageEnView1.IEBitmap );
    ImageEnView1.Update;
    ImageEnMView1.SetIEBitmap( ImageEnMView1.AppendImage, ImageEnView1.IEBitmap );
  end;
end;

// Play
procedure TForm1.Play1Click(Sender: TObject);
begin
  if not ImageEnView1.IO.DShowParams.Connected then
    ImageEnView1.IO.DShowParams.Connect;
  ImageEnView1.IO.DShowParams.Run;
end;

// Pause
procedure TForm1.Pause1Click(Sender: TObject);
begin
  ImageEnView1.IO.DShowParams.Pause;
end;

// Stop
procedure TForm1.Stop2Click(Sender: TObject);
begin
  ImageEnView1.IO.DShowParams.Stop;
  ImageEnView1.IO.DShowParams.Disconnect;
  ImageEnView1.Update;  // this will show the background image
end;

// Zoom
procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.Zoom:=TrackBar1.Position;
  Label2.Caption:='Zoom ('+FloatToStr(ImageEnView1.Zoom)+'%)';
end;

// Select image on thumbnails view
procedure TForm1.ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
begin
  ImageEnMView1.CopyToIEBitmap( idx, ImageEnView1.IEBitmap );
  ImageEnView1.Update;
end;

end.
