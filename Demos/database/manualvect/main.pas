unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ImageEn, DBImageEn, ExtCtrls, Grids, DBGrids,
  ComCtrls, Mask, DBCtrls, ImageEnView, ImageEnProc, ImageEnIO,
  IEOpenSaveDlg, IEVect, ieview;

type
  TMainForm = class(TForm)
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Table1: TTable;
    DataSource1: TDataSource;
    Button4: TButton;
    Panel1: TPanel;
    OpenImageEnDialog1: TOpenImageEnDialog;
    Panel4: TPanel;
    Button10: TButton;
    Button11: TButton;
    ImageEnVect1: TImageEnVect;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
  Table1.DatabaseName := ExtractFilePath(application.exename);
  Table1.Open;
  ImageEnVect1.MouseInteractVt := [miObjectSelect];
end;

procedure TMainForm.Button9Click(Sender: TObject);
begin

end;

// put memo
procedure TMainForm.Button10Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miPutMemo];
end;

// select
procedure TMainForm.Button11Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miObjectSelect];
end;

// load image/objects from Table1 (as 'all' file format)
procedure TMainForm.Table1AfterScroll(DataSet: TDataSet);
var
  ms:TMemoryStream;
begin
  ms:=TMemoryStream.Create;
  TBlobField(Table1.FieldByName('Photo')).SaveToStream(ms);
  ms.Position:=0;
  ImageEnVect1.LoadFromStreamAll( ms );
  ms.Free;
end;

// Open file... (import a file)
procedure TMainForm.Button1Click(Sender: TObject);
begin
  ImageEnVect1.IO.LoadFromFile( ImageEnVect1.IO.ExecuteOpenDialog );
end;

// Save image/objects to Table1 (as 'all' file format)
procedure TMainForm.Button4Click(Sender: TObject);
var
  ms:TMemoryStream;
begin
  ms:=TMemoryStream.Create;
  ImageEnVect1.SaveToStreamAll( ms );
  ms.Position := 0;
  Table1.Edit;
  TBlobField(Table1.FieldByName('Photo')).LoadFromStream( ms );
  Table1.Post;
  ms.Free;
end;

end.
