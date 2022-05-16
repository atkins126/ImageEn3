unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ieview, imageenview, hyiedefs, hyieutils, iegdiplus, imageenproc,
  Buttons;

type
  TMainForm = class(TForm)
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    Test1Button: TSpeedButton;
    Test2Button: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Test1ButtonClick(Sender: TObject);
    procedure Test2ButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    images:TList; // list of TIEBitmap objects
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
  images := TList.Create;
  for i:=0 to 8 do
    images.Add( TIEBitmap.Create(IntToStr(i+1)+'.jpg') );
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to 8 do
    TIEBitmap(images[i]).Free;
  images.Free;
end;

procedure TMainForm.Test1ButtonClick(Sender: TObject);
var
  i, j:integer;
  iec:tiecanvas;
  ww,hh:integer;
  oc:TIEQuadCoords;
  rotX, rotY:double;
  color:TColor;
begin
  if not Test1Button.Down then
    exit;

  color := $00303010;
  ImageEnView1.Proc.AutoUndo := false;
  ImageEnView1.Background := color;
  ImageEnView1.BackgroundStyle := iebssolid;
  //ImageEnView1.Proc.ImageResize(1100,600);
  ImageEnView1.Proc.Fill(color);

  ImageEnView1.IEBitmap.AlphaChannel.Full := false;
  iec := TIECanvas.Create(ImageEnView1.IEBitmap.Canvas);
  iec.Pen.Color := clWhite;
  iec.Pen.Width := 2;
  iec.Brush.style := bsclear;
  ww := 250;
  hh := 250;

  while Test1Button.Down do
  begin
    i := 0;
    while i <360 do
    begin

      ImageEnView1.IEBitmap.Fill(color);
      ImageEnView1.IEBitmap.AlphaChannel.Fill(255);

      for j:=0 to 3 do
      begin
        rotX := i;
        rotY := 0;
        if (j mod 2) = 0 then
          iedswap(rotX, rotY);
        // draw bitmap
        oc := ImageEnView1.Proc.ProjectDraw(TIEBitmap(images[j]), 200+j*200,200, ww,hh, 400, 0,0, rotX,rotY, 0,150);
        // draw countour
        iec.MoveTo(oc.x0, oc.y0); iec.LineTo(oc.x1, oc.y1); iec.LineTo(oc.x2, oc.y2); iec.LineTo(oc.x3, oc.y3); iec.LineTo(oc.x0, oc.y0);
      end;

      ImageEnView1.Update;
      ImageEnView1.Paint;
      Application.ProcessMessages;

      if not Test1Button.Down then
        break;

      inc(i,4);
    end;
  end;

  iec.Free;

end;

procedure TMainForm.Test2ButtonClick(Sender: TObject);
var
  i, j:integer;
  iec:tiecanvas;
  ww,hh:integer;
  oc:TIEQuadCoords;
  color:TColor;
begin
  if not Test2Button.Down then
    exit;

  color := $00303010;
  ImageEnView1.Proc.AutoUndo := false;
  ImageEnView1.Background := color;
  ImageEnView1.BackgroundStyle := iebssolid;
  //ImageEnView1.Proc.ImageResize(1100,600);
  ImageEnView1.Proc.Fill(color);

  ImageEnView1.IEBitmap.AlphaChannel.Full := false;
  iec := TIECanvas.Create(ImageEnView1.IEBitmap.Canvas);
  iec.Pen.Color := clWhite;
  iec.Pen.Width := 2;
  iec.Brush.style := bsclear;
  ww := 400;
  hh := 400;

  j := 0;
  while Test2Button.Down do
  begin
    i := 0;
    while i < 360 do
    begin

      ImageEnView1.IEBitmap.Fill(color);
      ImageEnView1.IEBitmap.AlphaChannel.Fill(255);

      // draw bitmap
      oc := ImageEnView1.Proc.ProjectDraw(TIEBitmap(images[j]), 550,200, ww,hh, 600, 0,0, 0,i, 0,150);
      // draw countour
      iec.MoveTo(oc.x0, oc.y0); iec.LineTo(oc.x1, oc.y1); iec.LineTo(oc.x2, oc.y2); iec.LineTo(oc.x3, oc.y3); iec.LineTo(oc.x0, oc.y0);

      ImageEnView1.Update;
      ImageEnView1.Paint;
      Application.ProcessMessages;

      if not Test2Button.Down then
        break;

      inc(i,2);
      if (i=90) or (i=270) then inc(j);
      if j=8 then j:=0;
    end;
  end;

  iec.Free;

end;


procedure TMainForm.FormResize(Sender: TObject);
begin
  Test1Button.Down := false;
  Test2Button.Down := false;
  ImageEnView1.Proc.ImageResize(ImageEnView1.Width, ImageEnView1.Height);
end;

end.
