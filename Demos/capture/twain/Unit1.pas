unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ImageEnView, ImageEnIO, ComCtrls, ieview;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    ComboBox2: TComboBox;
    CheckBox2: TCheckBox;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ImageEnIO1Progress(Sender: TObject; per: Integer);
    procedure CheckBox5Click(Sender: TObject);
  private
    { Private declarations }
    procedure FillBack; // copy twain parameters to the controls
    procedure FillIn; // copy controls to twain parameters
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
var
  i: integer;
begin
  // fills TWain sources
  for i := 0 to ImageEnView1.IO.TWainParams.SourceCount - 1 do
    ComboBox1.Items.Add(ImageEnView1.IO.TWainParams.SourceName[i]);
  // Select first scanner
  ComboBox1.ItemIndex := 0;
  ImageEnView1.IO.TWainParams.SelectedSource := ComboBox1.ItemIndex;
  ImageEnView1.IO.TWainParams.AppVersionInfo := '1.0';
  ImageEnView1.IO.TWainParams.AppManufacturer := 'HiComponents';
  ImageEnView1.IO.TWainParams.AppProductFamily := 'Image processing';
  ImageEnView1.IO.TWainParams.AppProductName := 'ImageEn demo';
  FillBack;
end;

// Select scanner

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  ImageEnView1.IO.TWainParams.SelectedSource := ComboBox1.ItemIndex;
  FillBack;
end;

// negotiate parameters (verify that scanner supports Frame rectangle, Dpi...)

procedure TForm1.Button2Click(Sender: TObject);
begin
  FillIn;
  ImageEnView1.IO.TWainParams.Update; // verify here...
  FillBack;
end;

// copy twain parameters to the controls

procedure TForm1.FillBack;
const
  COLORS: array[0..9] of string = ('Black&White', 'GrayScale', 'RGB', 'Palette', 'CMY', 'CMYK', 'YUV', 'YUVK', 'CIEXYZ', 'LAB');
var
  i, v: integer;
begin
  Edit1.Text := FloatToStr(ImageEnView1.IO.TWainParams.YResolution.CurrentValue);
  Edit2.Text := FloatToStr(ImageEnView1.IO.TWainParams.XResolution.CurrentValue);
  // Fill Colors (0=B/W 1=GrayScale 2=RGB) combobox
  ComboBox2.Clear;
  for i := 0 to ImageEnView1.IO.TWainParams.PixelType.Count - 1 do
  begin
    v := ImageEnView1.IO.TWainParams.PixelType[i];
    if v <= high(COLORS) then
      ComboBox2.Items.Add(COLORS[v]);
  end;
  ComboBox2.ItemIndex := ImageEnView1.IO.TWainParams.PixelType.IndexOf(ImageEnView1.IO.TWainParams.PixelType.CurrentValue);
  // frame
  Edit3.Text := FloatToStr(ImageEnView1.IO.TWainParams.AcquireFrameLeft);
  Edit4.Text := FloatToStr(ImageEnView1.IO.TWainParams.AcquireFrameTop);
  Edit5.Text := FloatToStr(ImageEnView1.IO.TWainParams.AcquireFrameRight);
  Edit6.Text := FloatToStr(ImageEnView1.IO.TWainParams.AcquireFrameBottom);
end;

// copy controls values to twain parameters

procedure TForm1.FillIn;
begin
  ImageEnView1.IO.TWainParams.VisibleDialog := CheckBox1.Checked;
  ImageEnView1.IO.TWainParams.ProgressIndicators := CheckBox2.Checked;
  ImageEnView1.IO.TWainParams.AcquireFrameLeft := StrToFloat(Edit3.Text);
  ImageEnView1.IO.TWainParams.AcquireFrameTop := StrToFloat(Edit4.Text);
  ImageEnView1.IO.TWainParams.AcquireFrameRight := StrToFloat(Edit5.Text);
  ImageEnView1.IO.TWainParams.AcquireFrameBottom := StrToFloat(Edit6.Text);
  ImageEnView1.IO.TWainParams.PixelType.CurrentValue := ComboBox2.ItemIndex;
  ImageEnView1.IO.TWainParams.YResolution.CurrentValue := StrToInt(edit1.text);
  ImageEnView1.IO.TWainParams.XResolution.CurrentValue := StrToInt(edit2.text);
  ImageEnView1.IO.TWainParams.BufferedTransfer := CheckBox4.Checked;
end;

// Acquire

procedure TForm1.Button1Click(Sender: TObject);
begin
  FillIn;
  ImageEnView1.IO.Acquire(ieaTWain);
  ProgressBar1.Position := 0;
end;

// progress

procedure TForm1.ImageEnIO1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
  if CheckBox3.Checked then
  begin
    ImageEnView1.Update;
    application.processmessages;
  end;
end;

// enable/disable acquire frame

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  edit3.enabled := CheckBox5.Checked;
  edit4.enabled := CheckBox5.Checked;
  edit5.enabled := CheckBox5.Checked;
  edit6.enabled := CheckBox5.Checked;
  ImageEnView1.IO.TWainParams.AcquireFrameEnabled := CheckBox5.Checked;
  ImageEnView1.IO.TWainParams.Update;
  FillBack;
end;

end.
