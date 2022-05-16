unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ExtCtrls, StdCtrls, hyiedefs, hyieutils,imageenproc;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageEnView1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    fileName:string;
  public
    { Public declarations }
    procedure SetTransparent;
  end;

var
  MainForm: TMainForm;

implementation

uses upick;

{$R *.DFM}

// File | Open
procedure TMainForm.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
  begin
    filename := ExecuteOpenDialog('','',true,0,'');
    LoadFromFileAuto( filename );
  end;
end;

// reload
procedure TMainForm.Button2Click(Sender: TObject);
begin
  ImageEnView1.IO.LoadFromFileAuto( filename );
end;


// File | Save
// WARNING: not all file formats support alpha channel
procedure TMainForm.Save1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    SaveToFile( ExecuteSaveDialog('','',true,0,'') );
end;

// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// Pick Transparent color button
procedure TMainForm.Button1Click(Sender: TObject);
begin
  PickDialog.Show;
end;

procedure TMainForm.ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  cl_rgb:TRGB;
begin
  // transform client coorindates to bitmap ones
  X := ImageEnView1.XScr2Bmp( X );
  Y := ImageEnView1.YScr2Bmp( Y );

  // check limits
  if (X>=0) and (X<ImageEnView1.IEBitmap.Width) and
     (Y>=0) and (Y<ImageEnView1.IEBitmap.Height) then
  begin
    cl_rgb := ImageEnView1.IEBitmap.Pixels[X,Y];
    PickDialog.PickColor.Color := TRGB2TColor( cl_rgb );
    with cl_rgb do
      PickDialog.Label3.Caption := IntToStr(r)+','+IntToStr(g)+','+IntToStr(b);
  end;

  if ssLeft in Shift then
    SetTransparent;
end;

procedure TMainForm.ImageEnView1Click(Sender: TObject);
begin
  SetTransparent;
end;

procedure TMainForm.SetTransparent;
var
  cl_rgb:TRGB;
begin
  cl_rgb := TColor2TRGB( PickDialog.PickColor.Color );
  ImageEnView1.Proc.SetTransparentColors( cl_rgb, cl_rgb, 0);
end;



end.
