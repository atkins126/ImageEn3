unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, IEMView, StdCtrls, IEMIO, IEOpenSaveDlg, XPMan;

type
  TForm1 = class(TForm)
    ImageEnMView1: TImageEnMView;
    Button1: TButton;
    ImageEnMView2: TImageEnMView;
    Label1: TLabel;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure ImageEnMView1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageEnMView2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImageEnMView2DragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure ImageEnMView1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  filename: string;
begin
  filename := ImageEnMView1.MIO.ExecuteOpenDialog('', '', false, 1, '');
  if filename <> '' then
  begin
    ImageEnMView1.Clear;
    ImageEnMView1.MIO.LoadFromFile(filename);
  end;
end;

procedure TForm1.ImageEnMView1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  ImageEnMView1.IEEndDrag;
  ImageEnMView1.MouseInteract := [mmiSelect];
end;

procedure TForm1.ImageEnMView2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source is TImageEnMView then
    Accept := True;
end;

procedure TForm1.ImageEnMView2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  i: integer;
  idx, im: integer;
  tmpbmp: TBitmap;
begin
  im := ImageEnMView2.InsertingPoint(X, Y);
  for i := 0 to ImageEnMView1.MultiSelectedImagesCount - 1 do
  begin
    idx := ImageEnMView1.MultiSelectedImages[i];
    tmpbmp := ImageEnMView1.GetBitmap(idx);

    ImageEnMView2.InsertImage(im);
    ImageEnMView2.SetImage(im, tmpbmp);
    inc(im);

    ImageEnMView1.ReleaseBitmap(idx);
  end;
end;

procedure TForm1.ImageEnMView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
  begin
    ImageEnMView1.MouseInteract := [];
    ImageEnMView1.IEBeginDrag(true,-1);
  end;
end;

end.
