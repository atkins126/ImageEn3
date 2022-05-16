unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImageEnView, IEMView, StdCtrls, ImageEnIO, ComCtrls, ieview, hyiedefs,
  ExtCtrls, ieopensavedlg, FileCtrl, AppEvnts;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    ImageEnMView1: TImageEnMView;
    StatusBar1: TStatusBar;
    ImageEnView1: TImageEnView;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Splitter1: TSplitter;
    CheckBox6: TCheckBox;
    Button1: TButton;
    CheckBox7: TCheckBox;
    DebugTimer: TTimer;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    CheckBox8: TCheckBox;
    Panel1: TPanel;
    ColorDialog1: TColorDialog;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure ImageEnMView1BeforeImageDraw(Sender: TObject; idx, Left,
      Top: Integer; Canvas: TCanvas);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure ImageEnMView1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DebugTimerTimer(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

//

//(*
procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
  ImageEnMView1.Clear;
  ImageEnMView1.FillFromDirectory(DirectoryListBox1.Directory);
  //
  ImageEnMView1.SelectedImage := 0;
  if CheckBox6.Checked then
    ImageEnView1.io.LoadFromFile(ImageEnMView1.ImageFileName[0]);
end;
//*)

(*
// this is another way using FindFirst and FindNext:
procedure TForm1.DirectoryListBox1Change(Sender: TObject);
var
 sr:TSearchRec;
   Found,idx:integer;
   fpath:string;
begin
  ImageEnMView1.Clear;
  ImageEnMView1.LockPaint;
  Found:=FindFirst(DirectoryListBox1.Directory+'\*.*',faArchive,sr);
  if Found=0 then
  begin
    while Found=0 do
    begin
      fpath:=DirectoryListBox1.Directory+'\'+sr.Name;
      if IsKnownFormat(fpath) then
      begin
        idx:=ImageEnMView1.AppendImage;
        ImageEnMView1.ImageFileName[idx]:=fpath;
        //ImageEnMView1.ImageTopText[idx].Caption:=inttostr(idx);
        ImageEnMView1.ImageBottomText[idx].Caption:=extractfilename(fpath);
        ImageEnMView1.ImageBottomText[idx].Background:=$00EFEFD0;
      end;
      //
      Found:=FindNext(sr);
    end;
    FindClose(sr);
  end;
  imageEnMView1.UnLockPaint;
  //
  ImageEnMView1.SelectedImage:=0;
  if CheckBox6.Checked then
    ImageEnView1.io.LoadFromFile( ImageEnMView1.ImageFileName[0] );
end;
//*)

procedure TForm1.ImageEnMView1BeforeImageDraw(Sender: TObject; idx, Left,
  Top: Integer; Canvas: TCanvas);
begin
  ImageEnMView1.ImageInfoText[idx].Caption := inttostr(ImageEnMView1.ImageOriginalWidth[idx]) + ' x ' +
    inttostr(ImageEnMView1.ImageOriginalHeight[idx]) + ' x ' +
    inttostr(ImageEnMView1.ImageBitCount[idx]);
  ImageEnMView1.ImageInfoText[idx].Background:=clYellow;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin

  //IEFileFormatRemove(ioRAW);
  //IEAddExtIOPlugIn('dcrawlib.dll');

  ImageEnView1.GradientEndColor := clGray;

  ImageEnMView1.EnableAlphaChannel := true;
  ImageEnMView1.ShowText := false;
  ImageenMView1.SoftShadow.Enabled := true;
  ImageEnMView1.WallPaper.LoadFromFile(extractfilepath(paramstr(0)) + 'wallpaper.bmp');
  ImageEnMView1.FillThumbnail := false;
  //ImageEnMView1.EnableAdjustOrientation := true;  // enable if you want ImageEn adjust orientation

  //ImageEnMView1.ThreadPoolSize:=0;	// uncomment if you want monotasking load

  //ImageEnMView1.EnableLoadEXIFThumbnails:=false;  // disable EXIF loading

  DirectoryListBox1Change(self);
end;

procedure TForm1.ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
begin
  if CheckBox6.Checked then
    ImageEnView1.io.LoadFromFile(ImageEnMView1.ImageFileName[idx]);
end;

// Thumbnails

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  imageenmview1.visible := checkbox1.Checked;
end;

// softshadow

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  ImageEnMView1.SoftShadow.Enabled := CheckBox2.Checked;
  ImageEnMView1.Update;
end;

// flat style

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
  begin
    ImageEnMView1.Style := iemsFlat;
    ImageEnMView1.FillThumbnail := false;
  end
  else
  begin
    ImageEnMView1.Style := iemsACD;
    ImageEnMView1.FillThumbnail := true;
  end;
end;

// wall paper

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then
    ImageEnMView1.WallPaper.LoadFromFile(extractfilepath(paramstr(0)) + 'wallpaper.bmp')
  else
  begin
    ImageEnMView1.WallPaper := nil;
  end;
  ImageEnMView1.Update;
end;

// show text

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  ImageEnMView1.ShowText := CheckBox5.Checked;
end;

// Preview

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  ImageEnView1.Visible := CheckBox6.Checked;
end;

function xcompare(i1, i2: integer): integer;
var
  s1, s2: integer;
begin
  with Form1.ImageEnMView1 do
  begin
    s1 := ImageOriginalWidth[i1] * ImageOriginalHeight[i1];
    s2 := ImageOriginalWidth[i2] * ImageOriginalHeight[i2];
  end;
  if s1 < s2 then
    result := -1
  else if s1 > s2 then
    result := 1
  else
    result := 0;
end;

// Sort By Size

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
  tempIO:TImageEnIO;
begin
  // ImageEn loads images only when them are needed. So we have to all fill image properties before sort.
  tempIO:=TImageEnIO.Create(nil);
  for i:=0 to ImageEnMView1.ImageCount-1 do
  begin
    tempIO.ParamsFromFile( ImageEnMView1.ImageFileName[i] );
    ImageEnMView1.MIO.Params[i].Assign( tempIO.Params );
  end;
  tempIO.free;

  ImageEnMView1.Sort(xcompare);
end;

// Thumbnails rounded

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  if CheckBox7.Checked then
    ImageEnMView1.ThumbsRounded := 4
  else
    ImageEnMView1.ThumbsRounded := 0;
  ImageEnMView1.Update;
end;

procedure TForm1.ImageEnMView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  idx: integer;
begin
  idx := ImageEnMView1.ImageAtPos(x, y);
  ImageEnMView1.Hint := ImageEnMView1.ImageFileName[idx];
end;

procedure TForm1.DebugTimerTimer(Sender: TObject);
begin
  label3.caption:=inttostr(imageenmview1.jobsrunning);
  label4.caption:=inttostr(imageenmview1.jobswaiting);
end;

// internal border
procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  ImageEnMView1.ThumbnailsInternalBorder:=CheckBox8.Checked;
end;

// Select Internal Border Color
procedure TForm1.Panel1Click(Sender: TObject);
begin
  ColorDialog1.Color:=ImageEnMView1.ThumbnailsInternalBorderColor;
  if ColorDialog1.Execute then
  begin
    ImageEnMView1.ThumbnailsInternalBorderColor:=ColorDialog1.Color;
    Panel1.Color:=ColorDialog1.Color;
  end;
end;


// look ahead (load next N non visible images)
procedure TForm1.CheckBox9Click(Sender: TObject);
begin
  if CheckBox9.Checked then
  begin
    ImageEnMView1.LookAhead:=15;
    ImageEnMView1.Update;
  end
  else
    ImageEnMView1.LookAhead:=0;
end;

// border shadow
procedure TForm1.CheckBox10Click(Sender: TObject);
begin
  if CheckBox10.Checked then
  begin
    CheckBox3.Checked:=false;
    ImageEnMView1.Style := iemsACD;
    ImageEnMView1.FillThumbnail := true;
    ImageEnMView1.ThumbnailsBackgroundStyle:=iebsSoftShadow;
    ImageEnMView1.HorizBorder:=12;
    ImageEnMView1.VertBorder:=12;
  end
  else
  begin
    ImageEnMView1.ThumbnailsBackgroundStyle:=iebsSolid;
    ImageEnMView1.HorizBorder:=4;
    ImageEnMView1.VertBorder:=4;
  end;
end;

end.
