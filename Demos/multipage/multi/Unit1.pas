 unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IEMIO, StdCtrls, ImageEnView, IEMView, ImageEnIO, Buttons, ImageEnProc,
  ComCtrls, ExtCtrls, IEOpenSaveDlg, hyiedefs, ieview, hyieutils, Menus, printers, imageen,
  ActnList;

type
  TForm1 = class(TForm)
    ImageEnMView1: TImageEnMView;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    CheckBox3: TCheckBox;
    GroupBox3: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    OpenImageEnDialog1: TOpenImageEnDialog;
    OpenImageEnDialog2: TOpenImageEnDialog;
    SaveImageEnDialog1: TSaveImageEnDialog;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Scanner1: TMenuItem;
    Selectsource1: TMenuItem;
    Acquirepages1: TMenuItem;
    Edit5: TMenuItem;
    Clear1: TMenuItem;
    N2: TMenuItem;
    Openmodeless1: TMenuItem;
    Closemodeless1: TMenuItem;
    Insert1: TMenuItem;
    Append1: TMenuItem;
    Delete1: TMenuItem;
    N3: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Image1: TMenuItem;
    Load1: TMenuItem;
    Effects1: TMenuItem;
    Label4: TLabel;
    Button16: TButton;
    Button15: TButton;
    CheckBox4: TCheckBox;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Edit4: TEdit;
    UseWIAinterface1: TMenuItem;
    CheckBox5: TCheckBox;
    N4: TMenuItem;
    Print1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    OpenfromURL1: TMenuItem;
    ActionList1: TActionList;
    procedure SpeedButton2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Selectsource1Click(Sender: TObject);
    procedure Acquirepages1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Openmodeless1Click(Sender: TObject);
    procedure Closemodeless1Click(Sender: TObject);
    procedure Insert1Click(Sender: TObject);
    procedure Append1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Effects1Click(Sender: TObject);
    procedure UseWIAinterface1Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ImageEnMView1Progress(Sender: TObject; per: Integer);
    procedure OpenfromURL1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


// Play
procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  imageenmview1.playing := SpeedButton2.Down;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    ImageEnMView1.StoreType := ietThumb
  else
    ImageEnMView1.StoreType := ietNormal;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  ImageEnMView1.VisibleSelection := CheckBox2.Checked;
end;

// Grid columns
procedure TForm1.Edit1Change(Sender: TObject);
begin
  ImageEnMView1.GridWidth := strtointdef(edit1.text, 0);
end;

// Auto
procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if checkbox3.checked then
  begin
    edit1.enabled := false;
    ImageEnMView1.GridWidth := -1;
  end
  else
  begin
    edit1.enabled := true;
    ImageEnMView1.GridWidth := strtointdef(edit1.text, 0);
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Edit2.Text := IntToStr(ImageEnMView1.ThumbWidth);
  Edit3.Text := IntToStr(ImageEnMView1.ThumbHeight);
  ComboBox1.itemindex := 0;
  ImageEnMView1.GridWidth := -1;
  ImageEnMView1.EnableAlphaChannel := true;

  //ImageEnMView1.MIO.AutoAdjustDPI:=true;

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  ImageEnMView1.ThumbWidth := StrToIntDef(Edit2.Text, 0);
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
  ImageEnMView1.ThumbHeight := StrToIntDef(Edit3.Text, 0);
end;

// left frame
procedure TForm1.Button16Click(Sender: TObject);
begin
  ImageEnMView1.VisibleFrame := ImageEnMView1.VisibleFrame - 1;
end;

// right frame
procedure TForm1.Button15Click(Sender: TObject);
begin
  ImageEnMView1.VisibleFrame := ImageEnMView1.VisibleFrame + 1;
end;

// "single image" checkbox
procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then
    ImageEnMView1.DisplayMode := mdSingle
  else
    ImageEnMView1.DisplayMode := mdGrid;
end;

// changes transition duration
procedure TForm1.Edit4Change(Sender: TObject);
begin
  ImageEnMView1.TransitionDuration := strtointdef(edit4.text, 1000);
end;

// changes transition
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  ImageEnMView1.TransitionEffect := TIETransitionType(ComboBox1.ItemIndex);
end;

// menu - exit
procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;

// menu - File | open...
procedure TForm1.Open1Click(Sender: TObject);
var
  idx: integer;
begin
  if OpenImageEnDialog2.Execute then
  begin
    ImageEnMView1.Deselect; // to append images
    ImageEnMView1.MIO.LoadFromFileAuto(OpenImageEnDialog2.FileName);
    for idx := 0 to ImageEnMView1.ImageCount - 1 do
    begin
      ImageEnMView1.ImageTopText[idx].Caption := 'Frame ' + inttostr(idx);
      ImageEnMView1.ImageInfoText[idx].Caption := inttostr(ImageEnMView1.ImageWidth[idx]) + ' x ' + inttostr(ImageEnMView1.ImageHeight[idx]);
      ImageEnMView1.ImageBottomText[idx].Caption := ExtractFileName(OpenImageEnDialog2.FileName);
      ImageEnMView1.ImageBottomText[idx].Background := $00E8FFFF;
    end;
  end;
end;

// menu, File | save...
procedure TForm1.Save1Click(Sender: TObject);
begin
  if SaveImageEnDialog1.Execute then
    ImageEnMView1.MIO.SaveToFile(SaveImageEnDialog1.FileName);
end;

