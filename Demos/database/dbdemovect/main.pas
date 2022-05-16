unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ImageEn, DBImageEn, ExtCtrls, Grids, DBGrids,
  ComCtrls, Mask, DBCtrls, ImageEnView, ImageEnProc, ImageEnIO,
  IEOpenSaveDlg, IEVect, dbimageenvect, ieview;

type
  TMainForm = class(TForm)
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Table1: TTable;
    DataSource1: TDataSource;
    New: TButton;
    Del: TButton;
    Button1: TButton;
    Button4: TButton;
    ImageEnProc1: TImageEnProc;
    ImageEnIO1: TImageEnIO;
    Panel1: TPanel;
    Panel3: TPanel;
    Zoom: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Button2: TButton;
    TrackBar1: TTrackBar;
    DBEdit1: TDBEdit;
    ComboBox1: TComboBox;
    Button8: TButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    ImageEnDBVect1: TImageEnDBVect;
    Panel4: TPanel;
    Button9: TButton;
    Button10: TButton;
    Label3: TLabel;
    Button11: TButton;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DelClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

//uses GifLZW,TifLZW;     // uncomment to enable Gif and TIFF-LZW

{$R *.DFM}

// Import...

procedure TMainForm.Button2Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
    ImageEnIO1.LoadFromFile(OpenImageEnDialog1.filename);
end;

// zoom

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
  ImageEnDBVect1.Zoom := TrackBar1.Position;
end;

// New

procedure TMainForm.NewClick(Sender: TObject);
begin
  Table1.Append;
end;

// Post

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if Table1.State <> dsBrowse then
  begin
    Table1.Post;
    label5.caption := ComboBox1.Items.Strings[ord(ImageEnDBVect1.LoadedFieldImageFormat)];
  end;
end;

// Del/Cancel

procedure TMainForm.DelClick(Sender: TObject);
begin
  if (Table1.State = dsEdit) or (Table1.State = dsInsert) then
    Table1.Cancel
  else
    Table1.Delete;
end;

// Modify

procedure TMainForm.Button4Click(Sender: TObject);
begin
  Table1.Edit;
end;

//

procedure TMainForm.FormActivate(Sender: TObject);
begin
  // uncomment to enable Gif and TIFF-LZW
    (*
    DefGIF_LZWDECOMPFUNC:=GIFLZWDecompress;
    DefGIF_LZWCOMPFUNC:=GIFLZWCompress;
    DefTIFF_LZWDECOMPFUNC:=TIFFLZWDecompress;
    DefTIFF_LZWCOMPFUNC:=TIFFLZWCompress;
    *)
  Table1.DatabaseName := ExtractFilePath(application.exename);
  Table1.Open;
  ImageEnDBVect1.MouseInteractVt := [miObjectSelect];
  ImageEnDBVect1.DataFieldImageFormat := ifJpeg;
  ImageEnDbVect1.ObjPenColor[-1] := clWhite;
  ComboBox1.ItemIndex := 1;
end;

// change combobox - store format

procedure TMainForm.ComboBox1Change(Sender: TObject);
begin
  ImageEnDBVect1.DataFieldImageFormat := TDataFieldImageFormat(ComboBox1.ItemIndex);
end;

// update combobox - store format

procedure TMainForm.Table1AfterScroll(DataSet: TDataSet);
begin
  label5.caption := ComboBox1.Items.Strings[ord(ImageEnDBVect1.LoadedFieldImageFormat)];
end;

// Store paramters

procedure TMainForm.Button8Click(Sender: TObject);
begin
  ImageEnDBVect1.DoIOPreview;
end;

// put line

procedure TMainForm.Button9Click(Sender: TObject);
begin
  ImageEnDBVect1.MouseInteractVt := [miPutLine];
end;

// put text

procedure TMainForm.Button10Click(Sender: TObject);
begin
  ImageEnDBVect1.MouseInteractVt := [miPutText];
end;

// select

procedure TMainForm.Button11Click(Sender: TObject);
begin
  ImageEnDBVect1.MouseInteractVt := [miObjectSelect];
end;

end.
