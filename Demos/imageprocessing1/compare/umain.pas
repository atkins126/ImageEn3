unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, ImageEnView;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ImageEnView1: TImageEnView;
    ImageEnView2: TImageEnView;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Button4: TButton;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ImageEnProc, hyiedefs;

{$R *.DFM}

// compare (using ComputeImageEquality)

procedure TForm1.Button1Click(Sender: TObject);
var
  psnr_min, psnr_max: double;
  mse_min, mse_max: double;
  rmse_min, rmse_max: double;
  pae_min, pae_max: double;
  mae_min, mae_max: double;
  equal: boolean;
  ww, hh: integer;
begin
  // adjust sizes (make ImageEnView1=ImageEnView2)
  ww := ImageEnView1.Bitmap.Width;
  hh := ImageEnView1.Bitmap.Height;
  if (ww <> ImageEnView2.Bitmap.Width) or (hh <> ImageEnView2.Bitmap.Height) then
    ImageEnView2.Proc.Resample(ww, hh, rfNone);
  //
  equal := ImageEnView1.Proc.ComputeImageEquality(ImageEnView2.IEBitmap, psnr_min, psnr_max, mse_min, mse_max, rmse_min, rmse_max, pae_min, pae_max, mae_min, mae_max);
  label4.caption := floattostr(psnr_min) + ' (min) , ' + floattostr(psnr_max) + ' (max)';
  label6.caption := floattostr(mse_min) + ' (min) , ' + floattostr(mse_max) + ' (max)';
  label8.caption := floattostr(rmse_min) + ' (min) , ' + floattostr(rmse_max) + ' (max)';
  label10.caption := floattostr(pae_min) + ' (min) , ' + floattostr(pae_max) + ' (max)';
  label12.caption := floattostr(mae_min) + ' (min) , ' + floattostr(mae_max) + ' (max)';
  if equal then
    label14.caption := 'True'
  else
    label14.caption := 'False';
end;

// compare using CompareWith

procedure TForm1.Button4Click(Sender: TObject);
var
  ww, hh: integer;
  v: double;
begin
  // adjust sizes (make ImageEnView1=ImageEnView2)
  ww := ImageEnView1.Bitmap.Width;
  hh := ImageEnView1.Bitmap.Height;
  if (ww <> ImageEnView2.Bitmap.Width) or (hh <> ImageEnView2.Bitmap.Height) then
    ImageEnView2.Proc.Resample(ww, hh, rfNone);
  //
  v := ImageEnView1.Proc.CompareWith(ImageEnView2.IEBitmap, nil);
  label16.Caption := floattostr(v * 100) + ' %';
end;

// Open A

procedure TForm1.Button2Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));
end;

// Open B

procedure TForm1.Button3Click(Sender: TObject);
begin
  with ImageEnView2.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));
end;

end.