// menu, Scanner | select source...
procedure TForm1.Selectsource1Click(Sender: TObject);
begin
  if UseWIAinterface1.Checked then
    ImageEnMView1.MIO.SelectAcquireSource(ieaWIA)
  else
    ImageEnMView1.MIO.SelectAcquireSource(ieaTWain);
end;

// menu, scanner | acquire pages
procedure TForm1.Acquirepages1Click(Sender: TObject);
begin
  ImageEnmview1.Deselect;
  if UseWIAinterface1.Checked then
  begin
    ImageEnMView1.MIO.WIAParams.ShowAcquireDialog(false); // show the scanner dialog (Remove if you don't want it)
    ImageEnMView1.MIO.Acquire(ieaWIA);
  end
  else
  begin
    //ImageEnMView1.MIO.TWainParams.VisibleDialog:=false;
    //ImageEnMView1.MIO.TWainParams.ProgressIndicators:=false;
    ImageEnMView1.MIO.TWainParams.FeederEnabled := true;
    ImageEnMView1.MIO.TWainParams.AutoFeed := true;
    ImageEnMView1.MIO.TWainParams.DuplexEnabled := false;
    ImageEnMView1.MIO.Acquire(ieaTWain);
  end;
end;

// menu, edit | clear
procedure TForm1.Clear1Click(Sender: TObject);
begin
  ImageEnMView1.Clear;
end;

// menu, scanner | open modeless
procedure TForm1.Openmodeless1Click(Sender: TObject);
begin
  ImageEnMView1.MIO.AcquireOpen;
end;

// menu, scanner | close modeless
procedure TForm1.Closemodeless1Click(Sender: TObject);
begin
  ImageEnMView1.MIO.AcquireClose;
end;

// menu, edit | insert
procedure TForm1.Insert1Click(Sender: TObject);
var
  tempbmp: TBitmap;
  idx: integer;
begin
  idx := ImageEnMView1.SelectedImage;
  if idx < 0 then
    idx := 0;
  ImageEnMView1.InsertImage(idx);
  tempbmp := TBitmap.create;
  tempbmp.width := ImageEnMView1.ThumbWidth;
  tempbmp.height := ImageEnMView1.ThumbHeight;
  tempbmp.pixelformat := pf24bit;
  ImageEnMView1.SetImage(idx, tempbmp);
  tempbmp.free;
end;

// menu, edit | append
procedure TForm1.Append1Click(Sender: TObject);
var
  tempbmp: TBitmap;
  idx: integer;
begin
  idx := ImageEnMView1.AppendImage;
  tempbmp := TBitmap.create;
  tempbmp.width := ImageEnMView1.ThumbWidth;
  tempbmp.height := ImageEnMView1.ThumbHeight;
  tempbmp.pixelformat := pf24bit;
  ImageEnMView1.SetImage(idx, tempbmp);
  tempbmp.free;
end;

// menu, edit | delete
procedure TForm1.Delete1Click(Sender: TObject);
begin
  if ImageEnMView1.SelectedImage >= 0 then
    ImageEnMView1.DeleteSelectedImages;
  //ImageEnMView1.DeleteImage( ImageEnMView1.SelectedImage );
end;

// menu, edit | copy
procedure TForm1.Copy1Click(Sender: TObject);
begin
  ImageEnMView1.Proc.CopyToClipboard(true);
end;

// menu, edit | paste
procedure TForm1.Paste1Click(Sender: TObject);
begin
  ImageEnMView1.Proc.PasteFromClipboard;
end;

// menu, image | load
procedure TForm1.Load1Click(Sender: TObject);
var
  idx: integer;
begin
  if OpenImageEnDialog1.Execute then
  begin
    idx := ImageEnMView1.SelectedImage;
    if idx>-1 then
    begin
      ImageEnMView1.SetImageFromFile(idx, OpenImageEnDialog1.FileName);
      ImageEnMView1.ImageInfoText[idx].Caption := inttostr(ImageEnMView1.ImageWidth[idx]) + ' x ' + inttostr(ImageEnMView1.ImageHeight[idx]);
      ImageEnMView1.ImageBottomText[idx].Caption := ExtractFileName(OpenImageEnDialog1.FileName);
    end;
  end;
end;

// menu, image | effects
procedure TForm1.Effects1Click(Sender: TObject);
begin
  ImageEnMView1.Proc.DoPreviews([peAll]);
end;

procedure TForm1.UseWIAinterface1Click(Sender: TObject);
begin
  UseWIAinterface1.Checked := not UseWIAinterface1.Checked;
end;

// softshadow
procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  ImageEnMView1.SoftShadow.Enabled := CheckBox5.Checked;
  ImageEnMView1.Update;
end;

// File|Print
procedure TForm1.Print1Click(Sender: TObject);
begin
  imageenmview1.mio.DoPrintPreviewDialog('',false,'Print preview');
end;

// MoveUp
procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnMView1.MoveImage( ImageEnMView1.SelectedImage, ImageEnMView1.SelectedImage-1 );
end;

// Move Down
procedure TForm1.Button2Click(Sender: TObject);
begin
  ImageEnMView1.MoveImage( ImageEnMView1.SelectedImage, ImageEnMView1.SelectedImage+1 );
end;

procedure TForm1.ImageEnMView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position:=per;
end;

// Open From URL
procedure TForm1.OpenfromURL1Click(Sender: TObject);
begin
  ImageEnMView1.MIO.LoadFromURL( InputBox('Load From URL','Insert URL','http://') ); // you can also use LoadFromFile
end;


end.
