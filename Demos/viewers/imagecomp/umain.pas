unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, ExtCtrls, Menus, StdCtrls, hyiedefs;

type
  TMainForm = class(TForm)
    ImageEnView1: TImageEnView;
    ImageEnView2: TImageEnView;
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    OpenRight1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormResize(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure OpenRight1Click(Sender: TObject);
    procedure ImageEnView1ViewChange(Sender: TObject; Change: Integer);
    procedure ImageEnView2ViewChange(Sender: TObject; Change: Integer);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetViewers;
  end;

var
  MainForm: TMainForm;

implementation

uses unavi;

{$R *.DFM}

procedure TMainForm.FormResize(Sender: TObject);
begin
  ImageEnView1.Left:=0;
  ImageEnView1.Top:=0;
  ImageEnView1.Width:=ClientWidth div 2;
  ImageEnView1.Height:=ClientHeight - Panel1.Height;
  ImageEnView2.Left:=ImageEnView1.Width+2;
  ImageEnView2.Top:=0;
  ImageEnview2.Width:=ClientWidth div 2 - 2;
  ImageEnView2.Height:=ClientHeight - panel1.Height;
end;

// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.SetViewers;
begin
  ImageEnView1.Zoom:=1600;
  ImageEnView1.SetViewXY(0,0);
  ImageEnView1.DisplayGrid:=true;
  ImageEnView2.Zoom:=1600;
  ImageEnView2.SetViewXY(0,0);
  ImageEnView2.DisplayGrid:=true;
  ImageEnView1.SetNavigator( fNavi.ImageEnView1 );
  ImageEnView2.SetNavigator( fNavi.ImageEnView2 );
  fNavi.Show;
end;

// File | Open Left
procedure TMainForm.Open1Click(Sender: TObject);
begin
  ImageEnView1.IO.LoadFromFile( ImageEnView1.IO.ExecuteOpenDialog );
  SetViewers;
end;

// File | Open Right
procedure TMainForm.OpenRight1Click(Sender: TObject);
begin
  ImageEnView2.IO.LoadFromFile( ImageEnView2.IO.ExecuteOpenDialog );
  SetViewers;
end;

procedure TMainForm.ImageEnView1ViewChange(Sender: TObject;
  Change: Integer);
begin
  ImageEnView2.SetViewXY( ImageEnView1.ViewX, ImageEnView1.ViewY);
end;

procedure TMainForm.ImageEnView2ViewChange(Sender: TObject;
  Change: Integer);
begin
  ImageEnView1.SetViewXY( ImageEnView2.ViewX, ImageEnView2.ViewY);
end;

procedure TMainForm.ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  bmpx,bmpy:integer;
  rgb:TRGB;
begin
  bmpx:=ImageEnView1.XScr2Bmp(X);
  bmpy:=ImageEnView1.YScr2Bmp(Y);

  Label6.Caption:=inttostr(bmpx)+','+inttostr(bmpy);

  if (bmpx>=0) and (bmpy>=0) and (bmpx<ImageEnView1.IEBitmap.Width) and (bmpy<ImageEnView1.IEBitmap.Height) then
  begin
    rgb:=ImageEnView1.IEBitmap.Pixels[bmpx,bmpy];
    label2.Caption:=inttostr(rgb.r)+','+inttostr(rgb.g)+','+inttostr(rgb.b);
    ImageEnView1.HighlightedPixel:=Point(bmpx,bmpy);
  end;

  bmpx:=ImageEnView2.XScr2Bmp(X);
  bmpy:=ImageEnView2.YScr2Bmp(Y);

  if (bmpx>=0) and (bmpy>=0) and (bmpx<ImageEnView2.IEBitmap.Width) and (bmpy<ImageEnView2.IEBitmap.Height) then
  begin
    rgb:=ImageEnView2.IEBitmap.Pixels[bmpx,bmpy];
    label4.Caption:=inttostr(rgb.r)+','+inttostr(rgb.g)+','+inttostr(rgb.b);
    ImageEnView2.HighlightedPixel:=Point(bmpx,bmpy);
  end;

end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  FormResize(self);
end;

end.
