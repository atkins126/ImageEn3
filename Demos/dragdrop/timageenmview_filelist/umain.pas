unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IEMIO, IEOpenSaveDlg, ieview, IEMView, FileCtrl, Buttons, ImageEnIO,
  XPMan;

type
  TForm1 = class(TForm)
    ImageEnMView1: TImageEnMView;
    OpenImageEnDialog1: TOpenImageEnDialog;
    ImageEnMIO1: TImageEnMIO;
    Button1: TButton;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Label1: TLabel;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure FileListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FileListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ImageEnMView1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageEnMView1DblClick(Sender: TObject);
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
begin
  if OpenImageEnDialog1.Execute then
    ImageEnMIO1.LoadFromFile(OpenImageEnDialog1.FileName);
end;

procedure TForm1.FileListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source is TImageEnMView then
    Accept := True;
end;

procedure TForm1.FileListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i: integer;
  idx: integer;
  tmpbmp: TBitmap;
  io: TImageEnIO;
begin
  io := TImageEnIO.Create(self);
  for i := 0 to ImageEnMView1.MultiSelectedImagesCount - 1 do
  begin
    idx := ImageEnMView1.MultiSelectedImages[i];
    tmpbmp := ImageEnMView1.GetBitmap(idx);
    io.AttachedBitmap := tmpbmp;
    io.SaveToFile(DirectoryListBox1.Directory + '\' + inttostr(idx) + '.bmp');
    ImageEnMView1.ReleaseBitmap(idx);
  end;
  io.free;
  FileListBox1.Update;
end;

procedure TForm1.ImageEnMView1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  ImageEnMView1.IEEndDrag;
end;

procedure TForm1.ImageEnMView1DblClick(Sender: TObject);
begin
  ImageEnMView1.IEBeginDrag(false,-1);
end;

end.
