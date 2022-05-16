unit utools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  Tftools = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    TrackBar2: TTrackBar;
    Label3: TLabel;
    TrackBar3: TTrackBar;
    Label4: TLabel;
    TrackBar4: TTrackBar;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    TrackBar5: TTrackBar;
    Label6: TLabel;
    TrackBar6: TTrackBar;
    Label7: TLabel;
    ComboBox1: TComboBox;
    procedure TrackBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ftools: Tftools;

implementation

uses umain, hyiedefs;

{$R *.dfm}

// zoom

procedure Tftools.TrackBar1Change(Sender: TObject);
begin
  fmain.ImageEnView1.Zoom := TrackBar1.Position;
  Label1.Caption := inttostr(TrackBar1.Position);
end;

// fit

procedure Tftools.Button1Click(Sender: TObject);
begin
  fmain.ImageEnView1.Fit;
end;

// change red

procedure Tftools.TrackBar2Change(Sender: TObject);
begin
  fmain.ImageEnView1.IEBitmap.ChannelOffset[0] := TrackBar2.position;
  fmain.ImageEnView1.Update;
end;

// green

procedure Tftools.TrackBar3Change(Sender: TObject);
begin
  fmain.ImageEnView1.IEBitmap.ChannelOffset[1] := TrackBar3.position;
  fmain.ImageEnView1.Update;
end;

// blue

procedure Tftools.TrackBar4Change(Sender: TObject);
begin
  fmain.ImageEnView1.IEBitmap.ChannelOffset[2] := TrackBar4.position;
  fmain.ImageEnView1.Update;
end;

// luminosity

procedure Tftools.TrackBar5Change(Sender: TObject);
begin
  trackbar2.position := trackbar5.Position;
  trackbar3.position := trackbar5.Position;
  trackbar4.position := trackbar5.Position;
end;

// contrast

procedure Tftools.TrackBar6Change(Sender: TObject);
begin
  fmain.ImageEnView1.IEBitmap.Contrast := TrackBar6.Position;
  fmain.ImageEnView1.Update;
end;

procedure Tftools.ComboBox1Change(Sender: TObject);
begin
  fmain.ImageEnView1.ZoomFilter := TResampleFilter(ComboBox1.ItemIndex);
end;

end.
