unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, iewia, imageenio, ComCtrls, ExtCtrls,
  Menus;

type
  TMainForm = class(TForm)
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    TreeView1: TTreeView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    SelectCamera1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label11: TLabel;
    ImageEnView2: TImageEnView;
    Button1: TButton;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure FormActivate(Sender: TObject);
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
    procedure Exit1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure SelectCamera1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FillFileNames;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// fill tree view
procedure TMainForm.FillFileNames;
begin
  TreeView1.Items.Clear;
  ImageEnView1.IO.WIAParams.FillTreeView(TreeView1.Items,false);
  TreeView1.FullExpand;
end;

// try to fill file names at startup
procedure TMainForm.FormActivate(Sender: TObject);
begin
  FillFileNames;
end;

// selected a file, load it
procedure TMainForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin

  // What this? This gets the image from the camera and save it without load the jpeg. This means the image doesn't lose quality.
  // Warning: here we assume your camera store images using JPEG file format!
  if CheckBox1.Checked then
    ImageEnView1.IO.WiAParams.SaveTransferBufferAs:=Node.Text+'.jpg'
  else
    ImageEnView1.IO.WiAParams.SaveTransferBufferAs:='';

  ImageEnView1.IO.WiaParams.GetItemThumbnail( TIEWiaItem(Node.Data), ImageEnView2.IEBitmap );
  ImageEnView2.Update;


  if CheckBox2.Checked then
  begin
    // Get Image
    ImageEnView1.IO.WIAParams.ProcessingBitmap := ImageEnView1.IEBitmap;
    ImageEnView1.IO.WIAParams.Transfer( TIEWiaItem(Node.Data) , false);
    ImageEnView1.Update;

    // fill EXIF samples frame
    with ImageEnView1.IO.Params do
    begin
      Label4.Caption := EXIF_Make;
      Label6.Caption := EXIF_Model;
      Label8.Caption := EXIF_DateTime;
      Label10.Caption := IntToStr(EXIF_ExifImageWidth)+' x '+IntToStr(EXIF_ExifImageHeight);
    end;
  end;

end;

// update progress bar
procedure TMainForm.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position:=per;
end;

// File | Close
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Save
procedure TMainForm.Save1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    ImageEnView1.IO.SaveToFile( ExecuteSaveDialog('','',false,0,'') );
end;

// File | Print
procedure TMainForm.Print1Click(Sender: TObject);
begin
  ImageEnView1.IO.DoPrintPreviewDialog(iedtDialog,'',false,'');
end;

// Select camera (WIA source)
procedure TMainForm.SelectCamera1Click(Sender: TObject);
begin
  ImageEnView1.IO.SelectAcquireSource(ieaWIA);
  FillFileNames;
end;

// Delete selected image (item)
procedure TMainForm.Button1Click(Sender: TObject);
begin
  ImageEnView1.IO.WiaParams.DeleteItem( TIEWiaItem(TreeView1.Selected.Data) );
  FillFileNames;
end;

end.
