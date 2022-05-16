unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ExtCtrls, StdCtrls, Buttons, hyieutils, imageenproc, hyiedefs,
  ComCtrls;

type
  TMainForm = class(TForm)
    Panel: TPanel;
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    ColorDialog1: TColorDialog;
    CheckBox1: TCheckBox;
    PageControl1: TPageControl;
    BrushTab: TTabSheet;
    RectangleButton: TSpeedButton;
    CircleButton: TSpeedButton;
    PointsButton: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BrushSize: TEdit;
    BrushColor: TPanel;
    Transparency: TEdit;
    Antialias: TCheckBox;
    Label5: TLabel;
    Operation: TComboBox;
    PaintTab: TTabSheet;
    PaintPoint: TSpeedButton;
    PaintLine: TSpeedButton;
    PaintColor: TPanel;
    Label6: TLabel;
    PaintEllipse: TSpeedButton;
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure BrushColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CreateBrush(Sender: TObject);
    procedure ImageEnView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure PaintColorClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    startX,startY:integer;
    lastX,lastY:integer;
  public
    { Public declarations }

  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ImageEnView1.LayersSync:=false;
  ImageEnView1.MinBitmapSize:=1;
  ImageEnView1.DisplayGrid:=true;
  ImageEnView1.Proc.Fill( CreateRGB(255,255,255) );
  ImageEnView1.Proc.AutoUndo:=False;
  Operation.ItemIndex:=0;
end;

// File | Open
procedure TMainForm.Open1Click(Sender: TObject);
begin
  ImageEnView1.LayersCurrent:=0;
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog('','',false,1,'') );
end;

// File | Close
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// Zoom
procedure TMainForm.ScrollBar1Change(Sender: TObject);
begin
  ImageEnView1.Zoom:=ScrollBar1.Position;
end;

// Select brush color
procedure TMainForm.BrushColorClick(Sender: TObject);
begin
  ColorDialog1.Color:=BrushColor.Color;
  if ColorDialog1.Execute then
    BrushColor.Color:=ColorDialog1.Color;
  CreateBrush(self);
end;

procedure TMainForm.ImageEnView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  startX:=X;
  startY:=Y;
  if (PageControl1.ActivePage=PaintTab) and PaintPoint.Down then
  begin
    // Paint Point
    X:=ImageEnView1.XScr2Bmp(X);
    Y:=ImageEnView1.YScr2Bmp(Y);
    ImageEnView1.IEBitmap.Canvas.Pixels[X,Y]:=PaintColor.Color;
    ImageEnView1.Update;
  end
  else if (PageControl1.ActivePage=PaintTab) and PaintLine.Down then
  begin
    // Begin paint line
    ImageEnView1.Proc.SaveUndo(ieuImage);
  end
  else if (PageControl1.ActivePage=PaintTab) and PaintEllipse.Down then
  begin
    // Begin paint ellipse
    ImageEnView1.Proc.SaveUndo(ieuImage);
  end
  else if (PageControl1.ActivePage=BrushTab) then
    ImageEnView1MouseMove(self,Shift,X,Y);
end;

// moving mouse (move the brush layer)
procedure TMainForm.ImageEnView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  px,py:integer;
  bx,by:integer;
  op:TIERenderOperation;
begin
  if (PageControl1.ActivePage=PaintTab) and PaintPoint.Down and ImageEnView1.MouseCapture then
  begin
    // Paint Point
    ImageEnView1.IEBitmap.Canvas.Pixels[ ImageEnView1.XScr2Bmp(X) , ImageEnView1.YScr2Bmp(Y) ]:=PaintColor.Color;
    ImageEnView1.Update;
  end
  else if (PageControl1.ActivePage=PaintTab) and PaintLine.Down and ImageEnView1.MouseCapture then
  begin
    // Paint Line
    with ImageEnView1 do
    begin
      Proc.UndoRect(XScr2Bmp(startX),YScr2Bmp(startY),XScr2Bmp(lastX),YScr2Bmp(lastY));
      IEBitmap.Canvas.Pen.Color:=PaintColor.Color;
      IEBitmap.Canvas.MoveTo( XScr2Bmp(startX), YScr2Bmp(startY) );
      IEBitmap.Canvas.LineTo( XScr2Bmp(X), YScr2Bmp(Y) );
      Update;
    end;
  end
  else if (PageControl1.ActivePage=PaintTab) and PaintEllipse.Down and ImageEnView1.MouseCapture then
  begin
    // Paint Ellipse
    with ImageEnView1 do
    begin
      Proc.UndoRect(XScr2Bmp(startX),YScr2Bmp(startY),XScr2Bmp(lastX),YScr2Bmp(lastY));
      IEBitmap.Canvas.Pen.Color:=PaintColor.Color;
      IEBitmap.Canvas.Ellipse(XScr2Bmp(startX), YScr2Bmp(startY), XScr2Bmp(X), YScr2Bmp(Y) );
      Update;
    end;
  end
  else if (PageControl1.ActivePage=BrushTab) then
  begin

    op:=TIERenderOperation( self.Operation.ItemIndex );
    with ImageEnView1 do
      if LayersCount=2 then
      begin

        with Layers[1] do
        begin
          bx:=Bitmap.Width;
          by:=Bitmap.Height;
          if Antialias.Checked then
          begin
            Width:=bx div 2;
            Height:=by div 2;
          end;
          px:=XScr2Bmp(X) - Width div 2;
          py:=YScr2Bmp(Y) - Height div 2;
          PosX:=px;
          PosY:=py;
          Operation:=op;
        end;

        if MouseCapture then  // paint the layer (the brush...)
        begin
          if Antialias.Checked then
            Layers[1].Bitmap.RenderToTIEBitmapEx( Layers[0].Bitmap, px,py,bx div 2,by div 2, 0,0,bx,by, 255,rfFastLinear,op )
          else
            Layers[1].Bitmap.RenderToTIEBitmapEx( Layers[0].Bitmap, px,py,bx,by, 0,0,bx,by, 255,rfNone,op );

          Layers[1].Bitmap.MergeAlphaRectTo( Layers[0].Bitmap, 0,0,px,py, bx,by);
        end;

        Update;

      end;
  end;
  lastX:=X;
  lastY:=Y;
