unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, iemview, Db, Grids, DBGrids, DBTables, hyieutils, imageenview,
  StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    ImageEnMView1: TImageEnMView;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    procedure ImageEnMView1ImageIDRequestEx(Sender: TObject; ID: Integer;
      var Bitmap: TIEBitmap);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tempIE:TImageEnView;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// this could be slow on a large amount of images, so you should add ID to an hash table or something other.
function ImageFromID(iem:TImageEnMView; ID:integer):integer;
var
  i:integer;
begin
  for i:=0 to iem.ImageCount-1 do
    if iem.ImageID[i]=ID then
    begin
      result:=i;
      exit;
    end;
  result:=0;
end;

procedure TMainForm.ImageEnMView1ImageIDRequestEx(Sender: TObject; ID: Integer; var Bitmap: TIEBitmap);
var
  ms:TMemoryStream;
  im:integer;
begin
  im:=ImageFromID(ImageEnMView1,ID);
  Table1.RecNo:=ID;
  ms:=TMemoryStream.Create;
  (Table1.FieldByName('Photo') as TBlobField).SaveToStream( ms );
  ms.Position:=0;
  tempIE.IO.LoadFromStream( ms );
  ms.free;
  Bitmap:=tempIE.IEBitmap;
  ImageEnMView1.ImageBottomText[ im ].Caption:= Table1.FieldByName('Name').AsString;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Table1.DatabaseName := ExtractFilePath(application.exename);
  Table1.Open;
  tempIE:=TImageEnView.Create(nil);
  ImageEnMView1.SoftShadow.Enabled:=true;

  Edit1Change(self);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  tempIE.free;
end;

// setup corrispondence among TImageEnMView and the dataset
procedure TMainForm.Edit1Change(Sender: TObject);
var
  im:integer;
begin
  if Edit1.Text<>'' then
  begin
    Table1.FilterOptions:=[foCaseInsensitive];
    Table1.Filter:='Name='''+Edit1.text+'*''';
    Table1.Filtered:=true;
  end
  else
    Table1.Filtered:=false;
  ImageEnMView1.Clear;
  Table1.First;
  while not Table1.Eof do
  begin
    im:=ImageEnMView1.AppendImage;
    ImageEnMView1.ImageID[ im ] := Table1.RecNo;  // some query or dataset haven't a valid RecNo, so you should find
                                                  // another way to indentify a record
    Table1.Next;
  end;
end;

end.
