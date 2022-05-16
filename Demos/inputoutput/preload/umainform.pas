unit umainform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl, StdCtrls, ieview, imageenview, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    ImageEnView1: TImageEnView;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    ProgressBar1: TProgressBar;
    ImageEnView2: TImageEnView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GetImage(const FileName:string);
    procedure PrepareNext(index:integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// prev
procedure TForm1.Button1Click(Sender: TObject);
begin
  if FileListBox1.ItemIndex>0 then
  begin
    FileListBox1.ItemIndex:=FileListBox1.ItemIndex-1;
    GetImage(FileListBox1.FileName);
    PrepareNext(FileListBox1.ItemIndex-1);
  end;
end;

// next
procedure TForm1.Button2Click(Sender: TObject);
begin
  if FileListBox1.ItemIndex<FileListBox1.Items.Count-1 then
  begin
    FileListBox1.ItemIndex:=FileListBox1.ItemIndex+1;
    GetImage(FileListBox1.FileName);
    PrepareNext(FileListBox1.ItemIndex+1);
  end;
end;

procedure TForm1.GetImage(const FileName:string);
begin
  if ImageEnView2.IO.Params.FileName=ExtractFileName(FileName) then
    ImageEnView1.Assign( ImageEnView2 )
  else
    ImageEnView1.IO.LoadFromFile( FileName );
end;

procedure TForm1.PrepareNext(index:integer);
begin
  // load next image in "hidden"
  if (index<FileListBox1.Items.Count) and (index>=0) then
    ImageEnView2.IO.LoadFromFile( FileListBox1.Items[ index ] );
end;

procedure TForm1.FileListBox1Change(Sender: TObject);
begin
  GetImage(FileListBox1.FileName);
  PrepareNext(FileListBox1.ItemIndex+1);
end;

procedure TForm1.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position:=per;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ImageEnView2.IO.AsyncMode:=true;
  ImageEnView2.LegacyBitmap:=false;

  FileListBox1.ItemIndex:=-1;
  Button2Click(self);
end;

end.
