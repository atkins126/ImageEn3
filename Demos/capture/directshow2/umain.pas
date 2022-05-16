unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, Buttons, ieds, ComCtrls, ExtCtrls, Menus;

type
  Tfmain = class(TForm)
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    TrackBar1: TTrackBar;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox3: TGroupBox;
    CheckBox4: TCheckBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    CheckBox5: TCheckBox;
    Label4: TLabel;
    ListBox1: TListBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label8: TLabel;
    ComboBox2: TComboBox;
    Label9: TLabel;
    Edit3: TEdit;
    UpDown1: TUpDown;
    Label10: TLabel;
    Button3: TButton;
    Button4: TButton;
    Edit4: TEdit;
    Label11: TLabel;
    Edit5: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure ImageEnView1DShowNewFrame(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
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

  // Fill video source combobox
  ComboBox1.Items.Assign(ImageEnView1.IO.DShowParams.VideoInputs);
  // Select first item
  ComboBox1.ItemIndex := 0;

  ShowVideoFormats;
end;

// We have got a new frame

procedure Tfmain.ImageEnView1DShowNewFrame(Sender: TObject);
begin
  // copy current sample to ImageEnView bitmap
  ImageEnView1.IO.DShowParams.GetSample(ImageEnView1.Layers[0].Bitmap);
  // refresh ImageEnView1
  ImageEnView1.Update;
end;

procedure Tfmain.Connect;
begin
  if (not ImageEnView1.IO.DShowParams.Connected) then
  begin
    // set video source as index of IO.DShowParams.VideoInputs
    ImageEnView1.IO.DShowParams.SetVideoInput(ComboBox1.ItemIndex, StrToIntDef(edit4.Text,0)); // set the second parameter if you have more than one camera with same name
    // enable frame grabbing
    ImageEnView1.IO.DShowParams.EnableSampleGrabber := true;
    // connect to the video input
    ImageEnView1.IO.DShowParams.Connect;

    //imageenview1.io.dshowparams.SaveGraph('c:\1.grf');
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
    Connect;
    // set video size
    w := StrToIntDef(Edit1.Text, 0);
    h := StrToIntDef(Edit2.Text, 0);
    f := AnsiString( Edit5.Text );
    ImageEnView1.IO.DShowParams.SetCurrentVideoFormat(w, h, f);
    // show info
    ImageEnView1.IO.DShowParams.GetCurrentVideoFormat(w, h, f);
    Label4.Caption := Format('Capturing at %dx%d %s', [w, h, f]);
    // start capture
    ImageEnView1.IO.DShowParams.Run;
  end
  else
  begin
    Disconnect;
  end;
end;

// video dialog

procedure Tfmain.Button1Click(Sender: TObject);
begin
  Connect;
  ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInput, ietFilter,false);
end;

// Video source dialog

procedure Tfmain.Button3Click(Sender: TObject);
begin
  Connect;
  ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInputSource, ietFilter,false);
end;

// Tuner dialog

procedure Tfmain.Button4Click(Sender: TObject);
begin
  Connect;
  ImageEnView1.IO.DShowParams.ShowPropertyPages(iepTuner, ietFilter, false);
end;

// format dialog

procedure Tfmain.Button2Click(Sender: TObject);
begin
  Connect;
  ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInput, ietOutput, false);
end;

// Zoom

procedure Tfmain.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.Zoom := TrackBar1.Position;
end;

// Show Red

procedure Tfmain.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    ImageEnView1.IEBitmap.ChannelOffset[0] := 0
  else
    ImageEnView1.IEBitmap.ChannelOffset[0] := -255;
end;

// Show Green

procedure Tfmain.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
    ImageEnView1.IEBitmap.ChannelOffset[1] := 0
  else
    ImageEnView1.IEBitmap.ChannelOffset[1] := -255;
end;

// Show blue

procedure Tfmain.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
    ImageEnView1.IEBitmap.ChannelOffset[2] := 0
  else
    ImageEnView1.IEBitmap.ChannelOffset[2] := -255;
end;

// Magnify layer

procedure Tfmain.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then
  begin
    ImageEnView1.LayersSync := false;
    ImageEnView1.LayersAdd;
    ImageEnView1.Layers[1].Locked := False;
    ImageEnView1.Layers[1].Magnify.Enabled := True;
    ImageEnView1.Layers[1].Magnify.Style := iemEllipse;
  end
  else
  begin
    ImageEnView1.LayersRemove(1);
  end;
end;

// Magnify show grips

procedure Tfmain.CheckBox5Click(Sender: TObject);
begin
  if ImageEnView1.LayersCount > 1 then
    ImageEnView1.Layers[1].VisibleBox := CheckBox5.Checked
end;

// Save as

procedure Tfmain.SaveAs1Click(Sender: TObject);
begin
  ImageEnView1.IO.SaveToFile(ImageEnView1.IO.ExecuteSaveDialog('', '', false, 1, ''));
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

// change tuner channel

procedure Tfmain.Edit3Change(Sender: TObject);
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

// select a video format
procedure Tfmain.ListBox1Click(Sender: TObject);
var
  idx:integer;
begin
  idx := ListBox1.ItemIndex;
  if (idx > -1) and (idx < ImageEnView1.IO.DShowParams.VideoFormatsCount) then
  begin
    Edit1.Text := IntToStr( ImageEnView1.IO.DShowParams.VideoFormats[idx].MinWidth );
    Edit2.Text := IntToStr( ImageEnView1.IO.DShowParams.VideoFormats[idx].MinHeight );
    Edit5.Text := string( ImageEnView1.IO.DShowParams.VideoFormats[idx].Format );
  end;
end;

end.
