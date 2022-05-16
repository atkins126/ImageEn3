unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, imageenview, ievect, ieview, iemview, imageenio, StdCtrls, XPMan;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ImageEnMView1: TImageEnMView;
    ImageEnVect1: TImageEnVect;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    XPManifest1: TXPManifest;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure ImageEnMView1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ImageEnMView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImageEnMView1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageEnMView1DragDrop(Sender, Source: TObject; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormActivate(Sender: TObject);
begin
  ImageEnMView1.SoftShadow.Enabled:=true;
end;

// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open
procedure TMainForm.Open1Click(Sender: TObject);
var
  filename:string;
begin
  filename:=ImageEnMView1.MIO.ExecuteOpenDialog('','',false,0,'');
  if filename<>'' then
  begin
    Caption:=filename;
    ImageEnMView1.MIO.LoadFromFile( Caption );
    ImageEnMView1.SelectedImage:=0;
    ImageEnMView1ImageSelect(self, 0);
  end;
end;

// File | Print
procedure TMainForm.Print1Click(Sender: TObject);
begin
  ImageEnMView1.MIO.DoPrintPreviewDialog( Caption, true );
end;

// Image selected
procedure TMainForm.ImageEnMView1ImageSelect(Sender: TObject;
  idx: Integer);
begin
  // Copy image
  ImageEnMView1.CopyToIEBitmap( idx, ImageEnVect1.IEBitmap );
  // Copy annotations
  ImageEnVect1.RemoveAllObjects;
  ImageEnMView1.MIO.Params[idx].ImagingAnnot.CopyToTImageEnVect(ImageEnVect1);

  ImageEnVect1.Update;
end;

// begins drag/drop
procedure TMainForm.ImageEnMView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ImageEnMView1.MouseInteract := [];
    ImageEnMView1.IEBeginDrag(true,-1);
  end;
end;

// accepts drag/drop. Draws a line to signal where to insert images
procedure TMainForm.ImageEnMView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  im:integer;
  imgX,imgY:integer;
begin
  if Source=ImageEnMView1 then
  begin
    Accept := True;
    im:=ImageEnMView1.InsertingPoint(x,y);
    imgX:=ImageEnMView1.ImageX[im] - ImageEnMView1.ViewX;
    imgY:=ImageEnMView1.ImageY[im] - ImageEnMView1.ViewY;
    ImageEnMView1.Paint;
    with ImageEnMView1.GetCanvas do
    begin
      Pen.Color:=clRed;
      Pen.Width:=2;
      MoveTo(imgX+10,imgY);
      LineTo(imgX+ImageEnMView1.ThumbWidth-10,imgY);
    end;
  end;
end;

// finishes drag/drop
procedure TMainForm.ImageEnMView1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  ImageEnMView1.IEEndDrag;
  ImageEnMView1.MouseInteract := [mmiSelect];
end;

// performs drag/drop
procedure TMainForm.ImageEnMView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  im:integer;
begin
  ImageEnMView1.MultiSelectSortList;  // selection order is not important
  im := ImageEnMView1.InsertingPoint(X, Y);
  ImageEnMView1.MoveSelectedImagesTo( im );
end;

end.
