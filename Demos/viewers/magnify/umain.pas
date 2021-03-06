unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, ImageEnView, ComCtrls;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    ImageEnView2: TImageEnView;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure ImageEnView1Paint(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    xpos, ypos, RectWidth, RectHeight: integer;
    procedure DoMagnify;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// Open

procedure TForm1.Button1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));
end;

// draw the box

procedure TForm1.ImageEnView1Paint(Sender: TObject);
begin
  with ImageEnView1.GetCanvas do
  begin
    Pen.Color := clRed;
    Pen.Style := psSolid;
    Brush.Style := bsClear;
    Rectangle(xpos - (RectWidth div 2), ypos - (RectHeight div 2), xpos + (RectWidth div 2), ypos + (RectHeight div 2));
  end;
end;

// magnify the rectangle

procedure TForm1.DoMagnify;
var
  rc: TRect;
  ww, hh: integer;
begin
  rc.left := xpos - (RectWidth div 2);
  rc.top := ypos - (RectHeight div 2);
  rc.Right := xpos + (RectWidth div 2);
  rc.Bottom := ypos + (RectHeight div 2);

  with ImageEnView1 do
  begin
    rc.Left := XScr2Bmp(rc.Left);
    rc.Right := XScr2Bmp(rc.right);
    rc.Top := YScr2Bmp(rc.top);
    rc.Bottom := YScr2Bmp(rc.bottom);
  end;

  // copy the box
  ww := rc.right - rc.left + 1;
  hh := rc.bottom - rc.top + 1;
  ImageEnView2.IEBitmap.Allocate(ww, hh, ImageEnView1.IEBitmap.PixelFormat);
  ImageEnView1.IEBitmap.CopyRectTo(ImageEnView2.IEBitmap, rc.Left, rc.Top, 0, 0, ww, hh);

  ImageEnView2.Update;
  ImageEnView2.Fit;

  // display the box
  ImageEnView1.Paint;
end;

// moving the mouse

procedure TForm1.ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  xpos := X;
  ypos := Y;
  DoMagnify;
end;

procedure TForm1.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  RectWidth := UpDown1.Position;
  RectHeight := UpDown2.Position;
  DoMagnify;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RectWidth := 25;
  RectHeight := 25;
end;

end.
