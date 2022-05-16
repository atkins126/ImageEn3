unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl, StdCtrls, ieview, ImageEnView, ComCtrls;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    ImageEnView2: TImageEnView;
    Label1: TLabel;
    Label2: TLabel;
    FileListBox1: TFileListBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses imageenproc, hyiedefs;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  path: string;
begin
  path := extractfilepath(paramstr(0));
  directorylistbox1.Directory := path;
end;

procedure TForm1.FileListBox1Change(Sender: TObject);
var
  dd: double;
  ww, hh, perx, pery: integer;
  tk1, tk2: dword;
begin
  if filelistbox1.FileName <> '' then
  begin
    Screen.Cursor := crHourglass;
    Label4.caption := '';
    Label3.caption := 'Loading...';
    application.processmessages;
    ImageEnView1.io.LoadFromFile(filelistbox1.FileName);
    imageenview1.fit;
    Label3.caption := 'Detect orientation...';
    application.processmessages;

    // remove borders (not good for all documents)
    ww := ImageEnView1.Bitmap.Width;
    perx := trunc(ww * 10 / 100); // 10% of the width
    hh := ImageEnView1.Bitmap.Height;
    pery := trunc(hh * 10 / 100); // 10% of the height
    ImageEnView1.SelectionBase := iesbBitmap;
    ImageEnView1.Select(perx, pery, ww - perx, hh - pery, iespReplace);
    ImageEnView1.Proc.CropSel;

    // detect orientation
    tk1 := gettickcount;
    if not CheckBox1.Checked then
      dd := ImageEnView1.Proc.SkewDetection(300, 15, 0.1, true)
    else
      dd := ImageEnView1.Proc.SkewDetection(0, 15, 0.1, false); // another way
    tk2 := gettickcount;
    Label9.Caption := inttostr(tk2 - tk1) + ' ms';

    // reset original image
    ImageEnView1.proc.Undo;

    // copy original image to target image
    ImageEnView2.Assign(ImageEnView1);

    // adjust image (rotate)
    Label3.caption := 'Rotating...';
    application.processmessages;
    imageenview2.Background := clwhite;
    //ImageEnView2.Proc.Rotate(dd);
    ImageEnView2.Proc.RotateAndCrop(dd);

    //
    imageenview2.fit;
    Label3.caption := '-';
    application.processmessages;
    Label4.caption := 'Need to rotate for ' + floattostr(dd) + '°';
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  imageenview1.zoom := trackbar1.position;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  imageenview2.zoom := trackbar2.position;
end;

end.
