unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, Menus, ComCtrls, StdCtrls, ExtCtrls, hyieutils;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    TrackBar1: TTrackBar;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    TrackBar2: TTrackBar;
    Label3: TLabel;
    TrackBar3: TTrackBar;
    Label4: TLabel;
    TrackBar4: TTrackBar;
    GroupBox4: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox1: TGroupBox;
    TrackBar5: TTrackBar;
    CheckBox4: TCheckBox;
    GroupBox5: TGroupBox;
    TrackBar6: TTrackBar;
    GroupBox6: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    procedure Open1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ChangeChannelsOffset;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// File | Open

procedure TForm1.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
  begin
    NativePixelFormat:=true;
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));
  end;

  if ImageEnView1.IEBitmap.PixelFormat=ie16g then
  begin
    trackbar7.Max:=65535;
    trackbar7.Position:=0;
    trackbar7.Enabled:=true;
    trackbar8.Max:=65535;
    trackbar8.Position:=65535;
    trackbar8.Enabled:=true;
  end
  else if ImageEnView1.IEBitmap.PixelFormat=ie8g then
  begin
    trackbar7.Max:=255;
    trackbar7.Position:=0;
    trackbar7.Enabled:=true;
    trackbar8.Max:=255;
    trackbar8.Position:=255;
    trackbar8.Enabled:=true;
  end
  else
  begin
    trackbar7.Enabled:=false;
    trackbar8.Enabled:=false;
  end;
end;

// contrast

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.IEBitmap.Contrast := TrackBar1.Position;
  ImageEnView1.Update;
end;

procedure TForm1.ChangeChannelsOffset;
begin
  ImageEnView1.IEBitmap.ChannelOffset[0] := TrackBar2.Position; // red
  ImageEnView1.IEBitmap.ChannelOffset[1] := TrackBar3.Position; // green
  ImageEnView1.IEBitmap.ChannelOffset[2] := TrackBar4.Position; // blue
  ImageEnView1.Update;
end;

// red

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  ChangeChannelsOffset;
end;

// green

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
  ChangeChannelsOffset;
end;

// blue

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
  ChangeChannelsOffset;
end;

// show red

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  TrackBar2.Enabled := CheckBox1.Checked;
  if CheckBox1.Checked then
    TrackBar2.Position := 0
  else
    TrackBar2.Position := -255;
  ChangeChannelsOffset;
end;

// show green

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  TrackBar3.Enabled := CheckBox2.Checked;
  if CheckBox2.Checked then
    TrackBar3.Position := 0
  else
    TrackBar3.Position := -255;
  ChangeChannelsOffset;
end;

// show blue

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  TrackBar4.Enabled := CheckBox3.Checked;
  if CheckBox3.Checked then
    TrackBar4.Position := 0
  else
    TrackBar4.Position := -255;
  ChangeChannelsOffset;
end;

// Zoom

procedure TForm1.TrackBar5Change(Sender: TObject);
begin
  ImageEnView1.Zoom := TrackBar5.Position;
end;

// Fit

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then
  begin
    ImageEnView1.AutoFit := true;
    ImageEnView1.Fit;
    TrackBar5.Enabled := false;
  end
  else
  begin
    ImageEnView1.AutoFit := false;
    TrackBar5.Enabled := true;
    ImageEnView1.Zoom := TrackBar5.Position;
  end;
end;

// Brightness

procedure TForm1.TrackBar6Change(Sender: TObject);
begin
  if CheckBox1.Checked then
    TrackBar2.Position := TrackBar6.Position;
  if CheckBox2.Checked then
    TrackBar3.Position := TrackBar6.Position;
  if CheckBox3.Checked then
    TrackBar4.Position := TrackBar6.Position;
  ChangeChannelsOffset;
end;

// black/white ranges
procedure TForm1.TrackBar7Change(Sender: TObject);
begin
  ImageEnView1.IEBitmap.BlackValue:=trackbar7.position;
  ImageEnView1.IEBitmap.WhiteValue:=trackbar8.position;
  ImageEnView1.Update;
end;

end.
