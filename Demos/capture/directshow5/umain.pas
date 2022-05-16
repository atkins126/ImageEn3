unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, Buttons, ieds, ComCtrls, ExtCtrls, Menus,
  iemview;

type
  Tfmain = class(TForm)
    ImageEnView1: TImageEnView;
    Label2: TLabel;
    Label3: TLabel;
    ImageEnView2: TImageEnView;
    Label4: TLabel;
    ImageEnView3: TImageEnView;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure ImageEnView1DShowNewFrame(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Connect;
    procedure Disconnect;
  end;

var
  fmain: Tfmain;

implementation

uses imageenio;

{$R *.DFM}

procedure Tfmain.FormActivate(Sender: TObject);
begin

  // Fill video source combobox
  ComboBox1.Items.Assign(ImageEnView1.IO.DShowParams.VideoInputs);

  // Select first item
  ComboBox1.ItemIndex := 0;

end;

// We have got a new frame

procedure Tfmain.ImageEnView1DShowNewFrame(Sender: TObject);
begin
  // copy current sample to ImageEnView bitmap
  ImageEnView1.IO.DShowParams.GetSample(ImageEnView1.IEBitmap);

  // refresh ImageEnView1
  ImageEnView1.Update;

end;

procedure Tfmain.Connect;
begin
  if (not ImageEnView1.IO.DShowParams.Connected) then
  begin
    // set video source as index of IO.DShowParams.VideoInputs
    ImageEnView1.IO.DShowParams.SetVideoInput(ComboBox1.ItemIndex, 0); // set the second parameter if you have more than one camera with same name
    // enable frame grabbing
    ImageEnView1.IO.DShowParams.EnableSampleGrabber := true;
    // connect to the video input
    ImageEnView1.IO.DShowParams.Connect;
    // start capture
    ImageEnView1.IO.DShowParams.Run;
    // set ImageEnView2 and ImageEnView3 as receivers for post frames
    ImageEnView1.BeginPostFrames( ImageEnView2, 5000, 60);
    ImageEnView1.BeginPostFrames( ImageEnView3, 10000, 60);
  end;
end;

procedure Tfmain.Disconnect;
begin
  // stop post frames
  ImageEnView1.EndPostFrames( ImageEnView2 );
  ImageEnView1.EndPostFrames( ImageEnView3 );
  // stop and disconnect
  ImageEnView1.IO.DShowParams.Disconnect;
end;

// Capture button
procedure Tfmain.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Down then
    Connect
  else
    Disconnect;
end;







end.