end;

procedure TMainForm.CreateBrush(Sender: TObject);
var
  brushsiz:integer;
  c:TColor;
  transpvalue:integer;
  i:integer;
  x,y:integer;
begin
  if ImageEnView1.LayersCount=1 then
    ImageEnView1.LayersAdd;
  ImageEnView1.LayersCurrent:=1;

  brushsiz:=StrToIntDef(BrushSize.Text,1);

  if brushsiz=1 then
    Antialias.Checked:=false;

  if Antialias.Checked then
    brushsiz:=brushsiz*2;

  ImageEnView1.Proc.ImageResize(brushsiz,brushsiz,iehLeft,ievTop);

  // prepare main color
  ImageEnView1.IEBitmap.Canvas.Brush.Color:=BrushColor.Color;
  ImageEnView1.IEBitmap.Canvas.Pen.Color:=BrushColor.Color;

  // prepare alpha channel
  ImageEnView1.AlphaChannel.Fill(0);
  with ImageEnView1.AlphaChannel.Canvas do
  begin
    transpvalue:=StrToIntDef(Transparency.Text,255);
    c := $02000000 or (transpvalue) or (transpvalue shl 8) or (transpvalue shl 16);
    Brush.Color:=c;
    Pen.Color:=c;
  end;

  // draws a rectangle brush
  if RectangleButton.Down then
  begin
    // draw the shape
    ImageEnView1.IEBitmap.Canvas.Rectangle(0,0,brushsiz+1,brushsiz+1);
    // draw the shape alpha channel
    ImageEnView1.AlphaChannel.Canvas.Rectangle(0,0,brushsiz+1,brushsiz+1);
  end

  // draws a circle brush
  else if CircleButton.Down then
  begin
    // draw the shape
    ImageEnView1.IEBitmap.Canvas.Ellipse(0,0,brushsiz+1,brushsiz+1);
    // draw the shape alpha channel
    ImageEnView1.AlphaChannel.Canvas.Ellipse(0,0,brushsiz+1,brushsiz+1);
  end

  // draws random points brush (should be a "spray"...)
  else if PointsButton.Down and (brushsiz>1) then
  begin
    for i:=0 to brushsiz*3 do // change "3" to adjust the spary intensity
    begin
      repeat
        x:=random(brushsiz);
        y:=random(brushsiz);
      until sqr(x-brushsiz div 2)+sqr(y-brushsiz div 2) < sqr(brushsiz div 2);  // repeat until (x,y) is inside a circle!
      ImageEnView1.IEBitmap.Canvas.Pixels[x,y]:=BrushColor.Color;
      ImageEnView1.AlphaChannel.Canvas.Pixels[x,y]:=c;
    end;
  end;

  ImageEnView1MouseMove(self,[],0,0); // refresh current brush
end;

procedure TMainForm.CheckBox1Click(Sender: TObject);
begin
  ImageEnView1.DisplayGrid:=CheckBox1.Checked;
end;

// select paint color
procedure TMainForm.PaintColorClick(Sender: TObject);
begin
  ColorDialog1.Color:=PaintColor.Color;
  if ColorDialog1.Execute then
    PaintColor.Color:=ColorDialog1.Color;
end;

procedure TMainForm.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=PaintTab then
    ImageEnView1.LayersRemove(1)
  else if PageControl1.ActivePage=BrushTab then
    CreateBrush(self);
end;


end.
