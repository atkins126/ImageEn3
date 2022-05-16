unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, imageenproc, ComCtrls, Mask;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    Button2: TButton;
    TryBtn: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    CBRot: TCheckBox;
    CBInvert: TCheckBox;
    Degrees: TMaskEdit;
    StaticText1: TStaticText;
    procedure Button2Click(Sender: TObject);
    procedure TryBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses hyiedefs;

{$R *.DFM}

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.TryBtnClick(Sender: TObject);
var
  ie: TImageENView;
  row, col: integer;
begin
  // be sure selected mask exists
  if not FileExists(ComboBox1.Text) then
  begin
    MessageDlg('File ' + ComboBox1.Text + ' not found !', mtWarning, [mbOK], 0);
    Exit;
  end;

  with ImageEnView1 do
  begin
    // this example masks image borders
    ProgressBar1.Visible := True;
    ProgressBar1.Position := 0;

    // load background image
    IO.LoadFromfile('background.jpg');
    ProgressBar1.Position := 10;

    // create a temp image in memory
    ie := TImageEnView.Create(nil);
    ie.IO.LoadFromFile(ComboBox1.Text);

    ProgressBar1.Position := 30;

    if CBRot.Checked then
      ie.Proc.Rotate(StrToIntDef(Degrees.Text, 90), False, ierFast, -1);

    // careful ! Resample is different from ImageResize !
    ie.Proc.Resample(IEBitmap.Width, IEBitmap.Height, rfFastLinear);
    ProgressBar1.Position := 60;

    if CBInvert.Checked then
      ie.Proc.Negative;

    // if first top left pixel is black we want an inverted mask: black is transparent, white remains
    if TRGB2TColor(ie.IEBitmap.Pixels[0, 0]) = clBlack then
      if not CBInvert.Checked then
        ie.Proc.Negative;

    ProgressBar1.Position := 65;

    LayersAdd;
    IEBitmap.Assign(ie.IEBitmap);
    Update;
    ie.free; // free temp image
    ProgressBar1.Position := 70;

    // remove the black, making it as transparent
    // do it sloowly
//    for i := 0 to 255 do
//      Proc.SetTransparentColors(CreateRGB(i, i, i), CreateRGB(i, i, i), i);

    // or do it quick
    for row := 0 to IEBitmap.Height - 1 do
      for col := 0 to IEBitmap.Width - 1 do
        IEBitmap.Alpha[col, row] := IEBitmap.Pixels_ie24RGB[col, row].r;

    ProgressBar1.Position := 80;

    LayersMerge(0, 1);
    // jpegs have no alpha channel
    RemoveAlphaChannel(true);

    Application.ProcessMessages;
    ProgressBar1.Position := 90;

    //    // commercial hype
    //    LayersAdd;                                      // add a new layer
    //    Bitmap.Canvas.Font.Name   := 'Verdana';
    //    Bitmap.Canvas.Font.Height := 25;
    //    Bitmap.Canvas.Font.Color  := clBlue;
    //    Bitmap.Canvas.TextOut(20, 60, 'ImageEn Lib!');  // draw text on this layer
    //    Bitmap.Canvas.TextOut(20, Bitmap.Height - 60, 'ImageEn Lib!');
    //    // remove the white, making it as transparent
    //    Proc.SetTransparentColors(CreateRGB(255,255,255), CreateRGB(255,255,255), 0);
    //    Proc.AddSoftShadow(2,3,3);                      // add the shadow
    //    Layers[1].Transparency    := 128;               // the second layer has 128 of transparency
    //    LayersMerge(0,1);                               // from now we have only one layer

        // eventually save the result to be used elsewhere
    IO.SaveToFile('output.jpg');
    ProgressBar1.Position := 100;

    ProgressBar1.Visible := False;

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
  // load background image
  ImageEnView1.IO.LoadFromfile('background.jpg');
end;

end.
