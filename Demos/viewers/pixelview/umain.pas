unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ComCtrls, StdCtrls, ExtCtrls, hyieutils, imageenproc, hyiedefs;

type
  TMainForm = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageEnView1Paint(Sender: TObject);
  private
    { Private declarations }
    lx,ly:integer;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open
procedure TMainForm.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFileAuto( ExecuteOpenDialog('','',true,0,'') );
end;

// Zoom
procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.Zoom:=TrackBar1.Position;
end;

// Moving mouse
procedure TMainForm.ImageEnView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  bitmapX,bitmapY:integer;
  color:TRGB;
begin
  with ImageEnView1 do
  begin
    bitmapX:=imin(imax(0,XScr2Bmp(X)),IEBitmap.Width-1);
    bitmapY:=imin(imax(0,YScr2Bmp(Y)),IEBitmap.Height-1);
    color:=IEBitmap.Pixels[bitmapX,bitmapY];
    Label3.Caption := '(R='+IntToStr(color.r)+',G='+IntToStr(color.g)+',B='+IntToStr(color.b)+')';
    Panel2.Color   := TRGB2TColor( color );
  end;

  lx:=X;
  ly:=Y;
  ImageEnView1.invalidate;
end;

procedure TMainForm.ImageEnView1Paint(Sender: TObject);
var
  bx,by:integer;
  x1,y1,x2,y2:integer;
begin
  bx:=ImageEnView1.XScr2Bmp(lx);
  by:=ImageEnView1.YScr2Bmp(ly);
  if (bx>=0) and (bx<ImageEnView1.IEBitmap.Width) and (by>=0) and (by<ImageEnView1.IEBitmap.Height) then
  begin
    x1:=ImageEnView1.XBmp2Scr(bx);
    y1:=ImageEnView1.YBmp2Scr(by);
    x2:=ImageEnView1.XBmp2Scr(bx+1);
    y2:=ImageEnView1.YBmp2Scr(by+1);
    with ImageEnView1.GetCanvas do
    begin
      Pen.Color:=clRed;
      Pen.Style:=psSolid;
      Brush.Style:=bsClear;
      Rectangle(x1,y1,x2,y2);
    end;
  end;
end;

end.
