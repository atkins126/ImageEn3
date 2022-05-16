unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, FileCtrl, StdCtrls, ExtCtrls, hyieutils, imageenproc,
  ieopensavedlg, imageenview;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    ListView1: TListView;
    Label1: TLabel;
    Edit1: TEdit;
    Page: TUpDown;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ProgressBar1: TProgressBar;
    Button7: TButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    Button8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure PageClick(Sender: TObject; Button: TUDBtnType);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tags:TIETIFFHandler;
    procedure ShowPageTags;
    procedure ChangesPage;
  end;

var
  MainForm: TMainForm;

implementation

uses utagedit, ushowpage;

{$R *.DFM}


procedure TMainForm.FormCreate(Sender: TObject);
begin
  tags:=TIETIFFHandler.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  tags.Free;
end;

procedure TMainForm.FileListBox1Change(Sender: TObject);
begin
  tags.ReadFile( FileListBox1.FileName );
  ChangesPage;
end;

procedure TMainForm.ChangesPage;
begin
  Label2.Caption:=' of '+IntToStr(tags.GetPagesCount);
  Page.Position:= imin(Page.Position,tags.GetPagesCount);
  Page.max:=tags.GetPagesCount-1;
  ShowPageTags;
end;

procedure TMainForm.PageClick(Sender: TObject; Button: TUDBtnType);
begin
  ShowPageTags;
end;

function Typ2Str(tagtype:TIETagType):string;
begin
  case tagtype of
    ttUnknown: result:='Unknown';
    ttByte: result:='Byte';
    ttAscii: result:='Ascii';
    ttShort: result:='Short';
    ttLong: result:='Long';
    ttRational: result:='Rational';
    ttSByte: result:='Signed Byte';
    ttUndefined: result:='Undefined';
    ttSShort: result:='Signed Short';
    ttSLong: result:='Signed Long';
    ttSRational: result:='Signed Rational';
    ttFloat: result:='Float';
    ttDouble: result:='Double';
  end;
end;

procedure TMainForm.ShowPageTags;
var
  tagindex:integer;
  tagscount:integer;
  tagcode:integer;
  tagtype:TIETagType;
  taglen:integer;
  pageindex:integer;
  litem:TListItem;

  procedure ShowTag;
  var
    i,l:integer;
    ss:string;
  begin
    ss:='';
    l:=imin(taglen,100);
    for i:=0 to l-1 do
    begin
      ss:=ss+ string(tags.GetValue(pageindex,tagindex,i));
      if i<l-1 then
        ss:=ss+', ';
    end;
    if l<taglen then
      ss:=ss+'...';
    litem.SubItems.Add( ss );
  end;

begin
  ListView1.Items.BeginUpdate;
  ListView1.Items.Clear;
  pageindex:=Page.Position;
  tagscount:=tags.GetTagsCount( pageindex );
  for tagindex:=0 to tagscount-1 do
  begin
    litem:=ListView1.Items.Add;
    with litem do
    begin
      tagcode:=tags.GetTagCode(pageindex, tagindex);
      tagtype:=tags.GetTagType(pageindex, tagindex);
      taglen :=tags.GetTagLength(pageindex, tagindex);

      Caption:=IntToStr(tagcode)+' ('+tags.GetTagDescription(pageindex,tagindex)+')';
      SubItems.Add( Typ2Str(tagtype) );
      SubItems.Add( IntToStr(taglen));

      if tagtype=ttAscii then
        SubItems.Add( tags.GetString(pageindex,tagindex) )
      else
        ShowTag;

    end;
  end;
  ListView1.Items.EndUpdate;
end;

// Save
procedure TMainForm.Button1Click(Sender: TObject);
begin
  tags.WriteFile('output.tif');
  ShowMessage('File saved as "output.tif"');
end;

// Add Tag
procedure TMainForm.Button2Click(Sender: TObject);
begin
  with ftagedit do
  begin
    TagCode.Text:='';
    TagType.ItemIndex:=2;
    TagValue.Text:='';
    if ShowModal=mrOK then
      tags.SetValue( Page.Position, StrToIntDef(TagCode.Text,0), TIETagType(TagType.ItemIndex),TagValue.Text);
    ShowPageTags;
  end;
end;

// Delete tag
procedure TMainForm.Button3Click(Sender: TObject);
begin
  if ListView1.Selected<>nil then
  begin
    tags.DeleteTag( Page.Position, ListView1.Selected.Index );
    ShowPageTags;
  end;
end;

// Edit tag
procedure TMainForm.Button4Click(Sender: TObject);
var
  tagindex,pageindex:integer;
begin
  if ListView1.Selected<>nil then
  begin
    tagindex:=ListView1.Selected.Index;
    pageindex:=Page.Position;
    with ftagedit do
    begin
      TagCode.Text := IntToStr( tags.GetTagCode(pageindex, tagindex) );
      TagType.ItemIndex := integer( tags.GetTagType(pageindex, tagindex) );
      TagValue.Text := tags.GetValue( pageindex, tagindex, 0 );
      if ShowModal=mrOK then
        tags.SetValue( Page.Position, StrToIntDef(TagCode.Text,0), TIETagType(TagType.ItemIndex),TagValue.Text);
    end;
    ShowPageTags;
  end;
end;

// Delete Page
procedure TMainForm.Button5Click(Sender: TObject);
begin
  if tags.GetPagesCount>1 then
  begin
    tags.DeletePage( Page.Position );
    ChangesPage;
  end;
end;

// Show Page
procedure TMainForm.Button6Click(Sender: TObject);
var
  tmp:TMemoryStream;
begin
  tmp:=TMemoryStream.Create;
  tags.WriteStream(tmp);
  tmp.Position:=0;

  fshowpage.ImageEnView1.IO.Params.TIFF_ImageIndex:=Page.Position;
  fshowpage.ImageEnView1.IO.LoadFromStreamTIFF( tmp );

  tmp.free;

  fshowpage.ImageEnView1.Fit;
  fshowpage.ShowModal;

end;

// Add/Insert TIFF
// This inserts the whole TIFF without decompressing it
procedure TMainForm.Button7Click(Sender: TObject);
var
  insertingPage:integer;
begin
  // Select file to insert (must be a tiff, otherwise look at "Add/Insert page")
  OpenImageEnDialog1.AutoSetFilter:=false;  // we want specified filters
  OpenImageEnDialog1.Filter:='TIFF files|*.tif;*.tiff';
  if OpenImageEnDialog1.Execute then
  begin
    // Choise the inserting page
    insertingPage:= StrToIntDef( InputBox('Inserting page index','Please specify the inserting page index', IntToStr(tags.GetPagesCount)),0);
    // insert the TIFF
    tags.InsertTIFFFile( OpenImageEnDialog1.FileName, insertingPage );
    // update
    ChangesPage;
  end;
end;

// Add/Insert page
// This inserts a single page loaded from a supported file
procedure TMainForm.Button8Click(Sender: TObject);
var
  insertingPage:integer;
begin
  // Select file to insert
  OpenImageEnDialog1.AutoSetFilter:=true; // we want all supported files
  if OpenImageEnDialog1.Execute then
  begin
    // Choise the inserting page
    insertingPage:= StrToIntDef( InputBox('Inserting page index','Please specify the inserting page index', IntToStr(tags.GetPagesCount)),0);
    // insert the file
    tags.InsertPageAsFile( OpenImageEnDialog1.FileName, insertingPage );
    // update
    ChangesPage;
  end;
end;

end.
