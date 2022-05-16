unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ImageEn, DBImageEn, ExtCtrls, Grids, DBGrids,
  ComCtrls, Mask, DBCtrls, ImageEnView, ImageEnProc, ImageEnIO,
  IEOpenSaveDlg, ieview;

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
    Button3: TButton;
    TrackBar1: TTrackBar;
    DBEdit1: TDBEdit;
    ComboBox1: TComboBox;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    ImageEnDBView1: TImageEnDBView;
    OpenImageEnDialog1: TOpenImageEnDialog;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DelClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// Import...

procedure TMainForm.Button2Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
    ImageEnIO1.LoadFromFile(OpenImageEnDialog1.filename);
end;

// Effects...

procedure TMainForm.Button3Click(Sender: TObject);
begin
  ImageEnProc1.DoPreviews(ppeEffects);
end;

// Color adjust...

procedure TMainForm.Button7Click(Sender: TObject);
begin
  ImageEnProc1.DoPreviews(ppeColorAdjust);
end;

// zoom

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
  ImageEnDBView1.Zoom := TrackBar1.Position;
end;

// New

procedure TMainForm.NewClick(Sender: TObject);
var
  filename: string;
begin
  Table1.Append;
  if InputQuery('New image', 'Insert file name', filename) then
    Table1.FieldByName('ImagePath').Value := filename;
end;

// Post

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if Table1.State <> dsBrowse then
  begin
    Table1.Post;
    label4.caption := ComboBox1.Items.Strings[ord(ImageEnDBView1.LoadedFieldImageFormat)];
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
  ImageEnDBView1.AbsolutePath := extractfilepath(paramstr(0));
  Table1.DatabaseName := ExtractFilePath(application.exename);
  Table1.Open;
  ImageEnDBView1.DataFieldImageFormat := ifJpeg;
  ComboBox1.ItemIndex := 1;
end;

// change combobox - store format

procedure TMainForm.ComboBox1Change(Sender: TObject);
begin
  ImageEnDBView1.DataFieldImageFormat := TDataFieldImageFormat(ComboBox1.ItemIndex);
end;

// update combobox - store format

procedure TMainForm.Table1AfterScroll(DataSet: TDataSet);
begin
  //ComboBox1.ItemIndex:=ord(ImageEnDBView1.LoadedFieldImageFormat);
  label4.caption := ComboBox1.Items.Strings[ord(ImageEnDBView1.LoadedFieldImageFormat)];
end;

// Copy

procedure TMainForm.Button5Click(Sender: TObject);
begin
  ImageEnProc1.SelCopyToClip;
end;

// Paste

procedure TMainForm.Button6Click(Sender: TObject);
begin
  ImageEnProc1.PasteFromClipboard;
end;

// Store paramters

procedure TMainForm.Button8Click(Sender: TObject);
begin
  ImageEnDBView1.DoIOPreview;
end;

end.
