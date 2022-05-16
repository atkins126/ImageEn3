unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, hyieutils, StdCtrls, ieview, iemview, imageenview, imageenio,
  ComCtrls, Menus, XPMan, ImgList, ExtCtrls;

type
  TMainForm = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    XPManifest1: TXPManifest;
    ImageList1: TImageList;
    Panel1: TPanel;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    ImageEnView1: TImageEnView;
    Saveimageas1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure Saveimageas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    m_ResourceExtractor:TIEResourceExtractor;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


procedure TMainForm.FormCreate(Sender: TObject);
begin
  m_ResourceExtractor := nil;
  ImageEnView1.DisplayGrid := true;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  m_ResourceExtractor.Free;
end;

// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open
procedure TMainForm.Open1Click(Sender: TObject);
var
  i, j, k:integer;
  p1, p2:TTreeNode;
begin
  if OpenDialog1.Execute and FileExists(OpenDialog1.FileName) then
  begin

    if assigned(m_ResourceExtractor) then
      m_ResourceExtractor.Free;
    TreeView1.Items.Clear;

    m_ResourceExtractor := TIEResourceExtractor.Create( OpenDialog1.FileName );

    if m_ResourceExtractor.IsValid then
      for i:=0 to m_ResourceExtractor.TypesCount-1 do
      begin
        p1 := TreeView1.Items.Add(nil, m_ResourceExtractor.FriendlyTypes[i]);
        for j:=0 to m_ResourceExtractor.NamesCount[i]-1 do
          if m_ResourceExtractor.IsGroup[i] then
          begin
            p2 := TreeView1.Items.AddChild(p1, m_ResourceExtractor.Names[i, j]);
            for k:=0 to m_ResourceExtractor.GroupCountFrames[i, j]-1 do
              TreeView1.Items.AddChildObject(p2, IntToStr(m_ResourceExtractor.GroupFrameWidth[i, j, k])+' x ' +
                                             IntToStr(m_ResourceExtractor.GroupFrameHeight[i, j, k])+' ' +
                                             IntToStr(m_ResourceExtractor.GroupFrameDepth[i, j, k])+'-bit',
                                             m_ResourceExtractor.GetResourceBookmark(i, j, k));
          end
          else
            TreeView1.Items.AddChildObject(p1, m_ResourceExtractor.Names[i, j], m_ResourceExtractor.GetResourceBookmark(i, j));
      end;

  end;
end;



// change zoom
procedure TMainForm.ComboBox1Change(Sender: TObject);
const
  zoomv:array [0..6] of double = (0, 25, 50, 100, 200, 400, 800);
begin
  if ComboBox1.ItemIndex = 0 then
  begin
    ImageEnView1.AutoFit := true;
    ImageEnView1.Update;
  end
  else
  begin
    ImageEnView1.AutoFit := false;
    ImageEnView1.Zoom := zoomv[ComboBox1.ItemIndex];
  end;
end;

// Show Grid
procedure TMainForm.CheckBox1Click(Sender: TObject);
begin
  ImageEnView1.DisplayGrid := CheckBox1.Checked;
end;


procedure TMainForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  res:TIEResourceBookmark;
  buffer:pointer;
  bufferLen:integer;
  fileType:TIOFileType;
begin
  if not Node.HasChildren and assigned(Node.Data) then
  begin

    res := TIEResourceBookmark(Node.Data);
    buffer := m_ResourceExtractor.GetBuffer(res, bufferLen);

    // We cannot use ioUnknown (autodect) for BMP, CUR and ICO because it is not possible to autodetect BMP, CUR and ICO when they are resources.
    fileType := ioUnknown;
    if (m_ResourceExtractor.FriendlyTypes[res.TypeIndex] = 'GroupIcon') or (m_ResourceExtractor.FriendlyTypes[res.TypeIndex] = 'Icon') then
      fileType := ioICO
    else if (m_ResourceExtractor.FriendlyTypes[res.TypeIndex] = 'GroupCursor') or (m_ResourceExtractor.FriendlyTypes[res.TypeIndex] = 'Cursor') then
      fileType := ioCUR
    else if m_ResourceExtractor.FriendlyTypes[res.TypeIndex] = 'Bitmap' then
      fileType := ioBMP;

    ImageEnView1.IO.Params.IsResource := true;
    ImageEnView1.IO.LoadFromBuffer(buffer, bufferLen, fileType);

  end;
end;

procedure TMainForm.TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.HasChildren then
  begin
    if Node.Expanded then
      Node.ImageIndex := 11
    else
      Node.ImageIndex := 12;
    Node.SelectedIndex := 12;
  end
  else
  begin
    Node.ImageIndex := 118;
    Node.SelectedIndex := 118;
  end;
end;

// Save image as...
procedure TMainForm.Saveimageas1Click(Sender: TObject);
begin
  ImageEnView1.IO.SaveToFile( ImageEnView1.IO.ExecuteSaveDialog() );
end;

end.
