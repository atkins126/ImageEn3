unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IEOpenSaveDlg, StdCtrls, ieview, ImageEnView, IEVect;

type
  TForm1 = class(TForm)
    ImageEnVect1: TImageEnVect;
    Button1: TButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    procedure Button1Click(Sender: TObject);
    procedure ImageEnVect1SelectionChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// load button

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
  begin
    ImageEnVect1.io.LoadFromFile(OPenImageEnDialog1.FileName);
    ImageEnVect1.ViewX := 280;
    ImageEnVect1.MouseInteract := [miSelect];
    ShowMessage('Please select the 2x2 cm square');
  end;
end;

// selection done

procedure TForm1.ImageEnVect1SelectionChange(Sender: TObject);
begin
  ImageEnVect1.SetScaleFromSelectionLen(8); // 8 cm (2 cm per side)
  ImageEnVect1.Deselect;
  ImageEnVect1.MouseInteractVt := [miDragLen];
  ShowMessage('Now you can measure lengths');
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Button1Click(self);
end;

end.
