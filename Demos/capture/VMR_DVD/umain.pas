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
    Label3: TLabel;
    Timer1: TTimer;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label7: TLabel;
    ComboBox3: TComboBox;
    procedure Saveframe1Click(Sender: TObject);
    procedure Getframe1Click(Sender: TObject);
    procedure Play1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Stop2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageEnView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure ComboBox3Change(Sender: TObject);
  private
    { Private declarations }
    lastTitle:integer;
    lastChapter:integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

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
    ImageEnMView1.AppendImage( ImageEnView1.IEBitmap );
  end;
end;

// Play
procedure TForm1.Play1Click(Sender: TObject);
var
  w,h:integer;
begin
  with ImageEnView1.IO.DShowParams do
  begin
    if not Connected then
    begin
      DVDInputPath:='Default';
      //DVDInputPath:='C:\dvd2\VIDEO_TS';
      RenderVideo:=true;
      RenderAudio:=true;
      Connect;
      //SaveGraph('c:\test.grf');
      // Set bitmap size
      GetVideoRenderNativeSize(w,h);
      ImageEnView1.Proc.ImageResize(w,h);
    end;

    lastTitle:=-1;
    lastChapter:=-1;

    Run;
  end;
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

procedure TForm1.ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  ImageEnView1.IO.DShowParams.DVDSelectAt(x,y);
end;

procedure TForm1.ImageEnView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageEnView1.IO.DShowParams.DVDActivateButton;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  // show current time, title and chapter
  with ImageEnView1.IO.DShowParams do
  begin
    Label3.Caption:='Time: '+DVDGetProperty('Time');

    if lastTitle<>StrToIntDef(DVDGetProperty('Title'),-1) then
    begin
      ComboBox1.Clear;
      for i:=1 to StrToIntDef(DVDGetProperty('NumOfTitles'),0) do
        ComboBox1.Items.Add(IntToStr(i));
      lastTitle:=StrToIntDef(DVDGetProperty('Title'),-1);
      ComboBox1.ItemIndex:=lastTitle-1;
      lastChapter:=-1;
    end;

    if lastChapter<>StrToIntDef(DVDGetProperty('Chapter'),-1) then
    begin
      ComboBox2.Clear;
      for i:=1 to StrToIntDef(DVDGetProperty('NumOfChapters',inttostr(lastTitle)),0) do
        ComboBox2.Items.Add(IntToStr(i));
      lastChapter:=StrToIntDef(DVDGetProperty('Chapter'),-1);
      ComboBox2.ItemIndex:=lastChapter-1;
    end;
  end;
end;

// Change title
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  lastTitle:=ComboBox1.ItemIndex;
  ImageEnView1.IO.DShowParams.DVDPlayAt(lastTitle,1);
end;

// Change chapter
procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  lastChapter:=ComboBox2.ItemIndex;
  ImageEnView1.IO.DShowParams.DVDPlayAt(lastTitle,lastChapter);
end;

// change speed
procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  ImageEnView1.IO.DShowParams.DVDPlayAdvanced( UpDown1.Position>=0, abs(UpDown1.Position/10) );
  Edit1.Text:=FloatToStr(UpDown1.Position/10);
end;

// select menu
procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  ImageEnView1.IO.DShowParams.DVDShowMenu(TIEDVDMenu(ComboBox3.ItemIndex));
end;

end.
