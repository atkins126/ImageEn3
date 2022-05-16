unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, iemview, ieopensavedlg, Menus, ExtCtrls, imageenview, imageenio;

type
  TForm1 = class(TForm)
    ImageEnMView1: TImageEnMView;
    OpenImageEnDialog1: TOpenImageEnDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    N1: TMenuItem;
    Print1: TMenuItem;
    procedure Open1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// File Open

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
  begin
    ImageEnMView1.MIO.LoadFromFile(OpenImageEnDialog1.FileName);
    ImageEnMView1.VisibleFrame := 0;
    ImageEnMView1.EnableResamplingOnMinor := false;
  end;
end;

// resize

procedure TForm1.FormResize(Sender: TObject);
begin
  ImageEnMView1.ScrollBars := ssNone;
  ImageEnMView1.ThumbWidth := ImageEnMView1.Width;
  ImageEnMView1.ThumbHeight := ImageEnMView1.Height;
end;

// prev page

procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnMView1.VisibleFrame := ImageEnMView1.VisibleFrame - 1;
end;

// next page

procedure TForm1.Button2Click(Sender: TObject);
begin
  ImageEnMView1.VisibleFrame := ImageEnMView1.VisibleFrame + 1;
end;

// print page

procedure TForm1.Print1Click(Sender: TObject);
var
  ie: TImageEnView;
begin
  ie := TImageEnView.Create(nil);
  ie.Assign(ImageEnMView1.GetBitmap(ImageEnMView1.VisibleFrame));
  ImageEnMView1.ReleaseBitmap(ImageEnMView1.VisibleFrame);
  ie.IO.DialogsMeasureUnit := ieduCm;
  ie.DpiX := ImageEnMView1.MIO.Params[ImageEnMView1.VisibleFrame].DpiX;
  ie.DpiY := ImageEnMView1.MIO.Params[ImageEnMView1.VisibleFrame].DpiY;
  ie.IO.DoPrintPreviewDialog(iedtDialog, 'Print Thumbnail');
  ie.free;
end;

end.
