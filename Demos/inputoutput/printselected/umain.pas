unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ieview, ImageEnView, IEOpenSaveDlg;

type
  TForm1 = class(TForm)
    OpenImageEnDialog1: TOpenImageEnDialog;
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ImageEnIO;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
    ImageEnView1.io.LoadFromFile(OpenImageEnDialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  tempbmp: TBitmap;
  io: TImageEnIO;
begin

  if not ImageEnView1.Selected then
  begin
    ShowMessage('Please select an image region');
    exit;
  end;

  tempbmp := TBitmap.Create;
  io := TImageEnIO.Create(self);
  io.AttachedBitmap := tempbmp;
  ImageEnView1.CopySelectionToBitmap(tempbmp);
  io.DoPrintPreviewDialog(iedtDialog, '');
  io.free;
  tempbmp.free;

  (* another way
  ImageEnView1.proc.CropSel;
    ImageEnView1.io.DoPrintPreviewDialog(iedtDialog);
    ImageEnVIew1.proc.Undo;
    *)
end;

end.
