unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl, StdCtrls, ieview, IEMView, ImageEnIO, ComCtrls, XPMan;

type
  TForm1 = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    ImageEnMView1: TImageEnMView;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    XPManifest1: TXPManifest;
    procedure ImageEnMView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImageEnMView1DragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.ImageEnMView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source is TFileListBox then
    Accept := True;
end;

procedure TForm1.ImageEnMView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  im: integer;
  filename: string;
begin
  filename := (Source as TFileListBox).FileName;
  if fileexists(filename) and (FindFileFormat(filename, true) <> ioUnknown) then
  begin
    im := ImageEnMView1.InsertingPoint(X, Y);
    ImageEnMView1.InsertImage(im);
    ImageEnMView1.SetImageFromFile(im, filename);
  end;
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  imageenmview1.GridWidth := updown1.Position;
end;

end.
