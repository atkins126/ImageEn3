unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ExtCtrls, Buttons, StdCtrls, ComCtrls, imageenproc, hyieutils, hyiedefs;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    GroupBox1: TGroupBox;
    SelRectangle: TSpeedButton;
    SelEllipse: TSpeedButton;
    GroupBox2: TGroupBox;
    PageControl1: TPageControl;
    TabColor: TTabSheet;
    Label1: TLabel;
    Button1: TButton;
    Panel2: TPanel;
    ColorDialog1: TColorDialog;
    Button2: TButton;
    TabImage: TTabSheet;
    ImageEnView2: TImageEnView;
    Button3: TButton;
    TabTile: TTabSheet;
    Button4: TButton;
    ImageEnView3: TImageEnView;
    SelPolygon: TSpeedButton;
    SelMagic1: TSpeedButton;
    SelMagic2: TSpeedButton;
    SelMagic3: TSpeedButton;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    Button5: TButton;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure SelRectangleClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ImageEnView1.SelectionMaskDepth:=8; // we need selections with 8 bit depth (256 levels) to make soft selections
  ImageEnView1.IO.LoadFromFile('hongkong.jpg');
  ImageEnView2.IO.LoadFromFile('mask.jpg');
  ImageEnView3.IO.LoadFromFile('tile.bmp');
end;

// change zoom
procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.Zoom:=TrackBar1.Position;
  Label2.Caption:='Zoom ('+inttostr(TrackBar1.Position)+'%)';
end;

// File | Exit
procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open
procedure TForm1.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog('','',true,0,'') );
end;

// change selection style
procedure TForm1.SelRectangleClick(Sender: TObject);
begin
  if SelRectangle.Down then
    ImageEnView1.MouseInteract:=[miSelect]
  else if SelEllipse.Down then
    ImageEnView1.MouseInteract:=[miSelectCircle]
  else if SelPolygon.Down then
    ImageEnView1.MouseInteract:=[miSelectPolygon]
  else if SelMagic1.Down then
  begin
    ImageEnView1.MouseInteract:=[miSelectMagicWand];
    ImageEnView1.MagicWandMode:=iewInclusive;
  end
  else if SelMagic2.Down then
  begin
    ImageEnView1.MouseInteract:=[miSelectMagicWand];
    ImageEnView1.MagicWandMode:=iewExclusive;
  end
  else if SelMagic3.Down then
  begin
    ImageEnView1.MouseInteract:=[miSelectMagicWand];
    ImageEnView1.MagicWandMode:=iewGlobal;
  end;
end;

// select color
procedure TForm1.Button1Click(Sender: TObject);
begin
  ColorDialog1.Color:=Panel2.Color;
  if ColorDialog1.Execute then
    Panel2.Color:=ColorDialog1.Color;
end;

// Load image to replace
procedure TForm1.Button3Click(Sender: TObject);
begin
  with ImageEnView2.IO do
    LoadFromFile( ExecuteOpenDialog('','',true,0,'') );
end;

// Load tile
procedure TForm1.Button4Click(Sender: TObject);
begin
  with ImageEnView3.IO do
    LoadFromFile( ExecuteOpenDialog('','',true,0,'') );
end;

// make soft selection
procedure TForm1.Button5Click(Sender: TObject);
begin
  ImageEnView1.MakeSelectionFeather(4);
end;

// replace
procedure TForm1.Button2Click(Sender: TObject);
begin
  if PageControl1.ActivePage=TabColor then
    // color
    ImageEnView1.Proc.Fill( TColor2TRGB( Panel2.Color ))
  else if PageControl1.ActivePage=TabImage then
  begin
    // mask
    ImageEnView2.Proc.SaveUndo(ieuImage);
    ImageEnView2.Proc.ImageResize(ImageEnView1.IEBitmap.Width,ImageEnView1.IEBitmap.Height,iehLeft,ievTop);
    ImageEnView1.SelectionMask.CopyIEBitmap( ImageEnView1.IEBitmap, ImageEnView2.IEBitmap, false,false,true );
    ImageEnView1.Update;
    ImageEnView2.Proc.Undo;
  end else if PageControl1.ActivePage=TabTile then
  begin
    // tile
    ImageEnView3.Proc.SaveUndo(ieuImage);
    ImageEnView3.Proc.MakeTile( ImageEnView1.IEBitmap.Width div ImageEnView3.IEBitmap.Width+1, ImageEnView1.IEBitmap.Height div ImageEnView3.IEBitmap.Height+1);
    ImageEnView1.SelectionMask.CopyIEBitmap( ImageEnView1.IEBitmap, ImageEnView3.IEBitmap, false,false,true );
    ImageEnView1.Update;
    ImageEnView3.Proc.Undo;
  end;
end;



end.
